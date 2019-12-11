module Helpers
  module GemInfoHelper
    def gem_info(status: nil, environment: '', current_version: '4.7.1', latest_version: '4.7.1')
      {
        name: 'devise',
        homepage: 'https://github.com/plataformatec/devise',
        current_version: current_version,
        latest_version: latest_version,
        status: status,
        environment: environment
      }
    end
  end
end
