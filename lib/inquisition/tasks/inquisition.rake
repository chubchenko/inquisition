namespace :inquisition do
  desc 'Run Inquisition'
  task :execute do
    Inquisition::Collector.new.call
  end

  desc 'Print the version of the gem'
  task :version do
    puts Inquisition::Version
  end
end
