module CLIHelpModule
  BASE_CONFIG_FILE_NAME = 'inquisition.yml'.freeze

  def create_base_config
    FileUtils.cp base_config_file, Dir.pwd, preserve: true, verbose: false
  end

  def remove_base_config
    remove_file(File.join(Dir.pwd, BASE_CONFIG_FILE_NAME))
  end

  def capture
    begin
      $stdout = StringIO.new
      yield
      result = $stdout.string
    end
    result
  end

  private

  def base_config_file
    File.join(Dir.pwd, 'lib', 'inquisition', 'utils', BASE_CONFIG_FILE_NAME)
  end

  def remove_file(file)
    FileUtils.rm_f file
  end
end
