#!/usr/bin/env ruby


errorMsg = '-'*42+"\n Error: "

if !ARGV.empty? then

	filename = ARGV[0].split('.')[0];
	puts "--- #{ARGV[0]} wird uebersetzt und gebrant ---"


	if system("avr-gcc -c -x assembler-with-cpp -mmcu=atmega8 #{ARGV[0]} -o #{filename}.o") then
		puts "--- avr-gcc erfolgreich ---"
	else
		puts erroeMsg+'beim uebersetzen'
		exit
	end

	if system("avr-ld #{filename}.o -o #{filename}.elf") and system("avr-objcopy -O ihex #{filename}.elf #{filename}.hex") then
		puts '--- linken erfolgreich ---'
	else
		puts errorMsg+'beim linken'
		exit
	end

	if (system("avrdude -p m8 -c avr911 -P /dev/ttyUSB0 -U flash:w:#{filename}.hex:i")) then
		puts '--- flashen erfolgreich ---'
	else
		puts errorMsg+'beim flashen'
		exit
	end
else 
	puts errorMsg+"kein Dateiname angegeben"
end
