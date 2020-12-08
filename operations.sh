function summ {
    local res=0 N1=0 N2=0
    N1=$(printf %.0f $1e+3)
    N2=$(printf %.0f $2e+3)
    res=$(expr $N1 + $N2)
    printf %.3f "$res"e-3
}

function minus {
    local res=0 N1=0 N2=0
    N1=$(printf %.0f $1e+3)
    N2=$(printf %.0f $2e+3)
    res=$(expr $N1 - $N2)
    printf %.3f "$res"e-3
}

function del {
    local res=0 N1=0 N2=0
    if [ "$2" -eq 0 ]
    then
        echo "ERROR: division by zero"
        exit 1
    fi
    N1=$(printf %.0f $1e+6)
    N2=$(printf %.0f $2e+3)
    res=$(expr $N1 / $N2)
    printf %.3f "$res"e-3
}

function multiple {
    local res=0 N1=0 N2=0
    N1=$(printf %.0f $1e+3)
    N2=$(printf %.0f $2e+3)
    res=$(expr $N1 \* $N2)
    printf %.3f "$res"e-6
}