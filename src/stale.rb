module StaleFile
  class Stale
    include Jekyll::Timeago
    attr_accessor :name, :last_modified_date, :relative_date_str, :days_count

    def initialize(name, last_modified_date)
      @name = name
      @last_modified_date = last_modified_date
      @relative_date_str = timeago(last_modified_date, depth: 1)
      @days_count = (Date.today - last_modified_date).to_i
    end
  end
end
