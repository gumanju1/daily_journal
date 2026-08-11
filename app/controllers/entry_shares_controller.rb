class EntrySharesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_entry

  def create
    user = User.find_by(email: params[:email])

    if user.nil?
      redirect_to entry_path(@entry), alert: "User not found."
      return
    end

    if user == current_user
      redirect_to entry_path(@entry), alert: "You cannot share an entry with yourself."
      return
    end

    @share = @entry.entry_shares.new(user: user)

    if @share.save
      redirect_to entry_path(@entry), notice: "Journal shared successfully!"
    else
      redirect_to entry_path(@entry), alert: "This journal is already shared with this user."
    end
  end

  def destroy
    share = @entry.entry_shares.find(params[:id])
    share.destroy

    redirect_to entry_path(@entry), notice: "Journal sharing removed."
  end

  private

  def set_entry
    @entry = current_user.entries.find(params[:entry_id])
  end
end
