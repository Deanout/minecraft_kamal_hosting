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

  def test_mod
    # Get the latest mod with an attachment
    mod = Mod.find(params[:id])
    extract_zip_file_to_data_mods(mod)
    create_command_execute_file("", "pending_restart")

    # Get the mod's zip file attachment
    respond_to do |format|
      format.html { redirect_to mod, notice: 'Mod was successfully tested.' }
      format.json { render json: { message: "Tested mod with id: #{mod.id}" } }
    end
  end

  def test_latest
    mod = Mod.joins(:zip_attachment).order('created_at DESC').first

    extract_zip_file_to_data_mods(mod)
    create_command_execute_file("", "pending_restart")

    render json: { message: "Tested latest mod" }

    respond_to do |format|
      format.html { redirect_to mod, notice: 'Latest mod was successfully tested.' }
      format.json { render json: { message: "Tested latest mod" } }
    end
  end

  def command_test
    command_to_run = '/title @a title "AdMiN AbUsE"'
    file_name = "command_executor"
    create_command_execute_file(command_to_run, file_name)
  end

  private

  def test_params
    # Grab zip file based on param id?
    params.require(:mod).permit(:id)
  end

  def extract_zip_file_to_data_mods(mod)
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
    zip_blob_path = mod.zip.blob.service.path_for(mod.zip.key)
    Zip::File.open(zip_blob_path) do |file|
      file.each do |entry|
        entry.extract("#{mods_directory}/#{entry.name}")
      end
    end

  end
  def create_command_execute_file(command_to_run, file_name)
    # Create the flag file
    if Rails.env.development?
      data_directory = Rails.root.join('data')
      File.write("#{data_directory}/#{file_name}", command_to_run)
    else
      File.write("/data/#{file_name}", command_to_run)
    end
  end
end
