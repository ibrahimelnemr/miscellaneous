
######################## Encoding Function

def encode(infilename, outfilename):
    
    # Open file 
    
    infile = open(infilename, 'r')
    
    # Read all characters from file 

    inputstr = infile.read()

    # Store the length of the input file for future reference

    decodedfilelen = len(inputstr)

    infile.close()

    # Initialize key variables
    
    mydict=[] # the dictionary
    dictindex = 0
    encodedstr = [] # the string of indices that correspond to entries in the dictionary
    encodedstr_amt = 0 # variable that keeps track of the amount of original string encoded


    # create initial dictionary from set of all characters in initial input string
    mydict = list(set([char for char in inputstr]))
    
    print("Initial dictionary: ", mydict)

    # initial longest string in dictionary 
    print("Maximum length str in dict: ", max(mydict, key=len))


    # start main encoding loop
    # until the length of the amount of string encoded is equal to the length of the original string
    while encodedstr_amt < len(inputstr):


        # iterate over each item in dictionary
        # encodedstr_val variable keeps track of the length of string that has been encoded so far, since the encoded version does not correspond in length to the original
        
        for item in mydict:
            
            # find the dictionary item in the remaining string to be encoded
            if item in inputstr[encodedstr_amt:] and inputstr[encodedstr_amt: ].find(item) == 0:
                
                # add it to the dictionary
                encodedstr.append(str(mydict.index(item)))
                
                # keep track of length of string encoded so far
                encodedstr_amt += len(item)
                
                newdictval = inputstr[len(encodedstr) - 1: len(encodedstr) + len(item)]
                
                if newdictval not in mydict:
                    mydict.append(newdictval)
                
                
                print("Length of Encoded String: ", len(encodedstr))
                
                print("Amount of input string remaining: ", len(inputstr) - encodedstr_amt)
                print("Amount of input string decoded: ", encodedstr_amt)
                
                print("Length of Dictionary: ", len(mydict))

    print("Dictionary: ", mydict)        
    
    print("ENCODED string: ", ' '.join(encodedstr))
    print("Length of Dictionary: ", len(mydict))

    # Write encoded string to outfile
    outfile = open(outfilename, 'w')
    outfile.write(' '.join(encodedstr))

    # Write a newline
    outfile.write("\n")
    
    # Write the dictionary items separated by newspaces
    for item in mydict:
        outfile.write(item)
        outfile.write(' ')
    
    outfile.close()

    # open the outfile to read and determine length of encoded file
    outfile_read = open(outfilename, 'r')
    outfile_contents = outfile_read.read()
    encodedfilelen = len(outfile_contents)

    # compute and print compression ratio
    compression_ratio = 1 - encodedfilelen / decodedfilelen
    print("Compression Ratio: ", compression_ratio)

    # if file has been reduced in size, file size compressed by positive amount, else by negative amount
    if compression_ratio > 0:
        print("This compression will reduce file size by {:.2f}%".format(compression_ratio*100))
    else:
        print("This compression will increase file size by {:.2f}%".format(-compression_ratio*100))

    print("Length of Original File (characters): ", decodedfilelen)
    print("Length of Encoded File (characters): ", encodedfilelen)
    
    print("Length of Dictionary: ", len(mydict))
    outfile_read.close()


######################## Decoding Function

def decode(infilename, outfilename):

    # Open encoded file
    infile = open(infilename, 'r')

    # read all characters from file
    infileinput = infile.read()

    # take note of length of encoded files
    encodedfilelen = len(infileinput)
    
    
    # store encoded string in list variable
    encodedstr = infileinput.split('\n')[0].split(' ')

    # store dictionary in list variable
    mydict = infileinput.split('\n')[1].split(' ')
    
    # print(encodedstr)
    # print(mydict)

    # close file
    infile.close()

    #open output file
    outfile = open(outfilename, 'w+')

    # initialize list for decoded string
    decodedstr = []

    # decode each item in the encoded string using its corresponding item in the dictionary
    for number in encodedstr:
        decodedstr.append(mydict[int(number)])
    
    # write the decoded string to the outfile
    outfile.write("".join(decodedstr))
    outfile.close()


    # Checking for file length and compression ratio

    # open the file with the decoded (original) string
    decodedfile = open(outfilename, 'r')

    # read all characters
    decodedfilecontents = decodedfile.read()
    
    # determine number of characters in original string
    decodedfilelen = len(decodedfilecontents)

    decodedfile.close()

    print("Length of encoded file: ", encodedfilelen)
    print("Length of decoded file: ", decodedfilelen)

    # Compute compression ratio
    compression_ratio = 1 - encodedfilelen / decodedfilelen

    print("Compression Ratio: ", compression_ratio)

    # if file has been reduced in size, file size compressed by positive amount, else by negative amount

    if compression_ratio > 0:
        print("This compression will reduce file size by {:.2f}%".format(compression_ratio*100))
    else:
        print("This compression will increase file size by {:.2f}%".format(-compression_ratio*100))
    

######################## User-Prompted Inputs / Outputs

# Prompt the user for correct input until they enter it, if incorrect, then prompt them again
while True:
    task = input("Would you like to encode (e) or decode (d)?: ")

    if task != 'e' and task != 'd':
        print("You must enter either e or d")
        continue
    break

# Get name of input and output files
infilename = input("Enter name of input file: ")
outfilename = input("Enter name of output file: ")

# Open the infile, print error message if file name is invalid
try:
    infile = open(infilename, 'r')
except Exception as e:
    print(e)
    print("You entered an invalid input file name.")

# Open the outfile, print error message if file name is invalid
try:
    outfile = open(outfilename, "w")
except Exception as e:
    print(e)
    print("You entered an invalid output file name")

# Test values
# infilename = "input.txt"  #encoding
# outfilename = "output.txt" #encoding

if task == 'e':
    encode(infilename, outfilename)

elif task == 'd':
    decode(infilename, outfilename)