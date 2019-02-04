require 'i18n'

I18n.load_path.concat Dir[File.expand_path(File.join(File.dirname(__dir__), 'locales') + '/*.yml')]
I18n.config.available_locales = :en
I18n.default_locale = :en
