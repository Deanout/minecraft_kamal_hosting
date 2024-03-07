class CommandsController < ApplicationController
  before_action :set_command, only: %i[ show edit update destroy ]

  # GET /commands or /commands.json
  def index
    @commands = Command.all
  end

  # GET /commands/1 or /commands/1.json
  def show
  end

  # GET /commands/new
  def new
    @command = Command.new
  end

  # GET /commands/1/edit
  def edit
  end

  # POST /commands or /commands.json
  def create
    @command = Command.new(command_params)


    respond_to do |format|
      if @command.save
        RconClient.instance.execute(@command.body)
        format.html { redirect_to command_url(@command), notice: "Command was successfully created." }
        format.json { render :show, status: :created, location: @command }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @command.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /commands/1 or /commands/1.json
  def update
    respond_to do |format|
      if @command.update(command_params)
        format.html { redirect_to command_url(@command), notice: "Command was successfully updated." }
        format.json { render :show, status: :ok, location: @command }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @command.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /commands/1 or /commands/1.json
  def destroy
    @command.destroy!

    respond_to do |format|
      format.html { redirect_to commands_url, notice: "Command was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_command
      @command = Command.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def command_params
      params.require(:command).permit(:body)
    end

    def create_command_execute_file(command_to_run, file_name)
      # Create the flag file
      if Rails.env.development?
        data_directory = Rails.root.join('data')
        File.write("#{data_directory}/#{file_name}", command_to_run, mode: 'a')
      else
        File.write("/data/#{file_name}", command_to_run, mode: 'a')
      end
    end
end
