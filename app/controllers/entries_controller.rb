class EntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_entry, only: [ :show, :edit, :update, :destroy ]

  def index
    @entries = current_user.entries.order(created_at: :desc)
    @shared_entries = current_user.shared_entries.order(created_at: :desc)
  end

  def show
    @comment = Comment.new
    @comments = @entry.comments.includes(:user).order(created_at: :asc)
  end

  def new
    @entry = current_user.entries.new
  end

  def create
    @entry = current_user.entries.new(entry_params)

    if @entry.save
      redirect_to entries_path, notice: "Journal entry created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    unless @entry.user == current_user
      redirect_to entries_path, alert: "You cannot edit a shared journal."
    end
  end

  def update
    unless @entry.user == current_user
      redirect_to entries_path, alert: "You cannot edit a shared journal."
      return
    end

    if @entry.update(entry_params)
      redirect_to entry_path(@entry), notice: "Journal entry updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    unless @entry.user == current_user
      redirect_to entries_path, alert: "You cannot delete a shared journal."
      return
    end

    @entry.destroy
    redirect_to entries_path, notice: "Journal entry deleted successfully!"
  end

  private

  def set_entry
    @entry = Entry.find(params[:id])

    unless @entry.user == current_user ||
           @entry.shared_users.include?(current_user)
      redirect_to entries_path, alert: "You do not have access to this journal."
    end
  end

  def entry_params
    params.require(:entry).permit(:title, :content, :mood, :photo)
  end
end
