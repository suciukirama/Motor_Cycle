require 'fileutils'
class MotorCycle

	attr_accessor :merk, :milik, :tahun, :type, :kecepatan, :bensin, :jarak_tempuh, :waktu_tempuh

		LITER_BENSIN = 109.8
		HOURS = 3600
		
	def self.build_from_questions
		args = {}
		print "Merk\t"
		args[:merk] = gets.chomp.strip 
		print "Milik\t"
		args[:milik] = gets.chomp.strip
		print "Tahun\t"
		args[:tahun] = gets.chomp.strip
		print "Tipe Motor\t" 
		args[:type] = gets.chomp.strip
		print "Bensin\t" 
		args[:bensin] = gets.chomp.strip
		return self.new(args)
	end

	def initialize(args={})
		# if args[:bensin] >= 0 
			@merk 				= args[:merk] 	
			@milik 				= args[:milik] 	
			@tahun 				= args[:tahun] 	
			@type 				= args[:type] 	
			# @bensin_awal_edit 	= args[:bensin] 
			@jam_awal = 0
			@jarak_awal = 0
			@bensin 			= args[:bensin]
		# elsif 
		# 	puts "Bensin kurang dari 0 "	
		# end
	end
	
	def refill(bensin)
		if bensin >= 0 
			@bensin = (@bensin || @bensin_awal_edit) + bensin
			puts @bensin
		else 
			puts "bensin tidak boleh kurang dari 0"	
			
		end
	end

	def run(waktu)

		if waktu >= 1
			# liter_bensin = 109.8
			#detik ubah ke @jam
			@jam = waktu.to_f / 3600.to_f
			@jarak = @jam * 60 
			puts LITER_BENSIN
			puts @bensin
			if @bensin != nil
				abiltity_gas = @bensin * LITER_BENSIN
				@bensin = (@bensin.to_f * LITER_BENSIN) - @jarak.to_f / LITER_BENSIN
			elsif 
				abiltity_gas = @bensin_awal_edit * LITER_BENSIN	
				@bensin = ((@bensin_awal_edit.to_f * LITER_BENSIN) - @jarak.to_f) / LITER_BENSIN
			end
			
			if @jarak > abiltity_gas 
				if abiltity_gas == 0.0
					puts "isi bensin"
				else
					puts abiltity_gas
				end	
			else
				puts @jarak
			end
		elsif 
			puts "waktu kurang dari 1 detik"
		end
		puts @bensin
	end
	#("Yamaha", "Ojan", "2018", "Vario", 60, 4)

	def status	
		# a = ["test1: test,
		# 	test2: test2"]
		# 	puts a.join(\n)
		identitas_motor =  ["Merk #{@merk}",  "milik #{@milik}" , "tahun #{@tahun}" , "type #{@type}",
												"kecepatan 60 km/jam", " bensin #{@bensin || @bensin_awal} Liter" ,
												"jarak tempuh #{@jarak || @jarak_awal }km" , " waktu tempuh #{@jam || @jam_awal} jam"]
		puts identitas_motor.join("\n")
	end

	def reset
		status_motor = "Merk #{@merk} , \n milik #{@merk} \n tahun #{@tahun} \n type #{@type} \n kecepatan 60 km/jam \n bensin #{@bensin_awal_edit} Liter"
		puts status_motor
	end

	@@filepath = nil
	def self.filepath=(path=nil)
		@@filepath = File.join(APP_ROOT, path)
		# @@output = 
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


	def self.saved_motor_cycles
		motor_cycle = []
		if file_usable? 
			file = File.new(@@filepath, 'r')
			file.each_line do |line|
				motor_cycle << MotorCycle.new.import_line(line.chomp)
			end
			file.close
		end
		return motor_cycle
	end

	def self.write_delete(keyword)
		File.open("output.txt", 'w') do |f|
			saved_motor_cycles.each do |motor|
				unless motor.milik == keyword
					f.puts "#{[motor.merk, motor.milik, motor.tahun, motor.type, motor.bensin].join("\t")}\n"
				end
			end
		end

	end

	def import_line(line)
		line_array = line.split("\t")
		@merk, @milik, @tahun, @type, @bensin = line_array
		return self #return objek nya sendiri
	end

	def save
		#read  the motor cycle file
		#return instance restaurant
		retun false unless MotorCycle.file_usable?
		File.open(@@filepath, 'a') do |file|
			file.puts "#{[@merk, @milik, @tahun, @type, @bensin].join("\t")}\n"
		end
		return true
	end
end