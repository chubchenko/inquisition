class Formatter < ::RuboCop::Formatter::BaseFormatter
  attr_reader :issues

  LEVELS = {
    refactor: Inquisition::Issue::LEVELS[:low],
    convention: Inquisition::Issue::LEVELS[:low],
    warning: Inquisition::Issue::LEVELS[:medium],
    error: Inquisition::Issue::LEVELS[:high],
    fatal: Inquisition::Issue::LEVELS[:high]
  }.freeze

  def initialize(_output, _options = {})
    super
    @issues = []
  end

  def file_finished(file, offenses)
    add_issue(file, offenses) unless offenses.empty?
  end

  def finished(_inspected_files)
    @issues
  end

  def add_issue(file, offenses)
    offenses.each { |offense| create_issue(file, offense) }
  end

  def create_issue(file, offense)
    @issues << Inquisition::Issue.new(level: LEVELS[offense.severity.name], file: file,
                                      line: offense.line, message: offense.message,
                                      runner: 'Runner')
  end
end
