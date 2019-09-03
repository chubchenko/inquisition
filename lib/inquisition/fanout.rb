module Inquisition
  class Fanout
    def initialize
      @listeners = Hash.new do |memo, event|
        memo[event] = Set.new
      end

      @default = -> {}
      @setup = false
    end

    def register_listener(outputter, *events)
      events.each do |event|
        @listeners[event.to_sym] << outputter
      end

      true
    end

    def around
      start

      begin
        issues = yield self if block_given?
      ensure
        stop(issues || [])
      end
    end

    def example_passed(*)
      broadcast(:example_passed)
    end

    def example_failed(*)
      broadcast(:example_failed)
    end

    # @private
    def prepare_default(loader)
      @default = -> { loader.setup_default }
    end

    # @private
    def listeners_for(event)
      @listeners[event]
    end

    private

    def start
      broadcast(:start)
    end

    def stop(_issues)
      broadcast(:stop)
    end

    def broadcast(event, _payload = NullPayload.new)
      ensure_default_ready

      listeners_for(event).each do |outputter|
        outputter.__send__(event)
      end
    end

    def ensure_default_ready
      return if @setup

      @default.call
    end
  end

  class NullPayload
  end
end
