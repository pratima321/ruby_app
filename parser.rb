# frozen_string_literal: true

require './lib/log_processor'

LogProcessor.new(ARGV[0]).show_page_views
