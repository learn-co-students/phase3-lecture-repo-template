class Appointment
  attr_accessor :time, :doctor, :patient, :purpose, :notes, :canceled  

  def initialize(time, doctor, patient, purpose)
    @time = time
    @doctor = doctor
    @patient = patient
    @purpose = purpose
  end

  def cancel
    @canceled = true
  end

  def print
    puts ""
    if @canceled 
      puts "#{@time} (canceled)".red
    else 
      puts @time.light_green
    end
    puts "  Doctor: #{@doctor}"
    puts "  Purpose: #{@purpose}"
    puts "  Notes: #{@notes}"
    puts ""
  end

  def valid?
    @time != "" && @doctor != "" && @patient != "" && @purpose != ""
  end
end