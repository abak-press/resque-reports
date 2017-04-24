module Resque
  module Reports
    module Extensions
      module Config
        DEFAULT_QUEUE = :reports

        def initialize(values)
          @queue = values.delete(:queue) if values.is_a?(Hash)
          super
        end

        def queue
          @queue ||= DEFAULT_QUEUE
        end
      end
    end
  end
end
