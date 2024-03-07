require "rcon"

# RconClient.instance.execute("ban deaniocom")
# RconClient.instance.execute("give deaniocom diamond 3")


class RconClient
  include Singleton

  def initialize(ignore_first_packet: false)
    @client = Rcon::Client.new(host:, port:, password:)
    @client.authenticate!(ignore_first_packet:)
  end

  def execute(command, expect_segmented_response: true, wait: 0.25)
    @client.execute(command, expect_segmented_response:, wait:)
  end

  private

  def host
    Rails.application.credentials.dig(:rcon_host) || "0.0.0.0"
  end

  def port
    Rails.application.credentials.fetch(:rcon_port) || 25575
  end

  def password
    Rails.application.credentials.fetch(:rcon_password) || "passsword"
  end
end
