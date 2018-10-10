class Motor
	@@filepath =nil
	def self.filepath=(path=nil)
		@@filepath =File.join(APP_ROOT, path)
	end

	def self.file_exists?
		#class should know if the motor_cycle file exist
		if @@filepath && File.exists?(@@filepath)
			return true
		else
			return false
		end
	end

	def self.file_usable?
		return false unless @@filepath
		return false unless File.exists?(@@filepath)
		return false unless File.readable?(@@filepath)
		return false unless File.writable?(@@filepath)
		return true
	end

	def self.create_file
		#create the motor cycle 
		File.open(@@filepath, 'w') unless file_exists?
		return file_usable?
	end

	def self.saved_restaurant
		#read  the motor cycle file
		#return instance restaurant
	end

end