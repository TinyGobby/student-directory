@students = []

def month
  year = [:January, :February, :March, :April, :May, :June, :July, :August,:September, :October, :November, :December, :Future]

  puts "What month cohort are they in?"

  cohort = gets.chomp.capitalize.to_sym

  while !year.include?(cohort)
    puts "Please try again, or type Future for future cohorts"
    cohort = gets.chomp.capitalize.to_sym
  end

  return cohort
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = STDIN.gets.chomp
  while !name.empty? do
    @students << {name: name, cohort: month}
    puts "Now we have #{@students.count} students"
    name = gets.chomp
  end
  @students
end

def print_header
  puts "The Students of Villains Academy".center(80)
  puts "-------------".center(80)
end

def print_students
  @students.each_with_index do |student, index|
    if student[:name].length < 12
      puts "#{index+1}: #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def print_footer
  if @students.count == 1
    puts "Overall, we have 1 great student\n"
  else
    puts "Overall, we have #{@students.count} great students\n"
  end
end

def print_menu
  puts "Menu"
  puts "1. Input the students"
  puts "2. Show the students"
  puts "3. Save the list to students.csv"
  puts "4. Load the list from students.csv"
  puts "9. Exit"
end

def show_students
  print_header
  print_students
  print_footer
end

def save_students
  # open the file for writing
  file = File.open("students.csv", "w")
  # iterate over the array of students
  @students.each do |student|
    student_data = [student[:name], student[:cohort]]
    csv_line = student_data.join(",")
    file.puts csv_line
  end
  file.close
  puts "Saved to students.csv"
end

def load_students(filename = "students.csv")
  file = File.open(filename, "r")
  file.readlines.each do |line|
    name, cohort = line.chomp.split(",")
    @students << {name: name, cohort: cohort.to_sym}
  end
  file.close
  puts "Loaded #{@students.count} students from #{filename}"
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  if filename.nil? # load students.csv if no other file provided
    filename = "students.csv"
  end

  if File.exists?(filename)
    load_students(filename)
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn\'t exist"
    exit
  end
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "3"
    save_students
  when "4"
    load_students
  when "9"
    puts "Goodbye"
    exit
  else
    puts "I don't know what you mean, try again"
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

try_load_students
interactive_menu
