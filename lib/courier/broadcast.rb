module Courier
  class Broadcast
    attr_reader :status_code

    def initialize(channel:, payload:, status_code:)
      @channel = channel
      @payload = payload
      @status_code = status_code
    end

    def sent?
      status_code == 200
    end

    def ==(other)
      self.class == other.class &&
        channel == other.channel &&
        payload == other.payload &&
        status_code == other.status_code
    end

    protected

    attr_reader :channel, :payload
  end
end
