#filenames = ['1.Raw Data.txt', '2.Reports.txt', '3.Presentation.txt']

#for file in filenames:
#    file = file.replace('.',')',1)
#    print (file)


ls = input ("what is it?")


with open (ls, 'w') as f:
    while True:
        f.write(input())


