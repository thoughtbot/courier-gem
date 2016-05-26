module Courier
  class Broadcast
    attr_reader :status_code

    def initialize(channel:, payload:, status_code:)
      @channel = channel
      @payload = payload
      @status_code = status_code
    end

    def sent?
      (200..299).cover?(status_code)
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
