#!/bin/bash

# --- Configuration ---
EMPLOYEE_FILE="data/employees.txt"
ADMIN_USER="admin"
ADMIN_PASS="admin"

# --- Color Definitions (Global Scope) ---
BLUE='\033[0;34m'
WHITE='\033[1;37m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
BOLD='\033[1m'
NC='\033[0m' # No Color

# --- Helper Functions ---
function pause_and_return {
    echo
    read -n 1 -s -r -p "$(printf "${GREEN}Press any key to return to the main menu...${NC}")"
}

# --- Core Functions ---
function login {
    while true; do
        clear
        printf "${BLUE}╔═════════════════════════════════════════════╗\n"
        printf "║                 ${YELLOW}${BOLD}Admin Login${NC}${BLUE}                 ║\n"
        printf "╚═════════════════════════════════════════════╝${NC}\n\n"

        read -p "$(printf "${GREEN}➡️  Username: ${NC}")" username
        read -s -p "$(printf "${GREEN}➡️  Password: ${NC}")" password
        echo

        if [[ "$username" == "$ADMIN_USER" && "$password" == "$ADMIN_PASS" ]]; then
            printf "\n${GREEN}✅ Login successful. Loading application...${NC}\n"
            sleep 1
            return 0
        else
            printf "\n${RED}❌ Invalid credentials. Please try again.${NC}\n"
            sleep 5
        fi
    done
}

function add_employee {
    clear
    printf "${BLUE}╔══════════════════════════════════════════════╗\n"
    printf "║               ${YELLOW}${BOLD}Add New Employee${NC}${BLUE}               ║\n"
    printf "╚══════════════════════════════════════════════╝${NC}\n\n"
    
    read -p "$(printf "${GREEN}➡️  Enter employee name: ${NC}")" name
    read -p "$(printf "${GREEN}➡️  Enter employee position: ${NC}")" position

    local id
    if [[ -s "$EMPLOYEE_FILE" ]]; then
        last_id=$(cut -d ',' -f 1 "$EMPLOYEE_FILE" | sort -n | tail -n 1)
        id=$((last_id + 1))
    else
        id=1
    fi

    echo "$id,$name,$position" >> "$EMPLOYEE_FILE"
    printf "\n${GREEN}✅ Employee added successfully with ID: ${WHITE}$id${NC}\n"
    pause_and_return
}

function view_employees {
    clear
    printf "${BLUE}╔══════════════════════════════════════════════════╗\n"
    printf "║                 ${YELLOW}${BOLD}Employee Records${NC}${BLUE}                 ║\n"
    printf "╚══════════════════════════════════════════════════╝${NC}\n\n"

    if [[ ! -s "$EMPLOYEE_FILE" ]]; then
        printf "${RED}No employee records found.${NC}\n"
    else
        # Use column for clean formatting below the header
        { echo "ID,Name,Position"; cat "$EMPLOYEE_FILE"; } | column -t -s ','
    fi
    pause_and_return
}

function delete_employee {
    clear
    printf "${BLUE}╔═════════════════════════════════════════════════╗\n"
    printf "║                 ${YELLOW}${BOLD}Delete Employee${NC}${BLUE}                 ║\n"
    printf "╚═════════════════════════════════════════════════╝${NC}\n\n"

    read -p "$(printf "${GREEN}➡️  Enter employee ID to delete: ${NC}")" id
    
    if grep -q "^$id," "$EMPLOYEE_FILE"; then
        grep -v "^$id," "$EMPLOYEE_FILE" > temp.txt && mv temp.txt "$EMPLOYEE_FILE"
        printf "\n${GREEN}🗑️  Employee with ID ${WHITE}$id${GREEN} deleted successfully.${NC}\n"
    else
        printf "\n${RED}❌ Employee with ID ${WHITE}$id${RED} not found.${NC}\n"
    fi
    pause_and_return
}

function main {
    login

    while true; do
        clear
        # --- Draw The Menu Box ---
        printf "${BLUE}╔══════════════════════════════════════════════╗\n"
        printf "║          ${YELLOW}${BOLD}Employee Management System${NC}${BLUE}          ║\n"
        printf "╟──────────────────────────────────────────────╢\n"
        printf "║  ${WHITE}%-44s${BLUE}║\n" "        1. Add Employee"
        printf "║  ${WHITE}%-44s${BLUE}║\n" "        2. View Employees"
        printf "║  ${WHITE}%-44s${BLUE}║\n" "        3. Delete Employee"
        printf "║  ${WHITE}%-44s${BLUE}║\n"
        printf "║  ${WHITE}%-44s${BLUE}║\n" "        4. Exit"
        printf "╚══════════════════════════════════════════════╝${NC}\n"

        # --- Prompt for user input ---
        read -p "$(printf "${GREEN}➡️  Choose an option: ${NC}")" option

        case $option in
            1) add_employee ;;
            2) view_employees ;;
            3) delete_employee ;;
            4) clear; printf "${GREEN}Goodbye!${NC}\n"; exit 0 ;;
            *)
              printf "\n${RED}Invalid option. Please try again.${NC}\n"
              sleep 1
              ;;
        esac
    done
}

# --- Main Execution ---
main