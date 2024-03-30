#!/bin/bash


log_dir="/home/ubuntu/log"
minute_log_file="$log_dir/metrics_$(date +'%Y%m%d%H').log"
hourly_log_file="$log_dir/metrics_agg_$(date +'%Y%m%d%H').log"


# Inisiasi variabel
min_ram_total=
min_ram_used=
min_ram_free=
min_ram_shared=
min_ram_buff=
min_ram_available=
max_ram_total=
max_ram_used=
max_ram_free=
max_ram_shared=
max_ram_buff=
max_ram_available=
sum_ram_total=0
sum_ram_used=0
sum_ram_free=0
sum_ram_shared=0
sum_ram_buff=0
sum_ram_available=0
count=0

min_swap_total=
min_swap_used=
min_swap_free=
max_swap_total=
max_swap_used=
max_swap_free=
sum_swap_total=0
sum_swap_used=0
sum_swap_free=0

min_disk_size=
max_disk_size=
sum_disk_size=0

# Membaca log matrics
for file in $log_dir/*.log; do
    # Read the second line of the file
    metrics=$(sed -n '2p' "$file")
    
    IFS=',' read -r mem_total mem_used mem_free mem_shared mem_buff mem_available swap_total swap_used swap_free path path_size <<< "$metrics"

    # Update RAM metrics
    if [[ -z $min_ram_total || $mem_total -lt $min_ram_total ]]; then
        min_ram_total=$mem_total
    fi
    if [[ -z $min_ram_used || $mem_used -lt $min_ram_used ]]; then
        min_ram_used=$mem_used
    fi
    if [[ -z $min_ram_free || $mem_free -lt $min_ram_free ]]; then
        min_ram_free=$mem_free
    fi
    if [[ -z $min_ram_shared || $mem_shared -lt $min_ram_shared ]]; then
        min_ram_shared=$mem_shared
    fi
    if [[ -z $min_ram_buff || $mem_buff -lt $min_ram_buff ]]; then
        min_ram_buff=$mem_buff
    fi
    if [[ -z $min_ram_available || $mem_available -lt $min_ram_available ]]; then
        min_ram_available=$mem_available
    fi

    if [[ -z $max_ram_total || $mem_total -gt $max_ram_total ]]; then
        max_ram_total=$mem_total
    fi
    if [[ -z $max_ram_used || $mem_used -gt $max_ram_used ]]; then
        max_ram_used=$mem_used
    fi
    if [[ -z $max_ram_free || $mem_free -gt $max_ram_free ]]; then
        max_ram_free=$mem_free
    fi
    if [[ -z $max_ram_shared || $mem_shared -gt $max_ram_shared ]]; then
        max_ram_shared=$mem_shared
    fi
    if [[ -z $max_ram_buff || $mem_buff -gt $max_ram_buff ]]; then
        max_ram_buff=$mem_buff
    fi
    if [[ -z $max_ram_available || $mem_available -gt $max_ram_available ]]; then
        max_ram_available=$mem_available
    fi

    ((sum_ram_total += mem_total))
    ((sum_ram_used += mem_used))
    ((sum_ram_free += mem_free))
    ((sum_ram_shared += mem_shared))
    ((sum_ram_buff += mem_buff))
    ((sum_ram_available += mem_available))

    # Update Swap metrics
    if [[ -z $min_swap_total || $swap_total -lt $min_swap_total ]]; then
        min_swap_total=$swap_total
    fi
    if [[ -z $min_swap_used || $swap_used -lt $min_swap_used ]]; then
        min_swap_used=$swap_used
    fi
    if [[ -z $min_swap_free || $swap_free -lt $min_swap_free ]]; then
        min_swap_free=$swap_free
    fi

    if [[ -z $max_swap_total || $swap_total -gt $max_swap_total ]]; then
        max_swap_total=$swap_total
    fi
    if [[ -z $max_swap_used || $swap_used -gt $max_swap_used ]]; then
        max_swap_used=$swap_used
    fi
    if [[ -z $max_swap_free || $swap_free -gt $max_swap_free ]]; then
        max_swap_free=$swap_free
    fi

    ((sum_swap_total += swap_total))
    ((sum_swap_used += swap_used))
    ((sum_swap_free += swap_free))

    # Mengupdate disk sizenya
    disk_size="${path_size//[!0-9]/}"
    if [[ -z $min_disk_size || $disk_size -lt $min_disk_size ]]; then
        min_disk_size=$disk_size
    fi
    if [[ -z $max_disk_size || $disk_size -gt $max_disk_size ]]; then
        max_disk_size=$disk_size
    fi
    ((sum_disk_size += disk_size))

    ((count++))
done

# Menghitung rata-rata
avg_ram_total=$(bc <<< "scale=2; $sum_ram_total / $count")
avg_ram_used=$(bc <<< "scale=2; $sum_ram_used / $count")
avg_ram_free=$(bc <<< "scale=2; $sum_ram_free / $count")
avg_ram_shared=$(bc <<< "scale=2; $sum_ram_shared / $count")
avg_ram_buff=$(bc <<< "scale=2; $sum_ram_buff / $count")
avg_ram_available=$(bc <<< "scale=2; $sum_ram_available / $count")

avg_swap_total=$(bc <<< "scale=2; $sum_swap_total / $count")
avg_swap_used=$(bc <<< "scale=2; $sum_swap_used / $count")
avg_swap_free=$(bc <<< "scale=2; $sum_swap_free / $count")

avg_disk_size=$(bc <<< "scale=2; $sum_disk_size / $count")

# Menuliskan hasilnya
echo "type,mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size" > $hourly_log_file
echo "maximum,$max_ram_total,$max_ram_used,$max_ram_free,$max_ram_shared,$max_ram_buff,$max_ram_available,$max_swap_total,$max_swap_used,$max_swap_free,/home/ubuntu,$max_disk_size" >> $hourly_log_file
echo "minimum,$min_ram_total,$min_ram_used,$min_ram_free,$min_ram_shared,$min_ram_buff,$min_ram_available,$min_swap_total,$min_swap_used,$min_swap_free,/home/ubuntu,$min_disk_size" >> $hourly_log_file
echo "average,$avg_ram_total,$avg_ram_used,$avg_ram_free,$avg_ram_shared,$avg_ram_buff,$avg_ram_available,$avg_swap_total,$avg_swap_used,$avg_swap_free,/home/ubuntu,$avg_disk_size" >> $hourly_log_file

# Mengeset izin 
chmod 600 $hourly_log_file

# Konfigurasi cron untuk menjalankan skrip ini setiap jam
# 0 * * * * /home/ubuntu/SISOP/soal_4/aggregate_minutes_to_hourly_log.sh
