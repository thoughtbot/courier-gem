module Courier

  # A Broadcast instance reflects the state of a broadcast to a channel.
  #
  # Use `status_code` and `sent?` to determine the state of a broadcast.
  #
  # You do not create Broadcast instances directly. Instead, a Client creates
  # them for you to reflect the state of a broadcast it sent.
  class Broadcast

    # @return [Fixnum]  HTTP status code of the request.
    attr_reader :status_code

    # Create a Broadcast for a channel, payload and status code.
    #
    # @param [String] channel (see #channel)
    #
    # @param {String: String, Hash, Array} payload (see #payload)
    #
    # @param (Fixnum) status_code (see #status_code)
    #
    # @!visibility private
    def initialize(channel:, payload:, status_code:)
      @channel = channel
      @payload = payload
      @status_code = status_code
    end

    # Wether the broadcast was sent successfuly or not.
    # Note that delivery of notifications is a “best effort”. It is possible for
    # broadcast.sent? to return true, but no notification to be delivered.
    #
    # @return [Bool]
    #         true if the broadcast was sent to Courier, false otherwise.
    def sent?
      (200..299).cover?(status_code)
    end

    # Compare two Broadcast instance. Broadcasts are considered equal if their
    # `class`, `channel`, `payload` and `status_code` are equal.
    #
    # @param [Object] other
    #        the object to be compare to the receiver.
    #
    # @return [Bool]
    #          true if the receiver and `other` are equal, otherwise false.
    def ==(other)
      self.class == other.class &&
        channel == other.channel &&
        payload == other.payload &&
        status_code == other.status_code
    end

    protected

    # @return [String] channel the broadcast was sent too.
    attr_reader :channel

    # @return {String: String, Hash, Array}
    #         payload that was sent to the channel.
    attr_reader :payload
  end
end
