require 'rails_helper'

RSpec.describe Message do
  describe '#image' do
    context 'when no image is attached' do
      let(:message) { Message.new }

      it 'is not attached' do
        expect(message.image.attached?).to be false
      end
    end

    context 'when a image is attached' do
      let(:message) { Message.new }

      before do
        message.image.attach(io: File.open(upload_file_path), filename: 'test.txt', content_type: 'application/pdf')
      end

      it 'returns the attached image' do
        expect(message.image.filename).to eq('test.txt')
      end
    end
  end

  def upload_file_path
    Rails.root.join('spec', 'fixtures', 'test.txt')
  end
end
