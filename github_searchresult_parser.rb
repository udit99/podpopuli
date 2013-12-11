require_relative 'podfile_parser'

class GithubSearchresultParser
  def self.parse_podnames(url)
      doc = Nokogiri::HTML(open(url))
      podfile_lines = doc.css(".line").map(&:text).map(&:chomp).uniq
      PodfileParser.parse_podnames(podfile_lines)
  end
end
