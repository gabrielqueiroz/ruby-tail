require_relative '../tail'

require 'rspec/autorun'

RSpec.describe Tail do
  let(:tail) { Tail.new(arguments) }
  let(:file) { 'test.txt' }
  let(:arguments) { [file] }
  let(:file_content) { ''}

  before do
    File.write(file, file_content)
  end

  after do
    File.delete(file)
  end

  describe '#run' do
    subject { tail.run }

    let(:system_tail_output) { %x{ tail #{arguments.join(' ')} } }
    let(:file_content) { "1\n2\n3\n4\n5\n6\n7\n8\n9\n10" }

    it { is_expected.to eq(system_tail_output) }

    context 'when the file has more than 10 lines' do
      let(:file_content) { "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n11\n12\n13\n14\n15" }
      it { is_expected.to eq(system_tail_output) }
    end

    context 'when the file has less than 10 lines' do
      let(:file_content) { "1\n2\n3\n4\n5\n6\n7\n8\n9" }
      it { is_expected.to eq(system_tail_output) }
    end

    context 'when arguments include -n' do
      let(:arguments) { ['-n', '5', file] }
      it { is_expected.to eq(system_tail_output) }
    end
  end
end