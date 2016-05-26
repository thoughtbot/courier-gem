require "faraday_middleware"
require "active_support/inflector"

module Courier

  # Client object manages authenticating and communicating with the Courier API.
  class Client

    # The Courier API base URL.
    # @private_constant
    DEFAULT_BASE_URL = "https://courier.thoughtbot.com".freeze

    # Create a Client configured with an app's `api_token` and an `environment`.
    #
    # @param [String] api_token
    #        The app's API token for authenticating with the Courier API.
    #
    # @param [:development, :production] environment
    #        environment to use when communicating with the Courier API. Use
    #        `:development` when interacting with an app signed with a
    #        development certificate. Use `production` when an app is signed
    #        with a distribution certificate.
    #
    # @param [String] base_url
    #        The base_url to connect to. Primarily used for testing purposes.
    #        You should not have to change this.
    #
    # Example
    #
    # Courier::Client.new(api_token: "[YOUR API_TOKEN]", environment:
    # :development)
    #
    # @return [Client] A new Client instance
    def initialize(api_token:, environment:, base_url: DEFAULT_BASE_URL)
      @api_token = api_token
      @base_url = base_url
      @environment = environment
    end

    # Send a notification to all devices registered with a channel
    #
    # @param [String] channel
    #        name of the channel. Names are automatically parameterized
    #        using
    #        [ActiveSupport::Inflector](http://apidock.com/rails/ActiveSupport/Inflector).
    #
    # @param {String: String, Hash, Array} payload
    #        The
    #        [APNs](https://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Chapters/TheNotificationPayload.html#//apple_ref/doc/uid/TP40008194-CH107-SW1)
    #        payload to broadcast.
    #        See [lowdown](http://www.rubydoc.info/gems/lowdown/Lowdown%2FNotification%3Aformatted_payload)
    #        documentation for more information on how the payload is processed.
    #
    # @return [Broadcast] a broadcast instance.
    #
    # @see http://apidock.com/rails/ActiveSupport/Inflector/parameterize
    # @see http://www.rubydoc.info/gems/lowdown/Lowdown%2FNotification%3Aformatted_payload
    # @see https://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Chapters/TheNotificationPayload.html#//apple_ref/doc/uid/TP40008194-CH107-SW1
    #
    def broadcast(channel, payload)
      response = http.post("/broadcast/#{channel.parameterize}",
                           broadcast: { payload: payload })
      Broadcast.new(channel: channel,
                    payload: payload,
                    status_code: response.status)
    end

    private

    attr_reader :api_token, :base_url, :environment

    # Make authenticated requests to the Courier API.
    #
    # @return [Faraday::Connection]
    #         a Faraday::Connection configured to authenticate and communicate
    #         with the Courier API.
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
