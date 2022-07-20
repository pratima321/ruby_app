# frozen_string_literal: true

class LogProcessor
  def initialize(file)
    raise 'Please provide log file to the parser e.g. ruby parser.rb < log/file/path >' if file.blank?

    raise "No logs found in #{file} file." if File.zero?(file)

    @log_file = File.open(file, 'r')
  end

  def show_page_views
    most_views, unique_views = page_views
    puts ''
    puts 'Most Page Views:'
    puts ''
    most_views.each { |mv| puts "#{mv[0]} #{mv[1]} views" }
    puts ''
    puts 'Unique Page Views:'
    puts ''
    unique_views.each { |uv| puts "#{uv[0]} #{uv[1]} unique views" }
    puts ''
  end

  def page_views
    uv = {}
    mv = {}

    page_view_details.each do |k, v|
      uv[k] = v.uniq.length
      mv[k] = v.length
    end

    most_views = mv.sort_by { |_key, value| -value }
    unique_views = uv.sort_by { |_key, value| -value }

    [most_views, unique_views]
  end

  private

  def page_view_details
    page_details = {}

    @log_file.each_line do |log_line|
      next if log_line.chomp.empty?

      page, viewer = log_line.split(/\s+/)
      page_details[page] = [] unless page_details.key? page
      page_details[page] << viewer
    end

    @log_file.close

    page_details
  end
end
