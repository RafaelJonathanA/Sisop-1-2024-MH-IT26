# Sisop-1-2024-MH-IT26

## ***KELOMPOK IT 26***
  | Nama      | NRP         |
  |-----------|-------------|
  | Rafael Jonathan Arnoldus   | 5027231006  |
  | Muhammad Abhinaya Al-Faruqi  | 5027231011  |  
  | Danendra Fidel Khansa  | 5027231063  |

## Bagian Pengerjaan Soal 
+ Soal 1 = Danendra Fidel Khansa
+ Soal 2 = Rafael Jonathan Arnoldus
+ Soal 3 = Muhammad Abhinaya Al-Faruqi
+ Soal 4 = Semua anggota

## ***MODUL 1***
  Berikut untuk struktur repository pengumpulan dari hasil praktikum sistem operasi modul 1 :
```
—soal_1:
  	— Sandbox.sh
                                    
—soal_2:
  	— Login.sh
	— Register.sh
				
—soal_3:
  	— awal.sh
	— search.sh
				
—soal_4:
	— aggregate_minutes_to_hourly_log.sh
	— minute_log.sh
```
---
## ***SOAL 1 (Fidel)***
Cipung dan abe ingin mendirikan sebuah toko bernama “SandBox”, sedangkan kamu adalah manajer penjualan yang ditunjuk oleh Cipung dan Abe untuk melakukan pelaporan penjualan dan strategi penjualan kedepannya yang akan dilakukan.

Setiap tahun Cipung dan Abe akan mengadakan rapat dengan kamu untuk mengetahui laporan dan strategi penjualan dari “SandBox”. Buatlah beberapa kesimpulan dari data penjualan “Sandbox.csv” untuk diberikan ke cipung dan abe 

a. Karena Cipung dan Abe baik hati, mereka ingin memberikan hadiah kepada customer yang telah belanja banyak. Tampilkan nama pembeli dengan total sales paling tinggi

b. Karena karena Cipung dan Abe ingin mengefisienkan penjualannya, mereka ingin merencanakan strategi penjualan untuk customer segment yang memiliki profit paling kecil. Tampilkan customer segment yang memiliki profit paling kecil

c. Cipung dan Abe hanya akan membeli stok barang yang menghasilkan profit paling tinggi agar efisien. Tampilkan 3 category yang memiliki total profit paling tinggi 

d. Karena ada seseorang yang lapor kepada Cipung dan Abe bahwa pesanannya tidak kunjung sampai, maka mereka ingin mengecek apakah pesanan itu ada. Cari purchase date dan amount (quantity) dari nama adriaens

