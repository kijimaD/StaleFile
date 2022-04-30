require 'open3'

module StaleFile
  class Search
    attr_accessor :stales

    def initialize
      @stales = []

      rows = Open3.capture2(command).first.split("\n")
      rows.each do |row|
        date = row.split(" ")[0]
        name = row.split(" ")[3]

        @stales << Stale.new(name, date)
      end
    end

    private

    # extension, include, exclude
    def command
      'git ls-files "*.md" | grep ".*" | grep -v "*" | xargs -I{} -- git log -1 --format="%ai {}" {}'
    end
  end

  class Stale
    attr_accessor :name, :last_modified_date

    def initialize(name, last_modified_date)
      @name = name
      @last_modified_date = last_modified_date
    end
  end

  class Report
    def self.call
      search = StaleFile::Search.new
      report = self.new(search.stales)
      report.print
    end

    def initialize(stales)
      @stales = stales
    end

    def print
      <<~PRINT
        #{msg}
        #{table_header}
        #{table}
      PRINT
    end

    private

    def msg
      <<~MSG.chomp
        ## StaleFile
        These are staled files! Please check content.

      MSG
    end

    def table_header
      <<~HEADER.chomp
        | File | Last modified |
        | ---- | ------------- |
      HEADER
    end

    def table
      @stales.map { |s| table_row(s) }.join("\n")
    end

    def table_row(stale)
      "| #{ stale.name } | #{stale.last_modified_date} |"
    end

    def condition
      # using condition, count
    end
  end
end

puts StaleFile::Report.call
