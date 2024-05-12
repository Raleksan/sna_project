#!/bin/bash

# Define the directory path
directory="src/schoolRISCV"

# Define file contains top module
top_module_file="$directory/tb.sv"

# Process all design strting from top module
# Using all files from 'include path' with select pattern
slang "$top_module_file" -v $directory/*.sv*
