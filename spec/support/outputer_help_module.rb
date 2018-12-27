module OutputerHelpModule
  OUTPUT_FILE = File.join(Dir.pwd, 'spec/tmp/io.txt')

  def silence_output
    @original_stderr = $stderr
    @original_stdout = $stdout
    $stderr = open_output_file
    $stdout = open_output_file
  end

  def enable_output
    $stderr = @original_stderr
    $stdout = @original_stdout
    @original_stderr
    @original_stdout
  end

  private

  def open_output_file
    unless File.directory?(OUTPUT_FILE)
      FileUtils.mkdir_p(File.dirname(OUTPUT_FILE))
    end
    File.open(OUTPUT_FILE, 'w')
  end
end
