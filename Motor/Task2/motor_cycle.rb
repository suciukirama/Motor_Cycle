class MotorCycle
 	
 	attr_accessor :merk,
 				  :milik,
 				  :tahun,
 				  :type,
 				  :kecepatan,
 				  :bensin,
 				  :jarak_tempuh,
 				  :waktu_tempuh

	JARAK_PER_LITER = 109.8 # km / liter
	JAM = 3600 				# in second
	KECEPATAN = 60 			# km/hour
	
	@@motor = Hash.new()
 	def initialize(merk = "Yamaha", milik = "Lufy", tahun = 2018, type = "Matic", bensin = 0)
 		puts "Bensin kurang dari 0 " if bensin < 0 
		@merk 			= merk
		@milik			= milik
		@tahun 			= tahun
		@waktu_awal 	= 0
		@jarak_awal 	= 0
		@type 			= type
		@bensin_awal 	= bensin
		@bensin 		= bensin
		@jarak 			= 0
		@waktu_tempuh 	= 0
		# @@motor[@milik] = {}
		# @@motor[@milik][:milik] = @milik.to_sym
		# @@motor[@milik][:merk] = @merk.to_sym
		# @@motor[@milik][:tahun] = @tahun
		# @@motor[@milik][:bensin] = @bensin
		# @@motor[@milik][:type] = @type
		# @@motor[@milik][:jarak_tempuh] = @jarak
		# @@motor[@milik][:waktu_tempuh] = @waktu_tempuh
		# puts "Motor #{@milik} succesfully created"
		

	end

	def self.create(motor)
		@@motor[:index] = {}
		@@motor[:index][:milik] = motor.milik.to_sym
		@@motor[:index][:merk] = motor.merk.to_sym
		@@motor[:index][:tahun] = motor.tahun
		@@motor[:index][:bensin] = motor.bensin
		@@motor[:index][:type] = motor.type
		@@motor[:index][:jarak_tempuh] = 0
		@@motor[:index][:waktu_tempuh] = 0
		puts "Motor #{motor.milik} succesfully created"
	end

	def get_motor
		@@motor
	end

	def self.choose(keyword)
		if keyword
			found = @@motor.select do |key, value|
				value[:milik].to_s.include?(keyword)
			end
			output_motor_cycle_table(found)

		else
			puts "Please find by name"
			puts "Example: choose('Lufy')"
		end
	end

	def self.remove(keyword)
		@@motor.delete(keyword)
		puts "Motor #{keyword} deleted"
	end

	def self.list
		output_motor_cycle_table(@@motor)
	end

	def self.output_motor_cycle_table(motorcycle=[])
			print "Merk".ljust(13)
			print 'Pemilik'.ljust(13)
			print 'Tahun'.ljust(13)
			print 'Type'.ljust(13)
			print 'Bensin'.ljust(13)
			print 'Jarak Tempuh'.ljust(15)
			print 'Waktu Tempuh'.ljust(13)
			puts " "
			puts "-" * 93

			motorcycle.each do |key, value|
				line = " " << "#{value[:milik].to_s}".ljust(13)
				line << " " + "#{value[:merk].to_s}".ljust(13)
				line << " " + "#{value[:tahun]}".ljust(13)
				line << " " + "#{value[:type]}".ljust(13)
				line << " " + "#{value[:bensin]} L".ljust(13)
				line << " " + "#{value[:jarak_tempuh]} KM ".ljust(13)
				line << " " + "#{value[:waktu_tempuh]} JAM ".ljust(13)
				puts line

			end
			puts "No listing found" if @@motor.empty?
			puts "-" * 93
	end
	
	def refill(keyword, bensin)
		if bensin >= 0	
			@@motor.select do |key, value|
				if value[:milik].to_s.include?keyword
					@bensin = value[:bensin]
					@bensin = (@bensin + bensin)
					value[:bensin] = @bensin
					puts "Bensin anda sekarang #{value[:bensin]}"
				else
					puts "Motor not found"
				end
			end
		else
			puts "bensin tidak boleh kurang dari 0"	
		end
	end

 	def run(keyword, waktu)
 		if waktu >= 1
			@jam = waktu.to_f / JAM.to_f
			@jarak = @jam * KECEPATAN 

			@@motor.select do |key, value|
				if value[:milik].to_s.include?keyword
					@bensin = value[:bensin]
					@jarak_tempuh_bensin = @bensin.to_f * JARAK_PER_LITER.to_f 
					if @jarak > @jarak_tempuh_bensin.to_f 
						if @jarak_tempuh_bensin == 0.0
							@jarak = @jarak_tempuh_bensin
							puts "bensin anda kosong"
						else
							# @bensin = 0
							@bensin = 0
							@jarak = @jarak_tempuh_bensin
							puts "jarak yang seharusnya di tempuh #{@jam * KECEPATAN}"
							puts "kemampuan jarak tempuh anda hanya #{@jarak_tempuh_bensin} KM"
						end
					else
						@bensin = (@jarak_tempuh_bensin.to_f - @jarak.to_f) / JARAK_PER_LITER.to_f
					
						puts "jarak yang di tempuh sekarang #{@jarak} km"
					end
						@total_jarak = @total_jarak.to_f + @jarak.to_f 
						value[:jarak_tempuh] = value[:jarak_tempuh] + @jarak.to_f 
						@waktu_tempuh = @waktu_tempuh + @jam
						value[:waktu_tempuh] = value[:waktu_tempuh] + @jam
						value[:bensin] = @bensin
						puts "total waktu_tempuh #{value[:waktu_tempuh]} jam"
						puts "sisa bensin #{value[:bensin]} liter"  
						puts "total jarak tempuh #{value[:jarak_tempuh]} km"
				else
					puts "Motor not found"
				end
					
			end
		else 
			puts "waktu kurang dari 1 detik"
		end

	end

 	def status	 
		identitas_motor = ["Merk #{@merk}",  
						   "milik #{@milik}" , 
						   "tahun #{@tahun}" , 
						   "type #{@type}",
						   "kecepatan 60 km/jam", 
						   " bensin #{@bensin} Liter" ,
						   "jarak tempuh #{@jarak_total || @jarak_awal }km" ,
						   " waktu tempuh #{@waktu_tempuh} jam"]
		puts identitas_motor.join("\n")
	end
	
 	def reset(keyword)
 		@@motor.select do |key, value|
				if value[:milik].to_s.include?keyword
					@bensin = @bensin_awal
 					@jam = @jam_awal
 					@total_jarak = @jarak_awal
 					@waktu_tempuh = @waktu_awal		
				end
		end
 		@bensin = @bensin_awal
 		@jam = @jam_awal
 		@total_jarak = @jarak_awal
 		@waktu_tempuh = @waktu_awal
		status
	end

	def reset_all
		@@motor.select do |key, value|
			value[:bensin] = @bensin_awal
			value[:jarak_tempuh] = @jarak_awal
			value[:waktu_tempuh] = @waktu_awal
		end
		status
	end


	def print_all
		# Motor apa yang dipilih, 
		# Sekarang motornya ada apa saja
		# Yamaha - O2jan (10L , jarak tempuh 20 KM, Waktu tempuh 3 jam 10 menit 3 detik)
		# (chosen) Yamaha - Ojan (10L , jarak tempuh 20 KM, Waktu tempuh 3 jam 10 menit 3 detik)
		# Yamaha - O7jan (10L , jarak tempuh 20 KM, Waktu tempuh 3 jam 10 menit 3 detik)

	end
end 