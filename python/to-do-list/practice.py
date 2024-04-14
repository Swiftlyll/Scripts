print ('Hello! Welcome to your list!')

prompt = 'Type add, show, edit, or exit: '

ls = []

while True:

    action = input (prompt)
    action = action.casefold().strip()

    match action:        

        case 'add':
            
            print ('\n' + 'Type DONE or EXIT when finished.\n' + '')
            
            while True :   
                user_entry = input ('Entry: ')
                end = user_entry.strip()
                user_entry = user_entry.capitalize()
                
                if end == 'DONE' or end == 'EXIT' :

                    print ('\n' + 'Returning...' + '\n')
                
                    break
                    
                elif True:    
                    ls.append(user_entry)

        case 'show':
            
            print ('')

            x = 0

            for i in ls:
                x = x + 1
                i = str ( i )
                print ( str(x) + ') ' + i )
            
            print ('')
        
        case 'edit':

            print ('')
            target = int(input('Which entry would you like to edit? '))
            target = target - 1

            new = input('New Entry: ')
            ls[target] = new.capitalize()

            print ('')

        case 'exit':
            exit()