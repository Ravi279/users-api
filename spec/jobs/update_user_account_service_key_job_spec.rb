require 'rails_helper'

RSpec.describe UpdateUserAccountServiceKeyJob, type: :job do
  describe "#perform" do
    ActiveJob::Base.queue_adapter = :test
    subject(:job) { described_class.perform_later(key) }

    let(:key) { 123 }

    it 'queues the job' do
      expect { job }.to have_enqueued_job(described_class)
                            .with(key)
                            .on_queue("default")
    end
  end
end
