class PodfileParser
  def parse_podnames(podfile_lines)
    podfile_lines.map do |line|
      line.match(/^pod/) ? scrub(line) :nil
    end.compact
  end

  private

  def scrub(line)
    line = line.gsub(/^pod/, '').strip
    line = line.split(",").first
    strip_quotes(line)
  end

  def strip_quotes(str)
    str.gsub(/(\'|\")/,'')
  end
end
