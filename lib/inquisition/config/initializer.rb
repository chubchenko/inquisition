Dir[File.join(File.dirname(__FILE__), 'initializers', '*.rb')].each { |file| require file }
