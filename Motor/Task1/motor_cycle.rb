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
	end
	
	def refill(bensin)
		if bensin >= 0	
			@bensin = (@bensin + bensin)
			puts "Bensin saat ini: #{@bensin} Liter"
		else
			puts "bensin tidak boleh kurang dari 0"	
		end
	end

 	def run(waktu)
 		if waktu >= 1
			@jam = waktu.to_f / JAM.to_f
			@jarak = @jam * KECEPATAN 
			@jarak_tempuh_bensin = @bensin.to_f * JARAK_PER_LITER.to_f 
			if @jarak > @jarak_tempuh_bensin.to_f 
				if @jarak_tempuh_bensin == 0.0
					@jarak = @jarak_tempuh_bensin
					puts "bensin anda kosong"
				else
					@bensin = 0
					@jarak = @jarak_tempuh_bensin
					puts "jarak yang seharusnya di tempuh #{@jam * KECEPATAN}"
					puts "kemampuan jarak tempuh anda hanya #{@jarak_tempuh_bensin} KM"
				end
			else
				@bensin = (@jarak_tempuh_bensin.to_f - @jarak.to_f) / JARAK_PER_LITER.to_f
			
				puts "jarak yang di tempuh sekarang #{@jarak} km"
			end
		elsif 
			puts "waktu kurang dari 1 detik"
		end
		@total_jarak = @total_jarak.to_f + @jarak.to_f 
		@waktu_tempuh = @waktu_tempuh + @jam
		puts "total waktu_tempuh #{@waktu_tempuh} Jam"
		puts "sisa bensin #{@bensin} Liter"  
		puts "total jarak tempuh #{@total_jarak} KM"
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
	
 	def reset
 		@bensin = @bensin_awal
 		@jam = @jam_awal
 		@total_jarak = @jarak_awal
 		@waktu_tempuh = @waktu_awal
		status
	end

	def create
		#create new object MotorCycle and add to list
	end

	def list
		# description: display list motorcycle
		# input: none
		# output: list object motorcycle
	end

	def choose
		# description: choose motorcycle
		# input: name of motorcycle
		# output: 1 object motorcycle that chosen

	end

	def remove
		# description: remove object motorcycle from list
		# input: name of motorcycle
		# output: 1 object motorcycle that has been delete
	end

	def print_all
		# Motor apa yang dipilih, 
		# Sekarang motornya ada apa saja
		# Yamaha - O2jan (10L , jarak tempuh 20 KM, Waktu tempuh 3 jam 10 menit 3 detik)
		# (chosen) Yamaha - Ojan (10L , jarak tempuh 20 KM, Waktu tempuh 3 jam 10 menit 3 detik)
		# Yamaha - O7jan (10L , jarak tempuh 20 KM, Waktu tempuh 3 jam 10 menit 3 detik)

	end
end 