import csv
import json
import sys

# Check if input file name was provided
if len(sys.argv) < 3:
    print('Usage: python convert.py file.csv sample_name')
    sys.exit(1)

# Get input file name from command-line argument
input_file = sys.argv[1]
sample_name = sys.argv[2]
# Initialize dictionaries for each category
cells = {}
library = {}
other = {}

# Open CSV file
with open(input_file, 'r') as f:
    # Create CSV reader
    reader = csv.reader(f)

    # Skip header row
    next(reader)

    # Read CSV file row by row
    for row in reader:
        # Extract values from row
        category, library_type, grouped_by, group_name, metric_name, metric_value = row

        # Add metric_name and metric_value to appropriate dictionary based on category
        if category == 'Cells':
            cells[metric_name] = metric_value
        elif category == 'Library':
            library[metric_name] = metric_value
        else:
            other[metric_name] = metric_value

# Write dictionaries to JSON files
with open('{}_cells.json'.format(sample_name), 'w') as f:
    json.dump(cells, f)
with open('{}_library.json'.format(sample_name), 'w') as f:
    json.dump(library, f)
with open('{}_other.json'.format(sample_name), 'w') as f:
    json.dump(other, f)
