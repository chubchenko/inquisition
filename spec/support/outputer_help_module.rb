module OutputerHelpModule
  def silence_output
    @original_stderr = $stderr
    @original_stdout = $stdout
    $stderr = empty_file
    $stdout = empty_file
  end

  def enable_output
    $stderr = @original_stderr
    $stdout = @original_stdout
    @original_stderr
    @original_stdout
  end

  private

  def empty_file
    File.open(File::NULL, "w")
  end
end
