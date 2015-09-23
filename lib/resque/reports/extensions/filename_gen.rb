# coding: utf-8
module Resque
  module Reports
    module Extensions
      # Module that generates file name
      # Usage:
      #   class SomeClass
      #     include Resque::Reports::Extensions::FilenameGen
      #
      #     # ...call somewhere...
      #     fname = generate_filename(%w(a b c), 'pdf')
      #     # 'fname' value is something like this:
      #     #   "a60428ee50f1795819b8486c817c27829186fa40.pdf"
      #   end
      module FilenameGen

        DEFAULT_EXTENSION = 'txt'

        private

        def generate_filename(args, fextension)
          "#{ hash(self.class.to_s, *args) }.#{ fextension || DEFAULT_EXTENSION }"
        end

        def hash(*args)
          Digest::SHA1.hexdigest(obj_to_string(args))
        end

        def obj_to_string(obj)
          case obj
          when Hash
            s = []
            obj.keys.sort.each do |k|
              s << obj_to_string(k)
              s << obj_to_string(obj[k])
            end
            s.to_s
          when Array
            s = []
            obj.each { |a| s << obj_to_string(a) }
            s.to_s
          else
            obj.to_s
          end
        end
      end
    end
  end
end