## ***PENGERJAAN***
```
#!/bin/bash

wget --no-check-certificate -O Sandbox.csv 'https://drive.google.com/uc?id=1cC6MYBI3wRwDgqlFQE1OQUN83JAreId0&export=download'

cat Sandbox.csv

awk -F ',' '{print NF; exit}' Sandbox.csv

head -n 1 Sandbox.csv

awk -F ',' 'NR>1{sales[$6]+=$17} END{max_sales=0; for (customer in sales) {if (sales[customer] > max_sales) {max_sales = sales[customer]; max_customer = customer}} print "Customer dengan total sales tertinggi adalah " max_customer ", yaitu dengan total sales sebesar " max_sales}' Sandbox.csv > 1A.txt

awk -F ',' '{print $7",",$20}' Sandbox.csv | sort -t ',' -k2,2n | head -n 2 | tail -n 1 | awk '{print "Customer segment yang memiliki profit paling kecil adalah:", $1, "dengan profit sebesar", $2}' > 1B.txt

awk -F ',' 'NR > 1 {sum[$14]+=$20} END {print "Profit 3 tertinggi diantara seluruh category"; for (category in sum) print category ", " sum[category] }' Sandbox.csv  > 1C.txt

awk -F ',' '/Adriaens/ {print "Pesanan " $6 " pada tanggal " $2 " dan sejumlah " $18}' Sandbox.csv > 1D.txt
```
---
## ***PENJELASAN PENGERJAAN***
## *Pengunduhan dan Pengecekan kelengkapan file*
- Langkah awal adalah mendownload file dari link google drive yang ada di soal dengan cara menggunakan command 'wget' lalu '--no-check-certificate -O' kemudian beri nama filenya dengan 'Sandbox.csv' dan terakhir masukan link google drive tersebut.
```
wget --no-check-certificate -O Sandbox.csv 'https://drive.google.com/uc?id=1cC6MYBI3wRwDgqlFQE1OQUN83JAreId0&export=download'
```
`Setelah command diatas dijalankan maka akan muncul file bernama "Sandbox.csv" yang akan tersimpan didalam direktori sesuai yang kita tuju`
- Langkah kedua adalah mengecek/menampilkan keseleruhan isi data csv tersebut dengan memakai command 'cat' kemudian diikuti nama filenya
```
cat Sandbox.csv
```
`Lalu setelah command diatas dijalankan maka kita akan mendapatkan output berupa seluruh isi dari file "Sandbox.csv" mulai dari kolom dan serta data_data yang lain`
- Langkah ketiga untuk mengecek kemudian menampilkan jumlah kolom pada data yang ada pada file menggunakan command 'awk'
```
awk -F ',' '{print NF; exit}' Sandbox.csv
```
`Dengan menampilkan jumlah kolom yang ada pada file csv, akan sangat memabntu dalam pengerjaan soal untuk membadingkan kolom mana yang mau dibandingkan`
- Langkah terakhir adalah menampilkan nama kolom yang tersedia didalam file Sandbox menggunakan 'head', fungsinya agar nanti dalam pengerjaan soal kita dapat dengan mudah menentukan kolom mana  yang akan digunakan
```
head -n 1 Sandbox.csv
```
`Terakhir setelah menampilkan jumlah kolom dilakukan penampilan nama kolom untuk lebih mempermudah pengerjaan soal`
## *Pengerjaan Soal*
a. Tampilkan nama pembeli dengan total sales paling tinggi
```
awk -F ',' 'NR>1{sales[$6]+=$17} END{max_sales=0; for (customer in sales) {if (sales[customer] > max_sales) {max_sales = sales[customer]; max_customer = customer}} print "Customer dengan total sales tertinggi adalah " max_customer ", yaitu dengan total sales sebesar " max_sales}' Sandbox.csv > 1A.txt
```
`(-F ',') untuk menentukan pemisah dan memproses file CSV, kemudian NR>1{sales[$6]+=$17} untuk menghitung total penjualan untuk setiap pelanggan ($6 kolom nama pelanggan dan $17 kolom dengan jumlah penjualan), lalu END{max_sales=0; for... akan membaca dan mencari pelanggan dengan total penjualan tertinggi dan mencetaknya ke file 1A.txt`

b. Tampilkan customer segment yang memiliki profit paling kecil
```
awk -F ',' '{print $7",",$20}' Sandbox.csv | sort -t ',' -k2,2n | head -n 2 | tail -n 1 | awk '{print "Customer segment yang memiliki profit paling kecil adalah:", $1, "dengan profit sebesar", $2}' > 1B.txt
```
`{print $7",",$20} akan mencetak kolom ke-7 (pelanggan) dan kolom ke-20 (profit) dari file CSV, kemudian sort -t ',' -k2,2n  mengurutkan baris berdasarkan kolom ke-2 (profit), head -n 2 | tail -n 1 mengambil baris kedua dari hasil pengurutan yaitu baris dengan profit terkecil, kemudian print... akan mencetaknya dan menyimpan di file 1B.txt`

