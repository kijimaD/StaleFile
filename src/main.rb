require 'jekyll-timeago'

require_relative 'report'
require_relative 'search'
require_relative 'stale'

puts StaleFile::Report.call
