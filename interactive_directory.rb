@students = []

def month
  year = [:January, :February, :March, :April, :May, :June, :July, :August,:September, :October, :November, :December, :Future]

  puts "What month cohort are they in?"

  cohort = gets.chomp.capitalize.to_sym

  if cohort.empty?
    cohort = :Future
  end

  while !year.include?(cohort)
    puts "Please try again, or type Future for future cohorts"
    cohort = gets.chomp.capitalize.to_sym
  end

  return cohort
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  # create an empty array
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    @students << {name: name, cohort: month}
    puts "Now we have #{@students.count} students"
    # now get another name from the user
    name = gets.chomp
    if name.empty?
      break
    end
  end
  # return the array of students
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
    puts "Overall, we have 1 great student"
  else
    puts "Overall, we have #{@students.count} great students"
  end
end

def print_menu
  puts "1. Input the students"
  puts "2. Show the students"
  puts "9. Exit"
end

def show_students
  print_header
  print_students
  print_footer
end

def process(selection)
  case selection
  when "1"
    input_students
  when "2"
    show_students
  when "9"
    exit
  else
    puts "I don't know what you mean, try again"
  end
end

def interactive_menu
  loop do
    print_menu
    process(gets.chomp)
  end
end

interactive_menu
