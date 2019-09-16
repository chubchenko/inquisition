require 'sprockets'
require 'fileutils'

ASSETS_DIR = File.join(Inquisition.root, 'assets')
PUBLIC_DIR = File.join(Rails.root, 'public', 'inquisition')
COMPILATED = ['application.js', 'application.css'].freeze

task assets_compilation: :environment do
  sprockets = Sprockets::Environment.new(Inquisition.root) do |env|
    env.logger = Inquisition.logger
  end

  sprockets.append_path(File.join(ASSETS_DIR, 'js'))
  sprockets.append_path(File.join(ASSETS_DIR, 'css'))

  COMPILATED.each do |file|
    assets = sprockets.find_asset(file)
    FileUtils.mkdir_p(File.join(PUBLIC_DIR))
    assets.write_to(File.join(PUBLIC_DIR, file))
  end
end
