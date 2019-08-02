RSpec.describe Inquisition::Rubycritic::Runner do
  describe '#call' do
    subject(:result_runner) { described_class.call }

    context 'when runner returns errors' do
      before { stub_const('Inquisition::Rubycritic::Runner::APP_PATH', './spec/dummy') }

      it 'return count issue' do
        expect(result_runner.count).to eq(12)
      end

      it 'return issue' do
        expect(result_runner).to all(be_kind_of(Inquisition::Issue))
      end

      it 'return issue with current arguments' do
        expect(Inquisition::Issue).to receive(:new).with(
          level: Inquisition::Issue::LEVELS[:low],
          file: Pathname('spec/dummy/app/controllers/application_controller.rb'),
          line: 9,
          runner: be_kind_of(described_class),
          message: "doesn't depend on instance state (maybe move it to another class?)"
        )
        expect(Inquisition::Issue).to receive(:new).with(
          level: Inquisition::Issue::LEVELS[:low],
          file: Pathname('spec/dummy/db/migrate/20190801142754_create_active_storage_tables.active_storage.rb'),
          line: 4,
          runner: be_kind_of(described_class),
          message: "refers to 'table' more than self (maybe move it to another class?)"
        )
        expect(Inquisition::Issue).to receive(:new).with(
          level: Inquisition::Issue::LEVELS[:low],
          file: Pathname('spec/dummy/db/migrate/20190801142754_create_active_storage_tables.active_storage.rb'),
          line: 5,
          runner: be_kind_of(described_class),
          message: "refers to 'table' more than self (maybe move it to another class?)"
        )
        expect(Inquisition::Issue).to receive(:new).with(
          level: Inquisition::Issue::LEVELS[:low],
          file: Pathname('spec/dummy/db/migrate/20190801142754_create_active_storage_tables.active_storage.rb'),
          line: 6,
          runner: be_kind_of(described_class),
          message: "refers to 'table' more than self (maybe move it to another class?)"
        )
        expect(Inquisition::Issue).to receive(:new).with(
          level: Inquisition::Issue::LEVELS[:low],
          file: Pathname('spec/dummy/db/migrate/20190801142754_create_active_storage_tables.active_storage.rb'),
          line: 7,
          runner: be_kind_of(described_class),
          message: "refers to 'table' more than self (maybe move it to another class?)"
        )
        expect(Inquisition::Issue).to receive(:new).with(
          level: Inquisition::Issue::LEVELS[:low],
          file: Pathname('spec/dummy/db/migrate/20190801142754_create_active_storage_tables.active_storage.rb'),
          line: 9,
          runner: be_kind_of(described_class),
          message: "refers to 'table' more than self (maybe move it to another class?)"
        )
        expect(Inquisition::Issue).to receive(:new).with(
          level: Inquisition::Issue::LEVELS[:low],
          file: Pathname('spec/dummy/db/migrate/20190801142754_create_active_storage_tables.active_storage.rb'),
          line: 13,
          runner: be_kind_of(described_class),
          message: "refers to 'table' more than self (maybe move it to another class?)"
        )
        expect(Inquisition::Issue).to receive(:new).with(
          level: Inquisition::Issue::LEVELS[:low],
          file: Pathname('spec/dummy/db/migrate/20190801142754_create_active_storage_tables.active_storage.rb'),
          line: 14,
          runner: be_kind_of(described_class),
          message: "refers to 'table' more than self (maybe move it to another class?)"
        )
        expect(Inquisition::Issue).to receive(:new).with(
          level: Inquisition::Issue::LEVELS[:low],
          file: Pathname('spec/dummy/db/migrate/20190801142754_create_active_storage_tables.active_storage.rb'),
          line: 15,
          runner: be_kind_of(described_class),
          message: "refers to 'table' more than self (maybe move it to another class?)"
        )
        expect(Inquisition::Issue).to receive(:new).with(
          level: Inquisition::Issue::LEVELS[:low],
          file: Pathname('spec/dummy/db/migrate/20190801142754_create_active_storage_tables.active_storage.rb'),
          line: 17,
          runner: be_kind_of(described_class),
          message: "refers to 'table' more than self (maybe move it to another class?)"
        )
        expect(Inquisition::Issue).to receive(:new).with(
          level: Inquisition::Issue::LEVELS[:low],
          file: Pathname('spec/dummy/db/migrate/20190801142754_create_active_storage_tables.active_storage.rb'),
          line: 18,
          runner: be_kind_of(described_class),
          message: "refers to 'table' more than self (maybe move it to another class?)"
        )
        expect(Inquisition::Issue).to receive(:new).with(
          level: Inquisition::Issue::LEVELS[:low],
          file: Pathname('spec/dummy/db/migrate/20190801142754_create_active_storage_tables.active_storage.rb'),
          line: 2,
          runner: be_kind_of(described_class),
          message: 'has approx 12 statements'
        )
        result_runner
      end
    end
  end
end
