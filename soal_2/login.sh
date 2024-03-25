#!/bin/bash

echo "welcome to login System" 

decrypt_password() {
    echo -n "$1" | base64 -d
}
encrypt_password() {
    echo -n "$1" | base64
}

check_login() {
    email="$1"
    password="$2"
    if grep -q "^$email:" users.txt; then
        encrypted_password=$(grep "^$email:" users.txt | cut -d ":" -f 5)
        stored_password=$(decrypt_password "$encrypted_password")
        if [ "$password" == "$stored_password" ]; then
		role=$(grep "$email:" users.txt | cut -d ":" -f 6) 
		echo "$role"  
        else
            echo "LOGIN FAILED"
            echo "[$(date '+%d/%m/%Y %H:%M:%S')] [LOGIN FAILED] User with email $email logged in Failed" >> auth.log
            exit 1
        fi
    else
        echo "LOGIN FAILED"
        echo "[$(date '+%d/%m/%Y %H:%M:%S')] [LOGIN FAILED] User with email $email logged in Failed" >> auth.log
        exit 1
    fi
}

forgot_password() {
    email="$1"
    security_question=$(grep "^$email:" users.txt | cut -d ":" -f 3)
    stored_answer=$(grep "^$email:" users.txt | cut -d ":" -f 4)
    
    read -p "$security_question: " answer

    if [ "$answer" == "$stored_answer" ]; then
        stored_password=$(grep "^$email:" users.txt | cut -d ":" -f 5)
        decrypted_password=$(decrypt_password "$stored_password")
        echo "Your password is: $decrypted_password"
    else
        echo "Wrong answer!"
    fi
}

admin_setings() {
email="$1" 
while true; do
    echo "Admin Menu" 
    echo "1. Add User"
    echo "2. Edit User"
    echo "3. Delete User"
    echo "4. Logout"
    read -p "Pilihan mu: " option1

case $option1 in 
1) 
add_user
;;
2)
edit_user
;;
3)
delete_user
;;
4)
echo "logout successful!"
exit
;;

esac
done 
}

add_user() {

    read -p "Enter email: " email
    if grep -q "^$email:" users.txt; then
        echo "Email already exists!"
        exit 1
    fi
    read -p "Enter username: " username
    read -p "Enter security question: " security_question
    read -p "Enter answer: " answer
    read -sp "Enter password (minimum 8 characters, at least 1 uppercase letter, 1 lowercase letter, 1 digit, 1 symbol, and not same as username, birthdate, or name):"  password
    echo

    if ! [[ "$password" =~ [[:upper:]] && "$password" =~ [[:lower:]] && "$password" =~ [0-9] && ${#password} -ge 8 ]]; then
        echo "(minimum 8 characters, at least 1 uppercase letter, 1 lowercase letter, 1 digit, 1 symbol, and not same as username, birthdate, or name)"
        echo "User registered failed" 
    echo "[$(date '+%d/%m/%Y %H:%M:%S')] [REGISTER FAILED] User $username registered failed" >> auth.log
        exit 1
    fi

    if [[ "$email" == *admin* ]]; then
        role="admin"
    else
        role="user"
    fi

  
    encrypted_password=$(encrypt_password "$password")

    echo "$email:$username:$security_question:$answer:$encrypted_password:$role" >> users.txt
    echo "[$(date '+%d/%m/%Y %H:%M:%S')] [REGISTER SUCCESS] User $username registered successfully" >> auth.log
    echo "User registered successfully!"
}

edit_user() {
    echo "User yang tersedia:"
    grep -oP '^\S+@gmail.com' users.txt
   
    read -p "Enter email of user to edit: " email
    if ! grep -q "^$email:" users.txt; then
        echo "User not found!"
        exit 1
    fi

    read -p "Enter new username: " new_username
    read -p "Enter new security question: " new_security_question
    read -p "Enter new answer: " new_answer
    read -sp "Enter new password: " new_password
    echo

    if ! [[ "$new_password" =~ [[:upper:]] && "$new_password" =~ [[:lower:]] && "$new_password" =~ [0-9] && ${#new_password} -ge 8 ]]; then
        echo "New password must contain at least 1 uppercase letter, 1 lowercase letter, 1 digit, and be at least 8 characters long"
        exit 1
    fi

    encrypted_password=$(encrypt_password "$new_password")

    sed -i "/^$email:/s/:.*$/:$new_username:$new_security_question:$new_answer:$encrypted_password/" users.txt

    echo "User edit successfully!"
}

delete_user() {
   
    echo "Email yang tersedia" 
    grep -oP '^\S+@gmail.com' users.txt 
    read -p "Enter email of user to delete: " email
    if ! grep -q "^$email:" users.txt; then
        echo "User not found!"
        exit 1
    fi

    sed -i "/^$email:/d" users.txt
    echo "User deleted successful!"
}


echo "1. Login"
echo "2. Forgot Password"
read -p "Pilihan mu: " option2

case $option2 in
    1)
        read -p "Enter email: " email
	read -sp "Enter password: " password
        echo
        
    role=$(check_login "$email" "$password") 
	if [ "$role" == "admin" ]; then 
	 admin_setings "$email"
	 echo "[$(date '+%d/%m/%Y %H:%M:%S')] [LOGIN SUCCESS] Admin with email $email logged in successfully" >> auth.log 
	
	else 
    check_login "email" "password" 
    echo "[$(date '+%d/%m/%Y %H:%M:%S')] [LOGIN SUCCESS] User with email $email logged in successfully" >> auth.log
    echo "login succesful" 
	echo "You don't have admin privilleges, Welcome!"
    fi
    ;; 
        
    2)
	echo "Forgot Password?" 
	read -p "Enter email: " email 
        forgot_password "$email"
        ;;
    *)
        echo "Pilihan tidak tersedia"
        ;;
esac

