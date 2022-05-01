module StaleFile
  class Stale
    attr_accessor :name, :last_modified_date

    def initialize(name, last_modified_date)
      @name = name
      @last_modified_date = last_modified_date
    end
  end
end
