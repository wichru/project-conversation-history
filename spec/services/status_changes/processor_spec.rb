require 'rails_helper'

RSpec.describe StatusChanges::Processor, type: :service do
  subject(:processor) { described_class.new(project, new_status) }

  let(:project) { create(:project, status: :pending) }

  describe '#call' do
    context 'when the new status is the same as the current status' do
      let(:new_status) { 'pending' }

      it 'returns failure with an appropriate message' do
        result = processor.call

        expect(result).to have_attributes(
          success?: false,
          message: 'Project is already pending'
        )
      end
    end

    context 'when the status change is valid' do
      let(:new_status) { 'active' }

      it 'updates the project status and creates a status change activity' do
        result = processor.call

        expect(result).to have_attributes(
          success?: true,
          message: 'Status changed to active'
        )

        expect(result.activity).to have_attributes(
          from_status: 'pending',
          to_status: 'active'
        )

        project.reload
        expect(project.status).to eq('active')
      end
    end

    context 'when an update fails due to validation' do
      let(:new_status) { 'active' }

      before do
        allow(project).to receive(:update!).and_raise(ActiveRecord::RecordInvalid.new(project))
      end

      it 'rescues ActiveRecord::RecordInvalid and returns failure' do
        result = processor.call

        expect(result.success?).to be false
        expect(result.message).to be_present
      end
    end
  end
end
