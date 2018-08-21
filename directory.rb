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
  students = []
  # get the first name
  name = gets.chomp
  # while the name is not empty, repeat this code
  while !name.empty? do
    # add the student hash to the array
    students << {name: name, cohort: month}
    puts "Now we have #{students.count} students"
    # now get another name from the user
    name = gets.chomp
    if name.empty?
      break
    end
  end
  # return the array of students
  students
end

def print_header
  puts "The Students of Villains Academy".center(80)
  puts "-------------".center(80)
end

def print(students)
  students.each_with_index do |student, index|
    if student[:name].length < 12
      puts "#{index+1}: #{student[:name]} (#{student[:cohort]} cohort)"
    end
  end
end

def print_footer(students)
  if students.count == 1
    puts "Overall, we have 1 great student"
  else
    puts "Overall, we have #{students.count} great students"
  end
end

students = input_students

print_header
print(students)
print_footer(students)
