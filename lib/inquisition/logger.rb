module Inquisition
  class Logger
    def self.log(log)
      $stdout.puts(log) if Configuration.instance.verbose?
    end
  end
end
