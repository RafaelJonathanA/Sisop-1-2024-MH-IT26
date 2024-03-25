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
