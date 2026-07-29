class EntriesController < ApplicationController
  before_action :authenticate_user

  def index
    @entries = current_user.entries.order(created_at: :desc)
  end

  def show
    @entry = current_user.entries.find(params[:id])
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
    @entry = current_user.entries.find(params[:id])
  end

  def update
    @entry = current_user.entries.find(params[:id])

    if @entry.update(entry_params)
      redirect_to entry_path(@entry), notice: "Journal entry updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def entry_params
    params.require(:entry).permit(:title, :content, :mood)
  end
end
