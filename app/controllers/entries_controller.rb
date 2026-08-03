class EntriesController < ApplicationController
  before_action :authenticate_user
  before_action :set_entry, only: [ :show, :edit, :update, :destroy ]

  def index
    @entries = current_user.entries.order(created_at: :desc)
  end

  def show
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
  end

  def update
    if @entry.update(entry_params)
      redirect_to entry_path(@entry), notice: "Journal entry updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @entry.destroy
    redirect_to entries_path, notice: "Journal entry deleted successfully!"
  end

  private

  def set_entry
    @entry = current_user.entries.find(params[:id])
  end

  def entry_params
    params.require(:entry).permit(:title, :content, :mood, :photo)
  end
end
