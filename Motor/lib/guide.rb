require 'motor_cycle'

class Guide

	class Config
		@@actions = ['list', 'choose', 'add', 'delete','quit', 'run', 'refill']
		def self.actions; @@actions; end
	end

	def initialize(path=nil)
		#locate the restaurant text file at path
		MotorCycle.filepath = path
		if MotorCycle.file_usable? 
			puts "Found Motor  File"
		elsif MotorCycle.create_file
			puts "Create Motor  File"
		else
			puts "Exiting"
			exit!
		end
		#or create a new file
		#exit if create fails
	end

	def launch!
		introduction
		#action_loop
		result =nil
		until result == :quit 
			action, args = get_action
			result = do_action(action, args)
		end
		conclusion
	end

	def get_action
		action = nil

		until Guide::Config.actions.include?(action)
			puts "Actions: " + Guide::Config.actions.join(", ") if action
			print "> "
			user_response = gets.chomp
			args = user_response.strip.split(' ')
			action = args.shift
		end
		return action, args
	end

	def do_action(action,args=[])
		case action
		when 'list'
			list
		when 'choose'
			keyword = args.shift
			choose(keyword)
		when 'add'
			add
		when 'delete'
			keyword = args.shift
			delete(keyword)
		when 'run'
			puts "Which motor you want to run?"
			milik = gets.chomp
			puts 'How long you want to run?'
			waktu = gets.chomp
			run(waktu, milik)
		when 'refill'
			puts "Which motor you want to refill?"
		when 'quit'
			return :quit
		else
			puts "\n I dont Understand that command \n"

		end
	end

	def list
		output_action_header("Listing Motor Cycle")
		motor_cycle = MotorCycle.saved_motor_cycles
		output_motor_cycle_table(motor_cycle)
	end

	def add
		output_action_header("Adding Motor Cycle")
		motor_cycle = MotorCycle.build_from_questions
		if motor_cycle.save
			puts "\n Data Motor telah tersimpan\n\n"
		else
			puts "\n Data Motor gagal tersimpan\n\n"
		end
	end

	def choose(keyword="")
		output_action_header("Find a Motor Cycle")
		if keyword
			motor_cycle = MotorCycle.saved_motor_cycles
			found = motor_cycle.select do |motor|
				motor.milik.downcase.include?(keyword.downcase)
			end
			output_motor_cycle_table(found)
		else
			puts "Please find by name"
			puts "Example: find Zoro"
		end
	end

	def delete(keyword=nil)
		if keyword
					MotorCycle.write_delete(keyword)
					puts "#{keyword} deleted"
		else
			puts "Please find by name"
			puts "Example delete Zoro"
		end	
	end

	def run(waktu, milik)
		if milik
			MotorCycle.run(waktu, milik)
			puts "success"
		else
			puts "Please insert time and name"
			puts "Example run 3000 Zoro"
		end
	end



	def introduction
		puts "\n\n Welcome to Motor "
		puts "This is interactive guide to help you organize Motor . \n\n"
		puts "-- add for adding Motor data . \n"
		puts "-- list for list of data Motor data . \n"
		puts "-- delete for remove Motor data . \n"
		puts "-- add for adding Motor data . \n"
		puts "-- choose for show selected Motor data . \n"
		puts "-- run for run your Motor . \n"
		puts "-- refill for adding Motor data . \n"
	end

	def conclusion
		puts "\n\n Good Bye \n\n"
	end



		def output_action_header(text)
			puts "\n#{text.upcase.center(60)}\n\n"
		end

		def output_motor_cycle_table(motor_cycle=[])
			print "Merk".ljust(20)
			print 'Pemilik'.ljust(20)
			print 'Tahun'.ljust(20)
			print 'Type'.ljust(20)
			print 'Bensin'.ljust(20)
			puts " "
			puts "-" * 100

			motor_cycle.each do |motor|
				line = " " << "#{motor.merk}".ljust(20)
				line << " " + "#{motor.milik}".ljust(20)
				line << " " + "#{motor.tahun}".ljust(20)
				line << " " + "#{motor.type}".ljust(20)
				line << " " + "#{motor.bensin}".ljust(20)
				puts line

			end
			puts "No listing found" if motor_cycle.empty?
			puts "-" * 100
		end
end

