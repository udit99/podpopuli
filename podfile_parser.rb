class PodfileParser
  def self.parse_podnames(podfile_lines)
      podfile_lines.map do |line|
        line.match(/^pod/) ? line.gsub(/^pod/, ''): nil
      end.compact
  end
end
