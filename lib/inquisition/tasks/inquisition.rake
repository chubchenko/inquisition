desc 'Run Inquisition'
task inquisition: :environment do
  Inquisition::Collector.new.call
end
