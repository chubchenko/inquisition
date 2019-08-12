namespace :inquisition do
  desc 'Run Inquisition'
  task run: :environment do
    Inquisition::Collector.new.call
  end
end
