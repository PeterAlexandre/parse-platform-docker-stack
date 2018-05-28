#!/bin/bash

# Check and install dialog
# Check if docker and docker-compose is installed

OS_TYPE=$(uname|tr '[:upper:]' '[:lower:]')
PKG_MNG_DEB=apt-get
PKG_MNG_DWN=brew

function check_and_install_dialog() {
    which dialog

    if (($? != 0))
    then
        echo "Installing dialog."
        case $OS_TYPE in
            "darwin")
                sudo $PKG_MNG_DEB update
                sudo $PKG_MNG_DEB install dialog
                ;;
            "linux")
                sudo $PKG_MNG_DEB update
                sudo $PKG_MNG_DEB install dialog
                ;;
        esac
    fi
}

function main_menu() {
    exec 3>&1;
    step=$(dialog --title 'Parse server stack' --menu 'Chose an option:' \
                0 0 0 \
                0 'Start all the stack' \
                1 'Choose the services to start' \
                2 'Quit' 2>&1 1>&3)
    exec 3>&-;
}

function second_menu() {
    exec 3>&1;
    services=$(dialog \
           --title 'Select the services' \
           --checklist 'Which services you want to start?' \
           0 0 0 \
           0 'MongoDB' on \
           1 'Mongo express' on \
           2 'Parse Server' on \
           3 'Parse dashboard' on \
           2>&1 1>&3)
    exec 3>&-;
}

function start_all_services() {
    echo 'Start full stack'
}

function start_selected_services() {
    echo 'Start selected services'
}

check_and_install_dialog
main_menu
second_menu
echo "$services"
# docker-compose up -d mongo &&\
# sleep 5 &&\
# docker-compose up -d