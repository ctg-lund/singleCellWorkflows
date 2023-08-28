import sys

# Check if input file name was provided
if len(sys.argv) < 3:
    print('Usage: python countmetric2mqc.py file.csv sample_name output_mqc.yaml')
    sys.exit(1)

# Get input file name from command-line argument
input_file = sys.argv[1]
sample_name = sys.argv[2]
mqc_yaml = sys.argv[3]
# Initialize dictionaries for each category
with open(input_file, 'r') as file:
    keys, values = file.readline().split(','), file.readline().split(',')
    data = {k.strip():v.strip() for (k,v) in zip(keys,values)}
# Appends to an already existing mqc.yaml file
with open(mqc_yaml, 'a') as file:
    file.write(f'  {sample_name}: {data}')