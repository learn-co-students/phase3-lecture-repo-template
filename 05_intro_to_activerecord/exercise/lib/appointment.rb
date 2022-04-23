class Appointment < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :patient

  def cancel
    @canceled = true
  end

  def print
    puts ""
    if self.canceled 
      puts "#{self.time} (canceled)".red
    else 
      puts self.time.light_green
    end
    puts "  Doctor: #{self.doctor.name}"
    puts "  Patient: #{self.patient.name}"
    puts "  Purpose: #{self.purpose}"
    puts "  Notes: #{self.notes}"
    puts ""
  end

  # @@all = nil

  # def self.all
  #   rows = DB.execute("SELECT * FROM appointments")
  #   @@all ||= rows.map do |row|
  #     self.new_from_row(row)
  #   end
  # end

  # def self.new_from_row(row)
  #   self.new(row.transform_keys(&:to_sym))
  # end

  # def self.create(attributes)
  #   self.new(attributes).save
  # end

  # def self.by_doctor(doctor)
  #   self.all.filter do |appointment|
  #     appointment.doctor == doctor
  #   end
  # end

  # def self.by_patient(patient)
  #   self.all.filter do |appointment|
  #     appointment.patient == patient
  #   end
  # end

  # attr_accessor :time, :doctor, :patient, :purpose, :notes, :canceled  
  # attr_reader :id
  # def initialize(id: nil, time:, doctor:, patient:, purpose:, notes: nil, canceled: nil)
  #   @id = id
  #   @time = time
  #   @doctor = doctor
  #   @patient = patient
  #   @purpose = purpose
  #   @notes = notes
  #   @canceled = canceled
  # end

  # def save
  #   if id 
  #     query = <<-SQL
  #       UPDATE appointments
  #       SET time = ?,
  #           doctor = ?,
  #           patient = ?,
  #           purpose = ?,
  #           notes = ?,
  #           canceled = ?
  #       WHERE
  #           id = ? 
  #     SQL
  #     DB.execute(
  #       query,
  #       self.time,
  #       self.doctor,
  #       self.patient,
  #       self.purpose,
  #       self.notes,
  #       self.canceled
  #     )
  #   else
  #     query = <<-SQL
  #       INSERT INTO appointments 
  #       (time, doctor, patient, purpose, notes, canceled)
  #       VALUES
  #       (?, ?, ?, ?, ?, ?)
  #     SQL
  #     DB.execute(
  #       query,
  #       self.time,
  #       self.doctor,
  #       self.patient,
  #       self.purpose,
  #       self.notes,
  #       self.canceled
  #     )
  #     @id = DB.execute("SELECT last_insert_rowid()")[0]["last_insert_rowid()"]
  #     Appointment.all << self
  #   end
  #   self
  # end

  

  
end

