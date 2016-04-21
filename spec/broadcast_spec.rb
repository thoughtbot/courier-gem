require "spec_helper"

module Courier
  describe Broadcast do
    it "is sent when status_code is 200" do
      broadcast = Broadcast.new(channel: "channel",
                                payload: {},
                                status_code: 200)

      expect(broadcast).to be_sent
    end

    it "is not sent when status_code is not 200" do
      broadcast = Broadcast.new(channel: "channel",
                                payload: {},
                                status_code: 401)

      expect(broadcast).to_not be_sent
    end
  end
end
