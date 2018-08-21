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
  puts "3. Save list of students"
  puts "4. Load list of students"
  puts "9. Exit"
end

def show_students
  print_header
  print_students
  print_footer
end

def select_filename
  puts "Which file would you like to load the list of students from?"
  puts "Leave blank for the default (students.csv)"
  puts "Options:"
  puts Dir.entries("./directories/")
  return standard_filename
end

def standard_filename
  filename = "./directories/" + STDIN.gets.chomp
  if filename == "./directories/"
    filename = "./directories/students.csv"
  end
  return filename
end

def save_students
  puts "Which file would you like to save to?"
  puts "Leave blank to save to default (students.csv)"
  File.open(standard_filename, "w") do |file| # open the file for writing
    @students.each do |student|
      student_data = [student[:name], student[:cohort]]
      csv_line = student_data.join(",")
      file.puts csv_line
    end
  end
  puts "Saved"
end

def load_students(filename = "./directories/students.csv")
  File.open(filename, "r") do |file|
    file.readlines.each do |line|
      name, cohort = line.chomp.split(",")
      @students << {name: name, cohort: cohort.to_sym}
    end
  end
  puts "Loaded #{@students.count} students from #{filename}"
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  if filename.nil? # load students.csv if no other file provided
    filename = "./directories/students.csv"
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
    load_students(select_filename)
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
