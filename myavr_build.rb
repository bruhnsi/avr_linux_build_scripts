#!/usr/bin/env ruby


if !ARGV.empty? then

	filename = ARGV[0].split('.')[0];
	puts "#{filename} wird uebersetzt und gebrant"


	if system("avr-gcc -c -x assembler-with-cpp -mmcu=atmega8 #{ARGV[0]} -o #{filename}.o") then
		puts "erfolgreich kompieliert"
	else
		puts '\n ----------------------------------------------------------------- '
		puts 'Fehler beim uebersetzen'
		return
	end

	if system("avr-ld #{filename}.o -o #{filename}.elf") and system("avr-objcopy -O ihex #{filename}.elf #{filename}.hex") then
		puts 'linking succes'
	else
		puts '\n ----------------------------------------------------------------- ' 
		puts 'Fehler beim linken'
		return
	end

	system("avrdude -p m8 -c avr911 -P /dev/ttyUSB0 -U flash:w:#{filename}.hex:i");


else 
	puts "FEHLER:  kein Dateiname angegeben"
end
