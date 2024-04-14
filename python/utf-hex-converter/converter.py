hex_str = input ("Insert Hexadecimal Number: ")
hex_arry = bytearray.fromhex( hex_str )
ascii = hex_arry.decode('utf-8')

print(ascii)
