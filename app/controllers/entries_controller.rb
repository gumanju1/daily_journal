class EntriesController < ApplicationController
  def index
    @entries = current_user.entries
  end

  def new
    @entry = Entry.new
  end

  def create
    @entry = current_user.entries.new(entry_params)

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
