require "faraday_middleware"
require "active_support/inflector"

module Courier
  class Client
    URL = "https://courier.thoughtbot.com".freeze

    attr_reader :api_token
    def initialize(api_token:)
      @api_token = api_token
    end

    def broadcast(channel, payload)
      response = http.post("/broadcast/#{channel.parameterize}",
                           broadcast: { payload: payload })
      Broadcast.new(channel: channel,
                    payload: payload,
                    status_code: response.status)
    end

    private

    def http
      Faraday.new(url: URL) do |conn|
        conn.headers["Accept"] = "application/json version=1"
        conn.headers["Content-Type"] = "application/json"
        conn.request :json
        conn.token_auth api_token
        conn.adapter Faraday.default_adapter
      end
    end
  end
end
