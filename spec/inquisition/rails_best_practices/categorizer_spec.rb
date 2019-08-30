RSpec.describe Inquisition::RailsBestPractices::Categorizer do
  describe '#find_category' do
    subject { described_class.find_category(error_type) == issue_category }

    context 'when error type relates to complexity' do
      let(:error_type) { 'RailsBestPractices::Reviews::AddModelVirtualAttributeReview' }
      let(:issue_category) { :complexity }

      it { is_expected.to be_truthy }
    end

    context 'when error type relates to style' do
      let(:error_type) { 'RailsBestPractices::Lexicals::LongLineCheck' }
      let(:issue_category) { :style }

      it { is_expected.to be_truthy }
    end

    context 'when error type relates to bug_risk' do
      let(:error_type) { 'RailsBestPractices::Reviews::CheckSaveReturnValueReview' }
      let(:issue_category) { :bug_risk }

      it { is_expected.to be_truthy }
    end

    context 'when error type relates to unused_code' do
      let(:error_type) { 'RailsBestPractices::Reviews::RemoveUnusedMethodsInControllersReview' }
      let(:issue_category) { :unused_code }

      it { is_expected.to be_truthy }
    end

    context 'when error type relates to perfomance' do
      let(:error_type) { 'RailsBestPractices::Reviews::AlwaysAddDbIndexReview' }
      let(:issue_category) { :performance }

      it { is_expected.to be_truthy }
    end

    context 'when error type relates to security' do
      let(:error_type) { 'RailsBestPractices::Reviews::ProtectMassAssignmentReview' }
      let(:issue_category) { :security }

      it { is_expected.to be_truthy }
    end

    context 'when error type relates to duplication' do
      let(:error_type) { 'RailsBestPractices::Reviews::UseBeforeFilterReview' }
      let(:issue_category) { :duplication }

      it { is_expected.to be_truthy }
    end
  end
end
