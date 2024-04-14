# Seperating things can help with debugging in bigger projects
usr_prmpt = 'Type add, show, edit, complete, or exit: '
action = input ( usr_prmpt )
action = action.strip().casefold()

ls = []
y = 'yes'
n = 'no'


if action == 'add' : 

    while True:

        ls_entry = input( '\n' + 'Entry: ')
        ls.append( ls_entry.capitalize() )
        print ( '\n' + 'This is your list: \n' + str( ls ) )
        
        choice = input ( '\n' + 'Would you like to add another entry? \n' + 'Yes   ' + 'No\n\n')
        choice = choice.casefold().strip()

        if choice == n:
            print( '\n' + 'This is your final list: \n')
            for item in ls:
                
                print(item)
            
            ext = input('Press ENTER to exit.\n')

            if ext != True:
                exit()

if action == 'show':
    print( 'This is your list: \n' + str(ls) )
