require 'open-uri'
require 'nokogiri'
require 'pry'
require_relative 'keyword_cruft'

class PodPopuli
  SEARCH_URL = 'https://github.com/search?l=ruby&o=desc&p=#{page_number}&q=%22platform+%3Aios%22&ref=cmdform&s=indexed&type=Code'

  def initialize
    @pod_counter = {}
  end

  def crawl
    (1..2).each do |page_number|
      sleep 1
      pod_names = get_unique_podnames(eval('"'+SEARCH_URL+'"'))
      update_pod_counter(pod_names)
    end
    puts @pod_counter.sort_by{|pod, count| pod}
  end

  private
  def update_pod_counter(keywords)
    keywords.each do |keyword|
      @pod_counter[keyword] = @pod_counter[keyword] ? (@pod_counter[keyword] + 1) : 1
    end
  end

  def get_unique_podnames(url)
      doc = Nokogiri::HTML(open(url))
      podfile_lines = doc.css(".line").map(&:text).map(&:chomp).uniq
      keywords = podfile_lines.map do |line|
        line.match(/^pod/) ? line.gsub(/^pod/, ''): nil
      end.compact
  end
end

PodPopuli.new.crawl
