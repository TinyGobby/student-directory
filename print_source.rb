def print_source
  File.open($0, "r") do |file|
    file.readlines.each { |line| puts line }
  end
end

print_source
