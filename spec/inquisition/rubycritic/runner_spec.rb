RSpec.describe Inquisition::Rubycritic::Runner do
  include_examples 'enablable', :rubycritic

  describe '#call' do
    subject(:runner) { described_class.new }

    let(:analysed_modules) { instance_double(RubyCritic::AnalysedModulesCollection, score: 0) }

    before do
      allow(analysed_modules).to receive(:map).and_yield(analysed_module)
      allow(RubyCritic::AnalysedModulesCollection).to receive(:new).with([Rails.root]).and_return(analysed_modules)
    end

    context 'when there are no issues' do
      let(:flay) { instance_double(Inquisition::Rubycritic::Analysers::Flay) }
      let(:flog) { instance_double(Inquisition::Rubycritic::Analysers::Flog) }
      let(:reek) { instance_double(Inquisition::Rubycritic::Analysers::Reek) }
      let(:complexity) { instance_double(Inquisition::Rubycritic::Analysers::Complexity) }

      let(:analysed_module) do
        instance_double(
          RubyCritic::AnalysedModule,
          pathname: Pathname.new(Rails.root.join('app', 'models', 'application_record.rb')),
          path: Pathname.new(Rails.root.join('app', 'models', 'application_record.rb')).to_s,
          smells: []
        )
      end

      before do
        allow(flay).to receive(:run)
        allow(flog).to receive(:run)
        allow(reek).to receive(:run)
        allow(complexity).to receive(:run)

        allow(Inquisition::Rubycritic::Analysers::Flay).to receive(:new).with(analysed_modules).and_return(flay)
        allow(Inquisition::Rubycritic::Analysers::Flog).to receive(:new).with(analysed_modules).and_return(flog)
        allow(Inquisition::Rubycritic::Analysers::Reek).to receive(:new).with(analysed_modules).and_return(reek)
        allow(Inquisition::Rubycritic::Analysers::Complexity).to receive(:new)
          .with(analysed_modules).and_return(complexity)
      end

      it { expect(runner.call).to be_empty }
    end

    context 'when there are `flay` issues' do
      let(:flay) { instance_double(Inquisition::Rubycritic::Analysers::Flay) }
      let(:analysed_module) do
        instance_double(
          RubyCritic::AnalysedModule,
          pathname: Pathname.new(Rails.root.join('app', 'models', 'application_record.rb')),
          path: Pathname.new(Rails.root.join('app', 'models', 'application_record.rb')).to_s,
          smells: [smell]
        )
      end
      let(:smell) do
        instance_double(
          RubyCritic::Smell,
          type: 'HighComplexity',
          context: 'Similar code',
          message: 'found in 2 nodes',
          analyser: 'flay',
          locations: [
            instance_double(
              RubyCritic::Location,
              line: 35,
              pathname: Pathname.new(Rails.root.join('app', 'models', 'application_record.rb'))
            ),
            instance_double(
              RubyCritic::Location,
              line: 42,
              pathname: Pathname.new(Rails.root.join('app', 'models', 'application_record.rb'))
            )
          ]
        )
      end
      let(:issues) do
        [
          Inquisition::Issue.new(
            path: 'app/models/application_record.rb',
            line: 35,
            severity: Inquisition::Severity::LOW,
            message: 'Similar code found in 2 nodes',
            runner: runner,
            context: smell
          ),
          Inquisition::Issue.new(
            path: 'app/models/application_record.rb',
            line: 42,
            severity: Inquisition::Severity::LOW,
            message: 'Similar code found in 2 nodes',
            runner: runner,
            context: smell
          )
        ]
      end

      before do
        stub_const('Inquisition::Rubycritic::Runner::ANALYSERS', [Inquisition::Rubycritic::Analysers::Flay])

        allow(flay).to receive(:run)
        allow(Inquisition::Rubycritic::Analysers::Flay).to receive(:new).with(analysed_modules).and_return(flay)
      end

      it 'returns a collection of issues' do
        expect(runner.call).to match_array(issues)
      end
    end

    context 'when there are `flog` issues' do
      let(:flog) { instance_double(Inquisition::Rubycritic::Analysers::Flog) }
      let(:analysed_module) do
        instance_double(
          RubyCritic::AnalysedModule,
          pathname: Pathname.new(Rails.root.join('app', 'models', 'application_record.rb')),
          path: Pathname.new(Rails.root.join('app', 'models', 'application_record.rb')).to_s,
          smells: [smell]
        )
      end
      let(:smell) do
        instance_double(
          RubyCritic::Smell,
          type: 'HighComplexity',
          context: 'ApplicationRecord#test_flog',
          message: 'has a flog score of 40',
          analyser: 'flog',
          locations: [
            instance_double(
              RubyCritic::Location,
              line: 14,
              pathname: Pathname.new(Rails.root.join('app', 'models', 'application_record.rb'))
            )
          ]
        )
      end
      let(:issue) do
        Inquisition::Issue.new(
          path: 'app/models/application_record.rb',
          line: 14,
          severity: Inquisition::Severity::LOW,
          message: 'ApplicationRecord#test_flog has a flog score of 40',
          runner: runner
        )
      end

      before do
        stub_const('Inquisition::Rubycritic::Runner::ANALYSERS', [Inquisition::Rubycritic::Analysers::Flog])

        allow(flog).to receive(:run)
        allow(Inquisition::Rubycritic::Analysers::Flog).to receive(:new).with(analysed_modules).and_return(flog)
      end

      it 'returns a collection of issues' do
        expect(runner.call).to contain_exactly(issue)
      end
    end

    context 'when there are `reek` issues' do
      let(:reek) { instance_double(Inquisition::Rubycritic::Analysers::Reek) }
      let(:analysed_module) do
        instance_double(
          RubyCritic::AnalysedModule,
          pathname: Pathname.new(Rails.root.join('app', 'controllers', 'application_controller.rb')),
          path: Pathname.new(Rails.root.join('app', 'controllers', 'application_controller.rb')).to_s,
          smells: [smell]
        )
      end
      let(:smell) do
        instance_double(
          RubyCritic::Smell,
          type: 'HighComplexity',
          context: 'ApplicationController#test_fasterer',
          message: "doesn't depend on instance state (maybe move it to another class?)",
          analyser: 'reek',
          locations: [
            instance_double(
              RubyCritic::Location,
              line: 9,
              pathname: Pathname.new(Rails.root.join('app', 'controllers', 'application_controller.rb'))
            )
          ]
        )
      end
      let(:issue) do
        Inquisition::Issue.new(
          path: 'app/controllers/application_controller.rb',
          line: 9,
          severity: Inquisition::Severity::LOW,
          runner: runner,
          message: <<-MESSAGE.squish
            ApplicationController#test_fasterer doesn't depend on instance state (maybe move it to another class?)
          MESSAGE
        )
      end

      before do
        stub_const('Inquisition::Rubycritic::Runner::ANALYSERS', [Inquisition::Rubycritic::Analysers::Reek])

        allow(reek).to receive(:run)
        allow(Inquisition::Rubycritic::Analysers::Reek).to receive(:new).with(analysed_modules).and_return(reek)
      end

      it 'returns a collection of issues' do
        expect(runner.call).to contain_exactly(issue)
      end
    end

    context 'when there are call column `complexity` in issues' do
      let(:complexity) { instance_double(Inquisition::Rubycritic::Analysers::Complexity) }
      let(:analysed_module) do
        instance_double(
          RubyCritic::AnalysedModule,
          pathname: Pathname.new(Rails.root.join('app', 'models', 'application_record.rb')),
          path: Pathname.new(Rails.root.join('app', 'models', 'application_record.rb')).to_s,
          smells: [smell]
        )
      end
      let(:smell) do
        instance_double(
          RubyCritic::Smell,
          type: 'HighComplexity',
          context: 'ApplicationRecord#test_flog',
          message: 'has a flog score of 40',
          analyser: 'flog',
          locations: [
            instance_double(
              RubyCritic::Location,
              line: 14,
              pathname: Pathname.new(Rails.root.join('app', 'models', 'application_record.rb'))
            )
          ]
        )
      end
      let(:issue) do
        Inquisition::Issue.new(
          path: 'app/models/application_record.rb',
          line: 14,
          severity: Inquisition::Severity::LOW,
          message: 'ApplicationRecord#test_flog has a flog score of 40',
          runner: runner,
          context: smell.type
        )
      end

      before do
        stub_const('Inquisition::Rubycritic::Runner::ANALYSERS', [Inquisition::Rubycritic::Analysers::Complexity])

        allow(complexity).to receive(:run)
        allow(Inquisition::Rubycritic::Analysers::Complexity).to receive(:new)
          .with(analysed_modules).and_return(complexity)
      end

      it 'returns a collection of issues' do
        expect(runner.call).to contain_exactly(issue)
      end
    end
  end
end
