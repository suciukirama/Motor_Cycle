require 'motor_cycle'

class Guide

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
			print "> "
			user_response = gets.chomp
			result = do_action(user_response)
		
		#what you want to do (list, add, find, quit)
		#do that action
		#repeat until user quit
		end
		conclusion
	end

	def do_action(action)
		case action
		when 'list'
			puts "Listing.."
		when 'find'
			puts "Finding.."
		when 'add'
			puts "Adding.."
		when 'quit'
			return :quit
		else
			puts "\n Indont Understand that command \n"

		end
	end

	def introduction
		puts "\n\n Welcome to Motor "
		puts "This is interactive guide to help you organize Motor . \n\n"
	end

	def conclusion
		puts "\n\n Good Bye \n\n"
	end
end

