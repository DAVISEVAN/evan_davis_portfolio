class GuestbookController < ApplicationController
  def index
    @entries = GuestbookEntry.all.order(created_at: :desc)
    @entry = GuestbookEntry.new
  end

  def create
    @entry = GuestbookEntry.new(guestbook_entry_params)
    if @entry.save
      flash[:notice] = "Thank you for signing the guestbook!"
      redirect_to guestbook_path
    else
      @entries = GuestbookEntry.all.order(created_at: :desc)
      flash.now[:alert] = "There was an error signing the guestbook."
      render :index
    end
  end

  private

  def guestbook_entry_params
    params.require(:guestbook_entry).permit(:name, :message)
  end
end
