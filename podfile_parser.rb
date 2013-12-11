class PodfileParser
  def self.parse_podnames(podfile_lines)
    podfile_lines.map do |line|
      line.match(/^pod/) ? scrub(line) :nil
    end.compact
  end

  private

  def self.scrub(line)
    line = line.gsub(/^pod/, '').strip
    strip_quotes(line)
  end

  def self.strip_quotes(str)
    str.gsub(/\'/,'')
  end
end
