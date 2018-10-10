class MotorCycle

	attr_accessor :merk, :milik, :tahun, :type, :kecepatan, :bensin, :jarak_tempuh, :waktu_tempuh

		LITER_BENSIN = 109.8
		HOURS = 3600
		

	def initialize(merk = "Yamaha", milik = "Lufy", tahun = 2018, type = "Matic", bensin = 1)
		if bensin >= 0 
			@merk = merk
			@milik = milik
			@tahun = tahun
			@jam_awal = 0
			@jarak_awal = 0
			@type = type
			@bensin_awal = bensin
			@bensin_awal_edit = bensin
		elsif 
			puts "Bensin kurang dari 0 "	
		end
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
end