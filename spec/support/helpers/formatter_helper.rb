module FormatterHelpModule
  def unparsed_data
    { some_data: [] }
  end

  def spended_time
    1.00
  end

  def structured_hash
    {
      errors: nil,
      error_count: nil,
      total_files: nil,
      special_info: nil,
      spended_time: spended_time
    }
  end
end
