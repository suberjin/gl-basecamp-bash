#!/usr/bin/env bash
shopt -s extglob

# Declare necessary variables and arrays
declare -i i=0
declare -a FORMATTED_EXPRESSION RESULT TEMP # expression, operand, numbers
declare -A PRIORITY # elements priority

# Set priority for each element
PRIORITY=(["("]=1 [")"]=1 ["-"]=2 ["+"]=2 ["*"]=3 ["/"]=3)

source validation.sh # include validation functions
source operations.sh # include math functions
source prepare_experssion.sh # generate Reverse Polish notation string
source calculation.sh # calculate everything

read -p "Enter expression: " INPUT_EXPRESSION
validate_expression $INPUT_EXPRESSION

prepare_expession
convert_polish_notation

# Print final result
echo "Result is $(calculate)"

exit 0
