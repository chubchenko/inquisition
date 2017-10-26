require 'traceroute'

namespace :inquisition do
  task :create_configs do
    configs = [
      { gem: 'Overcommit', file: '.overcommit.yml' },
      { gem: 'RSpec',      file: '.rspec' },
      { gem: 'Rails ERD',  file: '.erdconfig' },
      { gem: 'Rubocop',    file: '.rubocop.yml' },
      { gem: 'Reek',       file: '.reek.yml' },
      { gem: 'Fasterer',   file: '.fasterer.yml' }
    ]

    configs.each do |config|
      print "Creating config for #{config[:gem]}... "

      cp File.join(File.join(File.dirname(__dir__), 'configs'), config[:file]), Dir.pwd, preserve: true, verbose: false

      puts 'Done!'.green
    end

    mkdir_p File.join(Dir.pwd, 'doc'), verbose: false
  end

  task :install_bullet do
    print 'Creating config for Bullet... '

    file = File.join(Dir.pwd, 'config', 'environments', 'development.rb')
    content = File.read(file)

    unless content =~ /Bullet/
      config = <<~BULLET
        config.after_initialize do
          Bullet.tap do |bullet|
            bullet.enable = true
            bullet.alert = false
            bullet.bullet_logger = true
            bullet.console = false
            bullet.growl = false
            bullet.rails_logger = true
            bullet.add_footer = false
            bullet.airbrake = false
          end
        end
      BULLET

      config = config.split("\n").map { |l| l.prepend(' ' * 2) }.join("\n")

      File.write(file, content.gsub(/^end/, "\n#{config}\nend"))
    end

    puts 'Done!'.green
  end

  task :install_simplecov do
    print 'Creating config for Simplecov... '

    file = File.join(Dir.pwd, 'spec', 'spec_helper.rb')
    content = File.read(file)

    unless content =~ /simplecov/
      config = <<~SIMPLECOV
        require 'simplecov'

        SimpleCov.start 'rails' do
          coverage_dir File.join('doc', 'coverage')

          groups = %w[channels commands controllers decorators features forms
                      helpers jobs libs mailers models policies queries
                      serializers services tasks uploaders values]

          groups.each { |name| add_group name.capitalize, "/app/\#{name}" }
        end
      SIMPLECOV

      File.write(file, config + "\n" + content)
    end

    puts 'Done!'.green
  end

  task :info do
    puts

    box 'Important!', color: :red do
      <<~INFO
        You need to install the following utilites:

        On MacOS:

          $ brew install graphviz

        On Linux:

          $ apt-get install graphviz
      INFO
    end

    box 'How to use'

    puts <<~INFO
      You can run all linters using this command:

        $ rails inquisition:all

      Check output into the console and go to the <project_root>/doc directory.
      There you will find diagrams and some reports in html format.

      If you want to see test coverage report you need to run tests first:

        $ rspec

      For more information see:

        $ rails -T inquisition
    INFO

    puts
  end

  desc 'Install Inquisition'
  task :install do
    box '~ * ~   Inquisition   ~ * ~'.upcase

    %w[create_configs install_bullet install_simplecov info].each do |task|
      Rake::Task["inquisition:#{task}"].invoke
    end
  end

  desc 'Bundler audit'
  task :bundler_audit do
    system 'bundle audit check --update'
  end

  desc 'Generate ER-diagram'
  task :erd do
    system 'bundle exec erd'
  end

  desc 'Generate UML diagrams'
  task :railroady do
    puts 'Processing Models...'

    common_options = '--alphabetize --inheritance --show-belongs_to'

    system "bundle exec railroady #{common_options} --brief --output doc/models-brief.dot --models"
    system 'dot -T svg doc/models-brief.dot > doc/models-brief.svg'

    system "bundle exec railroady #{common_options} --all-columns --output doc/models.dot --models"
    system 'dot -T svg doc/models.dot > doc/models.svg'

    puts 'Processing Controllers...'

    system 'bundle exec railroady --engine-controllers --output doc/controllers.dot --controllers'
    system 'neato -T svg doc/controllers.dot > doc/controllers.svg'

    system 'rm doc/*.dot'
  end

  desc 'Run Reek'
  task :reek do
    system 'bundle exec reek -c .reek.yml'
  end

  desc 'Run Rubocop'
  task :rubocop do
    system 'bundle exec rubocop'
  end

  desc 'Run Rails Best Practices'
  task :rails_best_practices do
    system 'bundle exec rails_best_practices --silent'
  end

  desc 'Run Rubycritic'
  task :rubycritic do
    system 'bundle exec rubycritic --no-browser --path doc/rubycritic'
  end

  desc 'Run Fasterer'
  task :fasterer do
    system 'bundle exec fasterer'
  end

  desc 'Run Brakeman'
  task :brakeman do
    system 'bundle exec brakeman -q'
  end

  desc 'Run Traceroute'
  task traceroute: :environment do
    traceroute = Traceroute.new Rails.application
    traceroute.load_everything!

    defined_action_methods = traceroute.defined_action_methods

    routed_actions = traceroute.routed_actions

    unused_routes = routed_actions - defined_action_methods
    unreachable_action_methods = defined_action_methods - routed_actions

    puts "Unused routes (#{unused_routes.count}):"
    unused_routes.each { |route| puts "  #{route}" }

    puts "Unreachable action methods (#{unreachable_action_methods.count}):"
    unreachable_action_methods.each { |action| puts "  #{action}" }
  end

  desc 'Report code statistics (KLOCs, etc) from the application or engine'
  task :stats do
    require 'rails/code_statistics'

    code = [
      ['Decorators',  'app/decorators'],
      ['Forms',       'app/forms'],
      ['Policies',    'app/policies'],
      ['Queries',     'app/queries'],
      ['Serializers', 'app/serializers'],
      ['Services',    'app/services'],
      ['Uploaders',   'app/uploaders'],
      ['Validators',  'app/validators'],
      ['Values',      'app/values'],
      ['Views',       'app/views']
    ]

    code.each do |item|
      ::STATS_DIRECTORIES << item if Dir.exist?(File.join(Dir.pwd, item.last))
    end

    specs = [
      ['Spec: Channels',    'spec/channels'],
      ['Spec: Controllers', 'spec/controllers'],
      ['Spec: Decorators',  'spec/decorators'],
      ['Spec: Factories',   'spec/factories'],
      ['Spec: Features',    'spec/features'],
      ['Spec: Forms',       'spec/forms'],
      ['Spec: Helpers',     'spec/helpers'],
      ['Spec: Jobs',        'spec/jobs'],
      ['Spec: Libs',        'spec/libs'],
      ['Spec: Mailers',     'spec/mailers'],
      ['Spec: Models',      'spec/models'],
      ['Spec: Policies',    'spec/policies'],
      ['Spec: Queries',     'spec/queries'],
      ['Spec: Requests',    'spec/requests'],
      ['Spec: Serializers', 'spec/serializers'],
      ['Spec: Services',    'spec/services'],
      ['Spec: Tasks',       'spec/tasks'],
      ['Spec: Uploaders',   'spec/uploaders'],
      ['Spec: Values',      'spec/values'],
      ['Spec: Views',       'spec/views']
    ]

    specs.each do |item|
      if Dir.exist?(File.join(Dir.pwd, item.last))
        ::STATS_DIRECTORIES << item
        CodeStatistics::TEST_TYPES << item.first
      end
    end

    Rake::Task['stats'].invoke
  end

  desc 'Run ALL linters'
  task :all do
    %w[
      bundler_audit
      erd
      railroady
      reek
      rubocop
      rails_best_practices
      rubycritic
      fasterer
      brakeman
      traceroute
      stats
    ].each do |task|
      box task

      Rake::Task["inquisition:#{task}"].invoke

      puts
    end
  end

  def box(text, width: 100, color: :default)
    char = '#'
    output = [char * (width + 2)]
    output << char + ' ' * width + char
    output << char + text.upcase.center(width) + char
    output << char + ' ' * width + char
    output << char * (width + 2)

    puts output.join("\n").colorize(color)

    if block_given?
      return unless yield.is_a? String

      lines = yield.lines
      lines.unshift(' ')
      lines << ' '
      lines.map! { |line| '# '.colorize(color) + line.delete("\n").ljust(width - 2) + ' #'.colorize(color) }
      lines << char.colorize(color) * (width + 2)

      puts lines.join("\n")
    end

    puts
  end
end
