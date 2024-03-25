#!/bin/bash

echo "Welcome to Registration System" 

# Function to encrypt password using base64
encrypt_password() {
    echo -n "$1" | base64
}

# Function to check if email is already registered
check_email() {
    email="$1"
    if grep -q "^$email:" users.txt; then
        echo "Email already exists!"
        exit 1
    fi
}

# Function to register user
register_user() {
    email="$1"
    username="$2"
    security_question="$3"
    answer="$4"
    password="$5"

   
    if [[ "$email" == *admin* ]]; then
        role="admin"
    else
        role="user"
    fi

    
    encrypted_password=$(encrypt_password "$password")

    
    echo "$email:$username:$security_question:$answer:$encrypted_password:$role" >> users.txt
    echo "User registered succesfully" 
    
    echo "[$(date '+%d/%m/%Y %H:%M:%S')] [REGISTER SUCCESS] User $username registered successfully" >> auth.log
}

read -p "Enter email: " email
check_email "$email"

read -p "Enter username: " username
read -p "Enter security question: " security_question
read -p "Enter answer: " answer
read -sp "Enter password (minimum 8 characters, at least 1 uppercase letter, 1 lowercase letter, 1 digit, 1 symbol, and not same as username, birthdate, or name):" password
echo


if ! [[ "$password" =~ [[:upper:]] && "$password" =~ [[:lower:]] && "$password" =~ [0-9] && ${#password} -ge 8 ]]; then
    echo "Password must have minumun 8 characters, at least Password must contain at least 1 uppercase letter, 1 lowercase letter, 1 digit, and not same as username, birthdate, or name)"
    echo "User registered failed" 
    echo "[$(date '+%d/%m/%Y %H:%M:%S')] [REGISTER FAILED] User $username registered failed" >> auth.log
    exit 1
fi

register_user "$email" "$username" "$security_question" "$answer" "$password"
