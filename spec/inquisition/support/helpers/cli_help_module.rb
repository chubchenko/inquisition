module CLIHelpModule
  def create_base_config
    copy_file base_config_template_file, temp_folder
  end

  def remove_base_config
    remove_file(base_config_file)
  end

  def capture
    $stdout = StringIO.new
    yield
    $stdout.string
  end

  def temp_folder
    File.join(Dir.pwd, 'spec', 'inquisition', 'tmp')
  end

  def base_config_template_file
    File.join(Dir.pwd, 'lib', 'inquisition', 'utils', Inquisition::BaseConfig::CONFIG_FILE_NAME)
  end

  def base_config_file
    File.join(temp_folder, Inquisition::BaseConfig::CONFIG_FILE_NAME)
  end

  def remove_file(file)
    FileUtils.rm_f file
  end

  def copy_file(from, to)
    FileUtils.cp from, to, preserve: true, verbose: false
  end
end
