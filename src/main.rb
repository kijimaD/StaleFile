module StaleFile
  class Search
    attr_accessor :stales

    def initialize
      @stales = []

      Dir["./*.md"].each do |file|
        @stales << Stale.new(file)
      end
    end
  end

  class Stale
    def initialize(file)
      @file = file
    end

    def last_time_abs
      File.mtime(@file)
    end

    def name
      @file.to_s
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
        #{header}
        #{table}
      PRINT
    end

    def msg
      <<~MSG.chomp
        ## Stale Files
        These are staled files! Please check content keeping fresh.

      MSG
    end

    def header
      <<~HEADER.chomp
        | File | Last modified |
        | ---- | ------------- |
      HEADER
    end

    def table
      @stales.map { |s| table_row(s) }.join("\n")
    end

    def table_row(stale)
      "| #{ stale.name } | #{stale.last_time_abs} |"
    end
  end
end

puts StaleFile::Report.call
