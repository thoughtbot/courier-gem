require "spec_helper"
require "webmock/rspec"

describe Courier do
  describe "#broadcast" do
    it "sends the broadcast request" do
      channel = "Tést\n chännél"
      url = "https://courier.thoughtbot.com/broadcast/test-channel"
      api_token = "token"
      stub = stub_request(:post, url).with(
        headers: {
          "Accept": "application/json version=1",
          "Content-Type": "application/json",
          "Authorization": "Token token=\"#{api_token}\"",
        },
        body: { broadcast: {
          payload: {
            "alert": "Hello from Courier",
            "badge": "1",
          },
        },
      })

      courier = Courier::Client.new(api_token: api_token)
      courier.broadcast(channel, alert: "Hello from Courier", badge: "1")

      expect(stub).to have_been_requested
    end

    it "returns a Broadcast model" do
      stub_request(:post, "https://courier.thoughtbot.com/broadcast/channel").
        to_return(status: 200)

      courier = Courier::Client.new(api_token: "token")
      payload = { alert: "Hello from Courier" }
      broadcast = courier.broadcast("channel", payload)

      expect(broadcast).to eq(Courier::Broadcast.new(channel: "channel",
                                                     payload: payload,
                                                     status_code: 200))
    end
  end
end
