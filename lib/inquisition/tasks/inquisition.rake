desc 'Run Inquisition'
task inquisition: :environment do
  Inquisition::Formatters::HtmlFormatter.new(Inquisition::Collector.new.call).call
end

# task :t => :table

# desc 'Run Inquisition with PDF output'
# task inquisition: :environment do
  # BaseFormatter.new(Inquisition::Collector.new.call, formatter: PdfFormatter).call
# end

# desc 'Run Inquisition with PDF output'
# namespace :inquisition do
#   task pdf: :environment do
#     PdfFormatter.new(Inquisition::Collector.new.call).call
#   end
# end
