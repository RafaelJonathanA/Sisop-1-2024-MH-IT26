#!/bin/bash

log_file="/home/ubuntu/log/metrics_$(date +'%Y%m%d%H%M%S').log"

echo "mem_total,mem_used,mem_free,mem_shared,mem_buff,mem_available,swap_total,swap_used,swap_free,path,path_size" > "$log_file"

ram_info=$(free -m | awk 'NR==2 {print $2","$3","$4","$5","$6","$7}')
swap_info=$(free -m | awk 'NR==3 {print $2","$3","4}') 

target_path="/home/ubuntu/coba"
path_size=$(du -sh "$target_path" | awk '{print $1}')

echo "$ram_info,$swap_info,$target_path,$path_size" >> "$log_file"
chmod +x $log_file 

# Konfigurasi cron untuk menjalankan skrip ini setiap menit
# * * * * * /bash /home/ubuntu/SISOP/soal_4/minute_log.sh
