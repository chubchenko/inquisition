# :reek:LongParameterList
# :reek:NestedIterators
# :reek:TooManyStatements
# :reek:DuplicateMethodCall
# :reek:FeatureEnvy
# :reek:UtilityFunction
# :reek:RepeatedConditional
# :reek:UncommunicativeMethodName
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  # rubocop:disable Style/IfInsideElse
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def test_flog(name = '')
    if name.is_a?(Hash)
      values = name['VALUES']
      name = name['NAME']
    end
    values.collect do |value|
      if value.is_a?(String)
        (checkbox(name, value) + value)
      else
        if value[(value.size - 1)] == true
          checkbox(name, value[0], true) + value[(value.size - 2)]
        else
          checkbox(name, value[0]) + value[(value.size - 1)]
        end
      end
    end.to_s
  end
  # rubocop:enable Style/IfInsideElse
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def test_flay_1(name = '')
    return name unless name.is_a?(Hash)

    name['VALUES']
    name['NAME']
  end

  def test_flay_2(name = '')
    return name unless name.is_a?(Hash)

    name['VALUES']
    name['NAME']
  end
end
