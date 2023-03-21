#!/opt/conda/bin/python

# import libs
import csv
import sys, getopt
import os

def read_arguments(argv):

    insheet = ''
    outsheet = ''
    indextype = ''

    usage="> Usage: ctg-parse-samplesheet.10x.py -s INPUT-SHEET -o OUTPUT-SHEET -i INDEX-TYPE [ -h HELP ] \n\n> Required columns (with the following header names): \n [Lane,Sample_ID,index,Sample_Project]. \n - 'Lane' entries can be left blank if all lanes included. \n - 'index' entries must be ID (e.g. SI-TT-E4) if dual index."

    try:
        opts, args = getopt.getopt(argv,"hs:o:i:",["insheet=", "outsheet=", "indextype="])
    except getopt.GetoptError:
        print(usage)
        sys.exit(2)
    if len(sys.argv) <= 3:
        print("> Error: please specify all arguments:")
        print(usage)
        sys.exit()
    for opt, arg in opts:
        if opt == '-h':
            print(usage)
            sys.exit()
        elif opt in ("-s", "--insheet"):
            insheet = arg
        elif opt in ("-o", "--outsheet"):
            outsheet = arg
        elif opt in ("-i", "--indextype"):
            indextype = arg   
            
    return insheet, outsheet, indextype

def main(argv):

    insheet, outsheet, index = read_arguments(argv)

    # Checks if there are duplicate index or sample by comparing the list length to the set length
    # Added by Jacob Karlstrom 22 06 08
    with open(insheet, 'r') as infile:
        infile.readline()
        first_row = infile.readline().strip().split(',')
        index_col, sample_col = first_row.index('index'), first_row.index('Sample_ID')
        data = [x.strip().split(',') for x in infile.readlines()]
        index_list, index_set = [x[index_col] for x in data], set([x[index_col] for x in data])
        sample_list, sample_set = [x[sample_col] for x in data], set([x[sample_col] for x in data])

        if  len(index_set) != len(index_list) or len(sample_set) != len(sample_list):
            raise ValueError('Error: Duplicate index or sample ID found.')
    with open(outsheet, 'w') as outfile:
        writer = csv.writer(outfile)
        writer.writerow(['[Data]'])
        
        if index == 'dual':
            writer.writerow(['Lane','Sample_ID','Sample_Name','Sample_Plate','Sample_Well','I7_Index_ID','index','I5_Index_ID','index2','Sample_Project'])
        else:
            writer.writerow(['Lane','Sample_ID','index','Sample_Project'])
            
        with open(insheet, 'r') as infile:
            my_reader = csv.reader(infile, delimiter=',')
            next(infile) # Skip first line ([Data])
            # row counter to define first line
            row_idx=0
            for row in my_reader:
                # if first line - get index of the 3 columns needed
                if row_idx == 0:
                    if 'Lane' in row:
                        laneidx = row.index('Lane')
                    else:
                        laneidx = 'na'
                    sididx  = row.index('Sample_ID')
                    idxidx  = row.index('index')
                    projidx = row.index('Sample_Project')
                else:
                    if laneidx == 'na':
                        currlane = ''
                    else:
                        currlane = row[laneidx]
                    currsid = row[sididx]
                    curridx = row[idxidx]
                    currproj = row[projidx]
                    
                        
                    if index == 'dual':
                        writer.writerow([currlane,currsid,currsid,'','',curridx,curridx,curridx,curridx,currproj])
                    else:
                        writer.writerow([currlane,currsid,curridx,currproj])

		   
                row_idx += 1


if __name__ == "__main__":
    main(sys.argv[1:])
