# Format input expression. Compile separate charsets into numbers. Read each element.
# Operators are put into final strins as is, the nubers are read till the operation occurres.
function prepare_expession () {
i=0
while [ $i -lt ${#INPUT_EXPRESSION} ]
do
    while [[ "${INPUT_EXPRESSION:$i:1}" =~ [0-9\.] && $i -lt ${#INPUT_EXPRESSION} ]]
        do
            TEMP_STRING=$TEMP_STRING${INPUT_EXPRESSION:$i:1}
            i=$i+1
        done
    if [ -n "$TEMP_STRING" ]
    then
      FORMATTED_EXPRESSION+=("$TEMP_STRING")
      TEMP_STRING=""
    fi

    if [[ ${INPUT_EXPRESSION:$i:1} =~ [-+/*()] ]]
    then
      FORMATTED_EXPRESSION+=("${INPUT_EXPRESSION:$i:1}")
      i=$i+1
    fi
done

}

# re-write expression into reverse polish notation.
# The main idea is to read expression. The numbers are put into output stack.
# Operators are read and put into final string according to priority
# Temp array is used in order to work with brackets. If symbol ) is appeared
# breakets will be deleted and all the operators will be put into output array.
function convert_polish_notation () {
i=0
while [ $i -lt ${#FORMATTED_EXPRESSION[*]} ]
do
  case ${FORMATTED_EXPRESSION[$i]} in 

      [\)\(+/*-] )
        if [[ ${#TEMP[@]} -eq 0 ]] || [[ ${FORMATTED_EXPRESSION[$i]} == "(" ]] ||  [[ ${TEMP[-1]} == "(" ]] 
        then
          TEMP+=("${FORMATTED_EXPRESSION[$i]}")
        else

          if [[ "${FORMATTED_EXPRESSION[$i]}" == ")" ]]
          then
            RESULT+=("${TEMP[-1]}")
            unset TEMP[-1]
            unset TEMP[-1]
              if [[ ${#TEMP[@]} -gt 0 ]] && [[ ! -z "${FORMATTED_EXPRESSION[$i+1]}" ]] && [[ ${PRIORITY["${FORMATTED_EXPRESSION[$i+1]}"]} -le ${PRIORITY["${TEMP[-1]}"]} ]]
              then
                RESULT+=("${TEMP[-1]}")
                unset TEMP[-1]
              fi
          elif [[ ${PRIORITY["${FORMATTED_EXPRESSION[$i]}"]} -gt ${PRIORITY["${TEMP[-1]}"]} ]] && [[ ! "${FORMATTED_EXPRESSION[$i+1]}" == "(" ]]
          then
            RESULT+=("${FORMATTED_EXPRESSION[$i]}")
          elif [[ ${PRIORITY["${FORMATTED_EXPRESSION[$i]}"]} -gt ${PRIORITY["${TEMP[-1]}"]} ]] && [[ "${FORMATTED_EXPRESSION[$i+1]}" == "(" ]]
          then
            TEMP+=("${FORMATTED_EXPRESSION[$i]}")
          else
            RESULT+=("${TEMP[-1]}")
            l=${#TEMP[@]}
            unset TEMP[l-1]
            TEMP=("${TEMP[@]}")
            TEMP+=("${FORMATTED_EXPRESSION[$i]}")
          fi
        fi
      ;;

      [0-9\.]* )
        RESULT+=("${FORMATTED_EXPRESSION[$i]}")
    ;;
  esac

  i=$i+1
done

# Put the content of array into result stack
l=${#TEMP[*]}
while [ $l -gt 0 ]
do
  RESULT+=("${TEMP[$l-1]}")
  unset TEMP[$l-1]
  TEMP=("${TEMP[@]}")
  l=${#TEMP[*]}
done

}