# графончик
class InlinePrinter
  def print(figures)
    result = []
    figures.each do |figure|
      figure.to_s.split("\n").each_with_index do |line, idx|
        result[idx] ? result[idx] << " #{line}" : result[idx] = line
      end
    end
    result.each { |line| puts line }
    nil
  end

  def print_masked(figures)
    result = []
    figures.each do |figure|
      figure.to_s(hidden: true).split("\n").each_with_index do |line, idx|
        result[idx] ? result[idx] << " #{line}" : result[idx] = line
      end
    end
    result.each { |line| puts line }
    nil
  end
end
