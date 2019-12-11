module Helpers
  module GemInfoHelper
    def gem_info(outdated: false)
      {
        bundler: Gem::Dependency.new("puma", Gem::Requirement.new(["~> 3.11"]), :runtime),
        rubygems: {
          name: 'puma',
          version: outdated ? '10' : '4.3.1',
          version_downloads: 178481,
          platform: 'ruby',
          info: "Puma is a simple, fast, threaded, and highly concurrent HTTP 1.1 server for Ruby/Rack applications. Puma is intended for use in both development and production environments. It's great for highly concurrent Ruby implementations such as Rubinius and JRuby as well as as providing process worker support to support CRuby well",
          gem_uri: 'https://rubygems.org/gems/puma-4.3.1.gem',
          homepage_uri: 'http://puma.io'
        }.stringify_keys
      }
    end

    private

    def outdated

    end
  end
end
