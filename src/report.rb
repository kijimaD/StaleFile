module StaleFile
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