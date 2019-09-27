module Inquisition
  module DeepSymbolizeKeys
    module_function

    def deep_symbolize_keys(hash)
      _deep_symbolize_keys_in_object(hash, &:to_sym)
    end

    def _deep_symbolize_keys_in_object(object, &block)
      case object
      when Hash
        object.each_with_object({}) do |(key, value), memo|
          memo[yield(key)] = _deep_symbolize_keys_in_object(value, &block)
        end
      when Array
        object.map { |value| _deep_symbolize_keys_in_object(value, &block) }
      else
        object
      end
    end

    private_class_method :_deep_symbolize_keys_in_object

    refine Hash do
      def deep_symbolize_keys
        DeepSymbolizeKeys.deep_symbolize_keys(self)
      end
    end
  end
end
