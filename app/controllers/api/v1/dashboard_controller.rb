class Api::V1::DashboardController < ApplicationController

  def check_current_version
    # Get the last uploaded mod
    mod = Mod.last
    # Get the mod's version
    version = mod.version
    # Return the mod's version
    render json: { version: version }
  end

  def download_latest_mod
    # Get the last uploaded mod
    mod = Mod.last
    # Get the mod's zip file attachment
    redirect_to rails_blob_url(mod.zip)
  end
end
