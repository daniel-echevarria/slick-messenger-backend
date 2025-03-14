require 'rails_helper'

RSpec.describe Message do
  describe '#document' do
    context 'when no document is attached' do
      let(:message) { Message.new }

      it 'is not attached' do
        expect(message.document.attached?).to be false
      end
    end

    context 'when a document is attached' do
      let(:message) { Message.new }

      before do
        message.document.attach(io: File.open(upload_file_path), filename: 'test.txt', content_type: 'application/pdf')
      end

      it 'returns the attached document' do
        expect(message.document.filename).to eq('test.txt')
      end
    end
  end

  def upload_file_path
    Rails.root.join('spec', 'fixtures', 'test.txt')
  end
end
