require 'cucumber/formatter/io'
require 'cucumber/html_formatter'
require 'cucumber/formatter/message_builder'

module Cucumber
  module Formatter
    class HTML < MessageBuilder
      include Io

      def initialize(config)
        @io = ensure_io(config.out_stream)
        @html_formatter = Cucumber::HTMLFormatter::Formatter.new(@io)
        @html_formatter.write_pre_message

        super(config)
      end

      def output_envelope(envelope)
        @html_formatter.write_message(envelope)
        if envelope.test_run_finished
          @html_formatter.write_post_message
          @io.flush
          @io.close
        end
      end
    end
  end
end
