require 'rspec/expectations'

RSpec::Matchers.define :have_output_message do |expected, line|
  match do |actual|
    output_line(actual, line) == expected
  end

  failure_message do |actual|
    "expected that output should include expected value
      output: #{output_line(actual, line)}
    expected: #{expected}"
  end

  private

  # :reek:NilCheck
  def output_line(output, line)
    output.lines[line || 0]&.chop&.gsub(/\e\[([;\d]+)?m/, '')
  end
end
