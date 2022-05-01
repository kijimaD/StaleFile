require 'open3'

module StaleFile
  class Search
    attr_accessor :stales

    def initialize
      @stales = []

      rows = Open3.capture2(grep_command).first.split("\n")
      rows.each do |row|
        date = row.split(" ")[0]
        name = row.split(" ")[3]

        @stales << Stale.new(name, date)
      end
    end

    private

    def grep_command
      <<~COMMAND.chomp
        git ls-files "#{file_extension}" | grep "#{include}" | grep -v "#{exclude}" | xargs -I{} -- git log -1 --format="%ai {}" {}
      COMMAND
    end

    def file_extension
      ENV.fetch('FILE_EXTENSION')
    end

    def include
      ENV.fetch('INCLUDE')
    end

    def exclude
      ENV.fetch('EXCLUDE')
    end
  end
end
