require 'zip'

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
    # Get the latest mod with an attachment
    mod = Mod.joins(:zip_attachment).order('created_at DESC').first

    shared_volume_path = Rails.root.join('shared_volume')

    # Get the mod's zip file attachment
    redirect_to rails_blob_url(mod.zip)
  end

  def test_stuff
    # Put stuff in the data volume to see if it's the same one
    # Recreate the mods directory
    mods_directory = ""
    if Rails.env.development?
      mods_directory = Rails.root.join('data', 'mods')
    else
      mods_directory = "/data/mods"
    end
    if File.directory?(mods_directory)
      FileUtils.remove_dir(mods_directory, force = false)
    end
    FileUtils.mkdir(mods_directory)
    mod = Mod.joins(:zip_attachment).order('created_at DESC').first
    zip_blob_path = mod.zip.blob.service.path_for(mod.zip.key)
    Zip::File.open(zip_blob_path) do |file|
      file.each do |entry|
        entry.extract("#{mods_directory}/#{entry.name}")
      end
    end

    # Create the flag file

    # Extract zip file to /data/mods
    # if Rails.env.development?
    #   File.open('test.txt', 'w') { |file| file.write('Hello, world!') }
    # else
    #   File.open('/data/test.txt', 'w') { |file| file.write('Hello, world!') }
    # end
  end
end
