class EntriesController < ApplicationController
  def index
    @entries = Entry.all.order(created_at: :desc)
  end

  def show
    @entry = Entry.find(params[:id])
  end

  def new
    @entry = Entry.new
  end

  def create
    @entry = Entry.new(entry_params)
    @entry.user = User.first

    if @entry.save
      redirect_to entries_path, notice: "Journal entry created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @entry = Entry.find(params[:id])
  end

  def update
    @entry = Entry.find(params[:id])

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
