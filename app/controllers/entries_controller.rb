class EntriesController < ApplicationController
  def index
    @entries = Entry.all.order(created_at: :desc)
  end

  def new
    @entry = Entry.new
  end

  def create
  @entry = Entry.new(entry_params)
  @entry.user = current_user

  if @entry.save
    redirect_to entries_path, notice: "Journal entry created successfully!"
  else
    render :new, status: :unprocessable_entity
  end
end

  private

  def entry_params
    params.require(:entry).permit(:title, :content, :mood)
  end
end
