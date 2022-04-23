APPOINTMENTS = []

def start_cli
  puts "Hi! Welcome to the Appointments CLI"
  main_menu
  choice = ask_for_input
  until choice == "exit"
    handle_user_choice(choice)
    main_menu
    choice = ask_for_input("What would you like to do? ")
  end
  puts "Thanks for using the appointments CLI!"
end

def main_menu
  puts "Here's what you can do:".cyan
  puts "  1. Add Appointment".cyan
  puts "  2. List appointments".cyan
  puts "  3. Add Notes to appointment".cyan
  puts "  4. Cancel an appointment".cyan
  puts "  exit".cyan
  puts "Type the number corresponding to your choice, or 'exit' to leave the program".cyan
end

def ask_for_input(prompt="")
  print prompt
  input = gets.chomp
  if input == "exit"
    puts "Thank you for using the Appointments CLI!".light_green
    exit
  end
  input
end

def handle_user_choice(choice)
  if choice == "1"
    add_appointment
  elsif choice == "2"
    list_appointments
  elsif choice == "3"
    add_notes_to_appointment
  elsif choice == "4"
    cancel_an_appointment
  elsif choice == "debug"
    binding.pry
  else 
    puts "Whoops! Sorry, I didn't understand that choice".red
  end
end

def add_appointment
  print "What time does the appointment start? "
  time = ask_for_input
  print "What doctor is the appointment with? "
  doctor = ask_for_input
  print "What patient is the appointment with? "
  patient = ask_for_input
  print "What is the purpose of your visit? "
  purpose = ask_for_input
  appointment = Appointment.new(time, doctor, patient, purpose)
  if appointment.valid?
    APPOINTMENTS << appointment
    appointment.print
  else 
    puts "Whoops! Looks like you forgot to enter a value for one of the fields".red
    add_appointment
  end
end


def list_appointments
  puts "All Appointments"
  APPOINTMENTS.each {|appt| appt.print}
end

def add_notes_to_appointment
  puts "Which appointment would you like to add notes to? (choose the corresponding number)".cyan
  APPOINTMENTS.each.with_index(1) do |appt, index|
    puts "#{index}. #{appt.patient} at #{appt.time} with #{appt.doctor}"
  end
  appt_index = ask_for_input.to_i - 1
  until appt_index >= 0
    puts "Whoops! That didn't work".red
    puts "Please type the number corresponding to the dog you'd like to feed"
    appt_index = ask_for_input.to_i - 1
  end
  appointment = APPOINTMENTS[appt_index]
  puts "What notes would you like to add?"
  appointment.notes = ask_for_input
  appointment.print
end

def cancel_an_appointment
  puts "Which appointment would you like to cancel? (choose the corresponding number)".cyan
  APPOINTMENTS.each.with_index(1) do |appt, index|
    puts "#{index}. #{appt.patient} at #{appt.time} with #{appt.doctor}"
  end
  appt_index = ask_for_input.to_i - 1
  until appt_index >= 0
    puts "Whoops! That didn't work".red
    puts "Please type the number corresponding to the dog you'd like to feed"
    appt_index = ask_for_input.to_i - 1
  end
  appointment = APPOINTMENTS[appt_index]
  appointment.cancel
  appointment.print
end