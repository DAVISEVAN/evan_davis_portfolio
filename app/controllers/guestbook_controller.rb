class GuestbookController < ApplicationController
  before_action :check_and_store_admin_key
  before_action :check_admin_access, only: [:show]

  def index
    @entries = GuestbookEntry.all.order(created_at: :desc)
    @entry = GuestbookEntry.new
  end

  def show
    @entry = GuestbookEntry.find(params[:id])
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

  #  Accept the admin_key param from any action and store it
  def check_and_store_admin_key
    if params[:admin_key] == ENV["ADMIN_GUESTBOOK_KEY"]
      session[:admin] = true
      flash[:notice] = "🧙‍♂️ Wizard access granted."
    end
  end

  #  Protect sensitive actions
  def check_admin_access
    unless session[:admin]
      flash[:alert] = "Only a powerful Wizard can view messages."
      redirect_to guestbook_path
    end
  end
end
