require "faraday_middleware"
require "active_support/inflector"

module Courier
  class Client
    DEFAULT_BASE_URL = "https://courier.thoughtbot.com".freeze

    def initialize(api_token:,
                   base_url: DEFAULT_BASE_URL,
                   environment: "production")
      @api_token = api_token
      @base_url = base_url
      @environment = environment
    end

    def broadcast(channel, payload)
      response = http.post("/broadcast/#{channel.parameterize}",
                           broadcast: { payload: payload })
      Broadcast.new(channel: channel,
                    payload: payload,
                    status_code: response.status)
    end

    private

    attr_reader :api_token, :base_url, :environment

    def http
      Faraday.new(url: base_url) do |conn|
        conn.headers["Accept"] = "application/json version=1"
        conn.headers["Content-Type"] = "application/json"
        conn.request :json
        conn.params["environment"] = environment
        conn.token_auth api_token
        conn.adapter Faraday.default_adapter
      end
    end
  end
end
