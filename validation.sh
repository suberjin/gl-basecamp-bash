# Fuction that validates math expression
function validate_expression {
    INPUT_EXPRESSION=$1
    i=0
    while [ $i -lt ${#INPUT_EXPRESSION} ]
        do 
            if [[ ! "${INPUT_EXPRESSION:$i:1}" =~ [-+\/\*\(\)0-9\.] ]] 
                then
                    echo "Illegal symbol(s) in the expression"
                    exit 128
                else
                i=$i+1
            fi
        done
}