c. Tampilkan 3 category yang memiliki total profit paling tinggi 
```
awk -F ',' 'NR > 1 {sum[$14]+=$20} END {print "Profit 3 tertinggi diantara seluruh category"; for (category in sum) print category ", " sum[category] }' Sandbox.csv  > 1C.txt 
```
`NR > 1 {sum[$14]+=$20} pertama menghitung total profit untuk setiap kategori ($14 adalah kolom dengan kategori dan $20 adalah kolom dengan profit) kemudian dengan print... akan langsung membaca dan mencetak dari 3 kategori tersebut di file 1C.txt`

d. Mengecek apakah pesanan itu ada. Cari purchase date dan amount (quantity) dari nama adriaens
```
awk -F ',' '/Adriaens/ {print "Pesanan " $6 " pada tanggal " $2 " dan sejumlah " $18}' Sandbox.csv > 1D.txt
```
`/Adriaens/ {print "Pesanan " $6 " pada tanggal " $2 " dan sejumlah " $18}' berikut akan mencari baris yang memiliki nama "Adriaens" kemudian mencetak pesanan, tanggal, dan jumlahnya ke file 1D.txt`

## *Dokumentasi*
![Screenshot (289)](https://github.com/Rafjonath/Sisop-1-2024-MH-IT26/assets/150430084/0497e615-1f98-452a-bd2e-e0807693fa0a)
![Screenshot (290)](https://github.com/Rafjonath/Sisop-1-2024-MH-IT26/assets/150430084/be22df14-d26d-4504-ad50-69ff4e6fdcc1)
![Screenshot (291)](https://github.com/Rafjonath/Sisop-1-2024-MH-IT26/assets/150430084/ad10ccc7-d33d-45f3-9c84-0d32076d9100)
![Screenshot (292)](https://github.com/Rafjonath/Sisop-1-2024-MH-IT26/assets/150430084/3ffbb1d5-fb92-4ccb-a914-4e89d6653abf)
![Screenshot (293)](https://github.com/Rafjonath/Sisop-1-2024-MH-IT26/assets/150430084/bbf916d3-a67a-43bf-8e69-ecf47b327fad)
![Screenshot (294)](https://github.com/Rafjonath/Sisop-1-2024-MH-IT26/assets/150430084/d4c49b63-f3a0-4731-acb5-4269b2e697a3)
![Screenshot (295)](https://github.com/Rafjonath/Sisop-1-2024-MH-IT26/assets/150430084/d0d95151-7e0b-4268-ad81-d7a188c8543f)

## ***SOAL 2 (Rafael)***
Oppie merupakan seorang peneliti bom atom, ia ingin merekrut banyak peneliti lain untuk mengerjakan proyek bom atom nya, Oppie memiliki racikan bom atom rahasia yang hanya bisa diakses penelitinya yang akan diidentifikasi sebagai user, Oppie juga memiliki admin yang bertugas untuk memanajemen peneliti,  bantulah oppie untuk membuat program yang akan memudahkan tugasnya 
a. Buatlah 2 program yaitu login.sh dan register.sh

b. Setiap admin maupun user harus melakukan register terlebih dahulu menggunakan email, username, pertanyaan keamanan dan jawaban, dan password

c. Username yang dibuat bebas, namun email bersifat unique. setiap email yang mengandung kata admin akan dikategorikan menjadi admin 

d. Karena resep bom atom ini sangat rahasia Oppie ingin password nya memuat keamanan tingkat tinggi

Password tersebut harus di encrypt menggunakan base64
Password yang dibuat harus lebih dari 8 karakter
Harus terdapat paling sedikit 1 huruf kapital dan 1 huruf kecil
Harus terdapat paling sedikit 1 angka 

e. Karena Oppie akan memiliki banyak peneliti dan admin ia berniat untuk menyimpan seluruh data register yang ia lakukan ke dalam folder users file users.txt. Di dalam file tersebut, terdapat catatan seluruh email, username, pertanyaan keamanan dan jawaban, dan password hash yang telah ia buat.

f. Setelah melakukan register, program harus bisa melakukan login. Login hanya perlu dilakukan menggunakan email dan password.

g. Karena peneliti yang di rekrut oleh Oppie banyak yang sudah tua dan pelupa maka Oppie ingin ketika login akan ada pilihan lupa password dan akan keluar pertanyaan keamanan dan ketika dijawab dengan benar bisa memunculkan password

h. Setelah user melakukan login akan keluar pesan sukses, namun setelah seorang admin melakukan login Oppie ingin agar admin bisa menambah, mengedit (username, pertanyaan keamanan dan jawaban, dan password), dan menghapus user untuk memudahkan kerjanya sebagai admin.Ketika admin ingin melakukan edit atau hapus user, maka akan keluar input email untuk identifikasi user yang akan di hapus atau di edit

i. Oppie ingin programnya tercatat dengan baik, maka buatlah agar program bisa mencatat seluruh log ke dalam folder users file auth.log, baik login ataupun register.
Format: [date] [type] [message]
Type: REGISTER SUCCESS, REGISTER FAILED, LOGIN SUCCESS, LOGIN FAILED
Ex:
[23/09/17 13:18:02] [REGISTER SUCCESS] user [username] registered successfully
[23/09/17 13:22:41] [LOGIN FAILED] ERROR Failed login attempt on user with email [email]


## ***PENGERJAAN***
### Login.sh 
```
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
```
### register.sh
```
#!/bin/bash

echo "Welcome to Registration System" 
encrypt_password() {
    echo -n "$1" | base64
}

check_email() {
    email="$1"
    if grep -q "^$email:" users.txt; then
        echo "Email already exists!"
        exit 1
    fi
}
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
```

## ***PENJELASAN PENGERJAAN***
## Soal No.2 
Oppie merupakan seorang peneliti bom atom, ia ingin merekrut banyak peneliti lain untuk mengerjakan proyek bom atom nya, Oppie memiliki racikan bom atom rahasia yang hanya bisa diakses penelitinya yang akan diidentifikasi sebagai user, Oppie juga memiliki admin yang bertugas untuk memanajemen peneliti,  bantulah oppie untuk membuat program yang akan memudahkan tugasnya 
### a.Buatlah 2 program yaitu login.sh dan register.sh
Pertama-tama kita buat terlebih dahulu folder soal_2 kemudian setelah itu didalam folder soal_2 kita menggunakan nano login.sh menuliskan #!/bin/bash lalu keluar dan menggunakan nano register.sh kemudian menuliskan #!/bin/bash lalu keluar. 
### b. Setiap admin maupun user harus melakukan register terlebih dahulu menggunakan email, username, pertanyaan keamanan dan jawaban, dan password
Pertama kita buat terlebih dahulu kode untuk register user pada register.sh 
 
```
register_user(){ 

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
    
    echo"$email:$username:$security_question:$answer:$encrypted_password:$role" >> users.txt
    echo "User registered succesfully" 
}
```
Lalu untuk ditampilkan pada tampilan dengan menggunakan read untuk mengambil inputan dari user, dan menggunakan fungsi register user yang telah dibuat sebelumnya diatas
```
read -p "Enter email: " email
check_email "$email"

read -p "Enter username: " username
read -p "Enter security question: " security_question
read -p "Enter answer: " answer
read -sp "Enter password (minimum 8 characters, at least 1 uppercase letter, 1 lowercase letter, 1 digit, 1 symbol, and not same as username, birthdate, or name):" password
echo

register_user "$email" "$username" "$security_question" "$answer" "$password"
```
### c. Username yang dibuat bebas, namun email bersifat unique. setiap email yang mengandung kata admin akan dikategorikan menjadi admin 

Pada bagian register.sh kita tambahkan role 
```
register_user(){ 

	...

    if [[ "$email" == *admin* ]]; then
        role="admin"
    else
        role="user"
    fi
}
```
Dengan menggunakan if email == admin akan membuat email yang mengandung kata admin seperti admin@gmail.com akan dikatagorikan sebagai admin.  

### d. Karena resep bom atom ini sangat rahasia Oppie ingin password nya memuat keamanan tingkat tinggi
#### Password tersebut harus di encrypt menggunakan base64 
```
encrypt_password() {
    echo -n "$1" | base64
}
```
Dengan menggunakan fungsi encrypt_password maka password yang dimasukkan akan di enkripsi dalam bentuk base64

#### Password yang dibuat harus lebih dari 8 karakter, Harus terdapat paling sedikit 1 huruf kapital dan 1 huruf kecil, Harus terdapat paling sedikit 1 angka

Dengan batasan password seeprti ini dalam kode register.sh 
```
if ! [[ "$password" =~ [[:upper:]] && "$password" =~ [[:lower:]] && "$password" =~ [0-9] && ${#password} -ge 8 ]]; then
    echo "(Password must have minumun 8 characters, at least Password must contain at least 1 uppercase letter, 1 lowercase letter, 1 digit, and not same as username, birthdate, or name)"
    echo "User registered failed" 
	...
    exit 1
fi
```
Dari kode diatas password yang diisikan harus memiliki huruf besar dan huruf kecil dan angka serta harus memiiki panjang minimal 8 karakter bila tidak akan ditamplikan Password (must have minumun 8 characters, at least Password must contain at least 1 uppercase letter, 1 lowercase letter, 1 digit, and not same as username, birthdate, or name) dan juga registrasi akan gagal dan keluar dari register.sh 

### e.Karena Oppie akan memiliki banyak peneliti dan admin ia berniat untuk menyimpan seluruh data register yang ia lakukan ke dalam folder users file users.txt. Di dalam file tersebut, terdapat catatan seluruh email, username, pertanyaan keamanan dan jawaban, dan password hash yang telah ia buat.

Pada kode yang telah ada diatas 
```
echo"$email:$username:$security_question:$answer:$encrypted_password:$role" >> users.txt
```
Kode inilah yang akan mengirimkan semua hasil email.username,security question, answer, serta password yang telah terenkripsi dan juga role yang dimiliki ke user.txt

### f.Setelah melakukan register, program harus bisa melakukan login. Login hanya perlu dilakukan menggunakan email dan password.

Kita membuka login.sh terlebih dahulu pada awal tampilan login akan diminta memasukkan email dan password 
```
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
```
Dengan kode diatas ditambah kode 
```
read -p "Enter email: " email
	read -sp "Enter password: " password
        echo
        
    role=$(check_login "$email" "$password") 
```
Maka email dan password yang kita masukkan akan di cek apakah ada di user.txt dan apakah email serta passwordnya cocok. 

### g.Karena peneliti yang di rekrut oleh Oppie banyak yang sudah tua dan pelupa maka Oppie ingin ketika login akan ada pilihan lupa password dan akan keluar pertanyaan keamanan dan ketika dijawab dengan benar bisa memunculkan password

Kita modifikasi kembali login.sh sehingga bisa menampilkan pilihan login atau lupa password 

```
echo "1. Login"
echo "2. Forgot Password"
read -p "Pilihan mu: " option2

case $option2 in
    1)
        read -p "Enter email: " email
	read -sp "Enter password: " password
        echo
	2)
	echo "Forgot Password?" 
	read -p "Enter email: " email 
        forgot_password "$email"
        ;;
    *)
        echo "Pilihan tidak tersedia"
        ;;

```
Namun sebelum menjalankan forgot password kita harus membuat fungsi forgor_password terlebih dahulu dan dengan mengambil variabel email fungsi forgot_password dijalankan, kodenya: 


```
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
```
pada fungsi forgot password sebagai email menjadi kunci utamanya untuk mencari password pada user.txt maka setelah email diketahui maka akan mengeluarkan security question dan apabila jawabannya benar maka akan menampilkan password yang benar dari email tersebut

### h. Setelah user melakukan login akan keluar pesan sukses, namun setelah seorang admin melakukan login Oppie ingin agar admin bisa menambah, mengedit (username, pertanyaan keamanan dan jawaban, dan password), dan menghapus user untuk memudahkan kerjanya sebagai admin

Untuk mengeluarkan pesan sukses saat user berhasil login adalah dengan menggunakan kode :
```
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

...

check_login "email" "password" 
    echo "[$(date '+%d/%m/%Y %H:%M:%S')] [LOGIN SUCCESS] User with email $email logged in successfully" >> auth.log
    echo "login succesful" 
	echo "You don't have admin privilleges, Welcome!"
```
Dengan fungsi check login dan menjalankannya saat check_login bernilai true maka akan muncul login succsesful dan you don't have admin privilaleges, welcome! 

Agar saat menggunakan email admin maka akan muncul 4 pilihan maka code yang diperlukan yaitu: 
```
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
```
Ini hanyalah fungsi dari admin_settings yang menampilkan keempat pilihan dan agar pilihan ini dapat berjalan dibutuhkan tiga fungsi lainnya yaitu add_user yang mirip dengan register.sh lalu edit_user sehingga bisa mengubah username,password,pertanyaan,serta jawabannya yang dimiliki email tersebut pada user.txt dan terakhir dapat menghapus email di user.txt masing masing fungsinya sebagai berikut 
```
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
```
```
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
```
```
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
```
Setelah keseluruhan fungsi lengkap agar bisa masuk ke admin_settings saat login diperlukan code : 
```
role=$(check_login "$email" "$password") 
	if [ "$role" == "admin" ]; then 
	 admin_setings "$email"
```
Sehingga apabila didapatkan role admin maka akan menjalankan admin_setings dengan pemicu emailnya. 

### i. Ketika admin ingin melakukan edit atau hapus user, maka akan keluar input email untuk identifikasi user yang akan di hapus atau di edit

Dari kode yang diatas pada bagian fungsi edit_user dan delete_user terdapat code  
```
echo "Email yang tersedia" 

grep -oP '^\S+@gmail.com' users.txt 
```
Perintah ini akan menampilkan email yang tersedia berdasarkan email yang ada di users.txt dengan mencari sebuah string tanpa spasi yang diakhiri oleh @gmail.com sehingga bila email yang dimasukkan bukan berupa @gmail.com tidak akan muncul di list 

### j. Oppie ingin programnya tercatat dengan baik, maka buatlah agar program bisa mencatat seluruh log ke dalam folder users file auth.log, baik login ataupun register.

Untuk mencatat log ke sebuah file autg.log diperlukan kode : 
Pada register.sh 
```
Apabila berhasil :
echo "[$(date '+%d/%m/%Y %H:%M:%S')] [REGISTER SUCCESS] User $username registered successfully" >> auth.log

Apabila gagal :
echo "[$(date '+%d/%m/%Y %H:%M:%S')] [REGISTER FAILED] User $username registered failed" >> auth.log
```
Pada login.sh
```
Apabila berhasil login dengan email admin: 
echo "[$(date '+%d/%m/%Y %H:%M:%S')] [LOGIN SUCCESS] Admin with email $email logged in successfully" >> auth.log 

Apabila berhasil login dengan email user: 
echo "[$(date '+%d/%m/%Y %H:%M:%S')] [LOGIN SUCCESS] User with email $email logged in successfully" >> auth.log

Apabila gagal login: 
echo "[$(date '+%d/%m/%Y %H:%M:%S')] [LOGIN FAILED] User with email $email logged in Failed" >> auth.log
```
Dengan kode diatas maka setiap kali ada register yang berhasil ataupun gagal akan tercatat di auth.log bergitupun saat menjalankan login.sh apabila gagal login ataupun berhasil login maka akan tercatat di auth.log

## *Dokumentasi*

## ***SOAL 3 (Abhinaya)***
## ***PENGERJAAN***
## ***PENJELASAN PENGERJAAN***
## *Dokumentasi*

## ***SOAL 4 (Seluruh Anggota)***
## ***PENGERJAAN***
## ***PENJELASAN PENGERJAAN***
## *Dokumentasi*
