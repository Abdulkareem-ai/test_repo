#!/bin/bash

# if [[ $EUID -ne 0 ]]; then
#    echo "This script must be run as root" 
#    exit 1
# fi

TIMER=0

sleep_timer(){
    echo ""
    for (( i=$TIMER; i>=0; i-- ))
    do
        echo -e "\e[1A\e[KTimer: $i"
        sleep 1
    done
}

ARGS=$(getopt --options afpvomtzedh --long "all,fr,rtpc,rtvc,rtoc,hm,autofr,zm,ah,engine,dashboard,help" -- "$@")

eval set --"$ARGS"

while true; do
    case "$1" in
        -a|--all)
            shift;;

        -f|--fr)
            docker compose -f ./fr-compose.yaml --project-directory FR/cam001 down &
            P1=$!
            # docker compose -f ./fr-compose.yaml --project-directory FR/cam002 down &
            # P2=$!
            # docker compose -f ./fr-compose.yaml --project-directory FR/cam003 down &
            # P3=$!
            # docker compose -f ./fr-compose.yaml --project-directory FR/cam004 down &
            # P4=$!
            # docker compose -f ./fr-compose.yaml --project-directory FR/cam005 down &
            # P5=$!
            # docker compose -f ./fr-compose.yaml --project-directory FR/cam006 down &
            # P6=$!

            wait $P1 $P2 #$P3 $P4 $P5 $P6
            shift;;
        -p|--rtpc)
            docker compose -f ./rtpc-compose.yaml --project-directory RTPC/cam401 down &
            P1=$!
            wait $P1
            shift;;

        -t|--autofr)
            docker compose -f ./af-compose.yaml --project-directory AUTOFR/cam601 down &
            P1=$!
            wait $P1
            shift;;

        -v|--rtvc)
            # docker compose -f ./rtvc-compose.yml --project-directory RTVC/cam101 down &
            # P1=$!
            # docker compose -f ./rtvc-compose.yml --project-directory RTVC/cam102 down &
            # P2=$!
            # docker compose -f ./rtvc-compose.yml --project-directory RTVC/cam103 down &
            # P3=$!
            # docker compose -f ./rtvc-compose.yml --project-directory RTVC/cam104 down &
            # P4=$!

            # wait $P1 $P2 $P3 $P4
            shift;;
        
        -o|--rtoc)
            # docker compose -f ./rtoc-compose.yml --project-directory RTOC/cam201 down &
            # P1=$!
            # docker compose -f ./rtoc-compose.yml --project-directory RTOC/cam202 down &
            # P2=$!
            # docker compose -f ./rtoc-compose.yml --project-directory RTOC/cam203 down &
            # P3=$!
            # docker compose -f ./rtoc-compose.yml --project-directory RTOC/cam204 down &
            # P4=$!
            # docker compose -f ./rtoc-compose.yml --project-directory RTOC/cam205 down &
            # P5=$!
            # docker compose -f ./rtoc-compose.yml --project-directory RTOC/cam206 down &
            # P6=$!
            # docker compose -f ./rtoc-compose.yml --project-directory RTOC/cam207 down &
            # P7=$!

            # wait $P1 $P2 $P3 $P4 $P5 $P6 $P7
            shift;;
        
        -m|--hm)
            docker compose -f ./hm-compose.yaml --project-directory HM/cam501 down &
            P1=$!
            docker compose -f ./hm-compose.yaml --project-directory HM/cam502 down &
            P2=$!
            docker compose -f ./hm-compose.yaml --project-directory HM/cam503 down &
            P3=$!
            docker compose -f ./hm-compose.yaml --project-directory HM/cam504 down &
            P4=$!
            wait $P1 $P2 $P3 $P4 #$P5 $P6
            shift;;

        -t|--autofr)
            shift;;

        -z|--zm)
            docker compose -f ./zm-compose.yaml --project-directory ZM/cam301 down &
            P1=$!
            docker compose -f ./zm-compose.yaml --project-directory ZM/cam302 down &
            P2=$!
            docker compose -f ./zm-compose.yaml --project-directory ZM/cam303 down &
            P3=$!
            wait $P1 $P2 $P3
            shift;;

        -h|--ah)
            docker compose -f ./ppe-compose.yaml --project-directory AH/cam701 down &
            P1=$!
            docker compose -f ./ppe-compose.yaml --project-directory AH/cam702 down &
            P2=$!
            docker compose -f ./ppe-compose.yaml --project-directory AH/cam703 down &
            P3=$!

            wait $P1 $P2 $P3 
            shift;;

        -e|--engine)
            docker compose down &
            P1=$!

            wait $P1
            shift;;

        -d|--dashboard)
            cd dashboard
            docker compose down &
            P1=$!
            cd ..

            wait $P1
            shift;;

        -h|--help)
            # echo "$(basename "$0") options available: [-a|--all] [-b|--fr] [-c|--rtpc] [-d|--hm] [-e|--autofr] [-f|--engine] [-g|--dashboard]";
            printf "Options Available:\n[-a|--all]\n[-f|--fr]\n[-p|--rtpc]\n[-v|--rtvc]\n[-o|--rtoc]\n[-m|--hm]\n[-t|--autofr]\n[-z|--zm]\n[-h|--ah]\n[-e|--engine]\n[-d|--dashboard]\n";
            shift;;
        --)
            break;;
        *)
            printf "unknown option %s\n" "$1"
            exit 1;;
    esac
done