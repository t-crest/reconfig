#!/usr/bin/python

#Python 3 script: bitfile2Carray
#Functionality: The script converts a bitstream file (e.g., .bin) into a C array values. 

import sys

#Creating or overwriting the destination file d
d = open('./config_1.c','w')

#Writing the header
d.write('/*Reconfiguration data stream*/\n\n')

#Counting the bytes in the file and writing length variable
f = open('./config_1_recon_wire_comp_led_wire_partial.bin','rb')
recon_length = 0
while f.read(1):
	recon_length += 1
f.close()
d.write('const unsigned int RECON_1_LENGHT = ' + str(recon_length) + ';\n\n')

#Converting the file
f = open('./config_1_recon_wire_comp_led_wire_partial.bin','rb')
d.write('const unsigned char recon_1_array[' + str(recon_length) + '] = {')
a = f.read(1)
while a:
#	print(int.from_bytes(a,'big'))
	d.write(str(int.from_bytes(a,'big')))
	a = f.read(1)
	if a:
		d.write(', ')
d.write('};\n')
f.close()	

#while True:
#	a=f.read(1)
#	if not a:
#        	break
#	print(int.from_bytes(a,'big'))
#	d.write(str(int.from_bytes(a,'big')))
#	d.write(', ')
#d.write('\b\b};\n')

