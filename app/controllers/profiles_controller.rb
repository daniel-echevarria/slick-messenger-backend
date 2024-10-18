class ProfilesController < ApplicationController
  def index
    profiles = Profile.all
    render json: profiles, status: :ok
  end

  def update
  end
end
