class EntriesController < ApplicationController
  # Limit actions to logged-in users only!
  #before_action :require_login, only: [:new, :create]

  def new
    @user = User.find_by({ "id" => session["user_id"] })
  end

  def create
    @user = User.find_by({ "id" => session["user_id"] })
    if @user != nil
      @entry = Entry.new
      @entry["title"] = params["title"]
      @entry["description"] = params["description"]
      @entry["occurred_on"] = params["occurred_on"]
      @entry["place_id"] = params["place_id"]
      @entry["user_id"] = @user["id"]
      if @entry.save
        if params["uploaded_image"] != nil
          @entry.uploaded_image.attach(params["uploaded_image"])
        end
      end
    else
      flash["notice"] = "Login first."
    end
    redirect_to "/places/#{@entry["place_id"]}"
  end

end