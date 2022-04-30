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
      <<~COMMAND.chomp
      git ls-files #{ENV['FILE_EXTENSION']} | grep ".*" | grep -v "*" | xargs -I{} -- git log -1 --format="%ai {}" {}
      COMMAND
    end
  end

  class Stale
    attr_accessor :name, :last_modified_date

    def initialize(name, last_modified_date)
      @name = name
      @last_modified_date = last_modified_date
    end
  end
end
