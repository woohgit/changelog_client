require 'json'
require 'net/http'
require 'uri'

SEVERITY = {
  'INFO' => 1,
  'NOTIFICATION' => 2,
  'WARNING' => 3,
  'ERROR' => 4,
  'CRITICAL' => 5 }

API_HOST = 'localhost'
API_PORT = '5000'

class ChangelogClient
  def initialize(host = API_HOST, port = API_PORT)
    @host = host
    @port = port
    @endpoint = '/api/events'
  end

  def deflate_severity(severity)
    return severity if severity.is_a? Integer
    SEVERITY[severity]
  end

  # Sends a message to the Changelog server
  #
  # Example:
  #   >> client = ChangelogClient.new("host", "port")
  #   >> client.send("This is the message", "INFO", "Mycategory")
  #   => true
  #
  # Arguments:
  #   message: (String)
  #   severity: (String, Integer)
  #   category: (String)
  #   extra_headers: (Hash)
  def send(message, severity, category = 'misc', extra_headers = nil)
    http = Net::HTTP.new(@host, server_port)
    headers = {
      'User-Agent' => "ccp/client v.#{Gem.loaded_specs['changelog_client'].version.to_s}",
      'Content-Type' => 'application/json'
    }

    headers << extra_headers if extra_headers

    data = {
      'criticality' => deflate_severity(severity),
      'unix_timestamp' => ::Time.now.to_i,
      'category' => category,
      'description' => message
    }
    begin
      response = http.post(@endpoint, JSON.generate(data), headers)
      if response.body.include? '"OK"'
        return true
      else
        puts 'Failed to send changelog message to server'
        return false
      end
    rescue Exception => e
      puts "Failed to send changelog message to server: #{e.message}"
      return false
    end
  end

  def server_port
    if @port == 80
      nil
    else
      @port
    end
  end
end
