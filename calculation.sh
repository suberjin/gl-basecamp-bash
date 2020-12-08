# Calculate final result. Read the string till operator appears, 
# then the last two operand are calculated. These elements are unset and new value is set to array
function calculate () {
i=0
while [ $i -lt ${#RESULT[*]} ]
do 
  case ${RESULT[$i]} in

    [+] )
      RESULT[$i]=$(summ ${RESULT[$i-2]} ${RESULT[$i-1]})
      unset RESULT[i-1]
      unset RESULT[i-2]
      RESULT=("${RESULT[@]}")
      i=0
    ;;

    [-] )
      RESULT[$i]=$(minus ${RESULT[$i-2]} ${RESULT[$i-1]})
      unset RESULT[i-1]
      unset RESULT[i-2]
      RESULT=("${RESULT[@]}")
      i=0
    ;;

    [\/] )
      RESULT[$i]=$(del ${RESULT[$i-2]} ${RESULT[$i-1]})
      unset RESULT[i-1]
      unset RESULT[i-2]
      RESULT=("${RESULT[@]}")
      i=0
    ;;

    [\*] )
      RESULT[$i]=$(multiple ${RESULT[$i-2]} ${RESULT[$i-1]})
      unset RESULT[i-1]
      unset RESULT[i-2]
      RESULT=("${RESULT[@]}")
      i=0
    ;;
  esac
  i=$i+1
done
echo ${RESULT[*]}
}