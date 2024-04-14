import binascii

conv_ls = [ 'utf-8 to HEX' , 'HEX to utf-8' ]

print ( 'Hi! What type of conversion would you like to perform today?\n' )
print ( '1) ' + conv_ls[0].title() + '\n' + '2) ' + conv_ls[1].title() + ' \n' )

choice = input ()


if choice.casefold () == conv_ls [0] or choice == '1' :

    utf = input ( '\n'+ 'Please input UTF-8: ' )

    #  str. seems to be indicating the data type while
    # .encode seems to be what turns the variable within () to its byte representation
    # a blank .encode() is utf8 by default

    utf_bytes = str.encode ( utf )

    # hexlify then turns bytes to its hex value
    # note that hexlify requires bytes in order to work

    hex_num = binascii.hexlify ( utf_bytes )

    # .decode gets rid of 'b at the start of the value
    # or rather it turns the hex number from bytes to string

    print ( 'This is your HEX number: ' + hex_num.decode() )

elif choice.casefold () == conv_ls [1] or choice == '2' :
    
    hx = input ( '\n' + 'Please input HEX number: ')
    
   # we dont have to use str.encode as unhexlify operates based on a hex string not bytes

    utf_txt = binascii.unhexlify(hx)
    
    print ( 'This is your UTF-8 text: ' + utf_txt.decode() )

else:

    print ( '\n' + 'That is NOT an option >:( ')


input ( '\n\n' + 'Press ENTER to exit.')
