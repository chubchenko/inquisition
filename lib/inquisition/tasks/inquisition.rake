namespace :inquisition do
  desc 'Run Inquisition'
  task run: :environment do
    Inquisition::Formatters::HtmlFormatter.new(Inquisition::Collector.new.call).call
  end
end
