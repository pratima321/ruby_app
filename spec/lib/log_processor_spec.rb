# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LogProcessor do
  let(:file_path) { 'spec/support/test_log_file.log' }
  subject { LogProcessor.new(file_path) }

  describe '#initialize' do
    context 'when log file is not provided' do
      it 'raises error' do
        expect do
          LogProcessor.new(nil)
        end.to raise_error(RuntimeError).with_message('Please provide log file to the parser e.g. ruby parser.rb < log/file/path >')
      end
    end

    context 'when log file does not exist' do
      it 'raises error' do
        expect do
          LogProcessor.new('non_existing_file_path')
        end.to raise_error(Errno::ENOENT).with_message(/No such file or directory/)
      end
    end

    context 'when log file is provided' do
      context 'when log file is empty' do
        before do
          allow(File).to receive(:zero?).and_return(true)
        end

        it 'raises error' do
          expect { subject }.to raise_error(RuntimeError).with_message("No logs found in #{file_path} file.")
        end
      end
    end
  end

  describe '#page_views' do
    let(:most_page_views) do
      [
        ['/contact',
         86], ['/about/2', 86], ['/index', 81], ['/about', 75], ['/home', 74], ['/help_page/1', 73]
      ]
    end

    let(:unique_page_views) do
      [
        ['/contact',
         23], ['/home', 23], ['/index', 23], ['/help_page/1', 22], ['/about/2', 22], ['/about', 21]
      ]
    end

    context 'when provided log file has log entries' do
      it 'returns page\'s with most and unique number of views' do
        expect(subject.page_views).to eq [most_page_views, unique_page_views]
      end
    end
  end
end
