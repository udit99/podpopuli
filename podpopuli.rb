require 'open-uri'
require 'nokogiri'
require 'pry'
require_relative 'github_searchresult_parser'

class PodPopuli
  SEARCH_URL = 'https://github.com/search?l=ruby&o=desc&p=#{page_number}&q=%22platform+%3Aios%22&ref=cmdform&s=indexed&type=Code'
  SLEEP_SECONDS = 10

  def initialize
    @pod_counter = {}
  end

  def crawl
    (1..100).each do |page_number|
      sleep SLEEP_SECONDS
      pod_names = GithubSearchresultParser.parse_podnames(eval('"'+SEARCH_URL+'"'))
      update_pod_counter(pod_names)
    end
    puts "************* Popular CocoaPods by usage ****************"
    display @pod_counter.sort_by{|pod, count| count}.reverse
  end

  private
  def update_pod_counter(keywords)
    keywords.each do |keyword|
      @pod_counter[keyword] = @pod_counter[keyword] ? (@pod_counter[keyword] + 1) : 1
    end
  end

  def display pod_counts
    pod_counts.each{|pod_name,count| puts "#{pod_name}:#{count}"}
  end

end

PodPopuli.new.crawl
