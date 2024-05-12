#!/bin/bash

# Check if an argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <input_number>"
    exit 1
fi

# Extract the input number from the command-line argument
input_number=$1

# Check if the input number is a valid integer
if ! [[ "$input_number" =~ ^[1-2]+$ ]]; then
    echo "Error: Input must be a valid integer."
    exit 1
fi

# Run the slang demo with the input number
slang src/demo$input_number.sv
