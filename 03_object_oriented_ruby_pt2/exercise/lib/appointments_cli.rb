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
  puts "  5. View Appointments by Doctor".cyan
  puts "  6. View Appointments by Patient".cyan
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
  elsif choice == "5"
    appointments_by_doctor
  elsif choice == "6"
    appointments_by_patient
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
    appointment.save
    appointment.print
  else 
    puts "Whoops! Looks like you forgot to enter a value for one of the fields".red
    add_appointment
  end
end

def list_appointments
  puts "All Appointments"
  Appointment.all.each {|appt| appt.print}
end

def add_notes_to_appointment
  puts "Which appointment would you like to add notes to? (choose the corresponding number)".cyan
  Appointment.all.each.with_index(1) do |appt, index|
    puts "#{index}. #{appt.patient} at #{appt.time} with #{appt.doctor}"
  end
  appt_index = ask_for_input.to_i - 1
  until appt_index >= 0
    puts "Whoops! That didn't work".red
    puts "Please type the number corresponding to the dog you'd like to feed"
    appt_index = ask_for_input.to_i - 1
  end
  appointment = Appointment.all[appt_index]
  puts "What notes would you like to add?"
  appointment.notes = ask_for_input
  appointment.print
end

def cancel_an_appointment
  puts "Which appointment would you like to cancel? (choose the corresponding number)".cyan
  Appointment.all.each.with_index(1) do |appt, index|
    puts "#{index}. #{appt.patient} at #{appt.time} with #{appt.doctor}"
  end
  appt_index = ask_for_input.to_i - 1
  until appt_index >= 0
    puts "Whoops! That didn't work".red
    puts "Please type the number corresponding to the dog you'd like to feed"
    appt_index = ask_for_input.to_i - 1
  end
  appointment = Appointment.all[appt_index]
  appointment.cancel
  appointment.print
end

def appointments_by_doctor
  # print out a list of doctor's names
  # ask user to choose which doctor's appointments they want to view
  # use your Appointment class method by_doctor to get the relevant
  # appointments and call print on each
  Appointment.all.map{|appt| appt.doctor}.uniq.map do |doctor|
    puts doctor
  end
  puts "Type the name of the doctor whose appointments you'd like to view:".cyan
  doctor = ask_for_input
  puts "Here are the appointments for #{doctor}".light_green
  Appointment.by_doctor(doctor).each do |appointment|
    appointment.print
  end
end

def appointments_by_patient
  # print out a list of patient's names
  # ask user to choose which patient's appointments they want to view
  # use your Appointment class method by_patient to get the relevant
  # appointments and call print on each
  Appointment.all.map{|appt| appt.patient}.uniq.map do |patient|
    puts patient
  end
  puts "Type the name of the patient whose appointments you'd like to view:".cyan
  patient = ask_for_input
  puts "Here are the appointments for #{patient}".light_green
  Appointment.by_patient(patient).each do |appointment|
    appointment.print
  end
end