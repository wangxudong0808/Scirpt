#!/bin/bash
df_output=$(df -h)
while read -r line; do
    disk=$(echo "$line" | awk '{print $NF}')
    usage=$(echo "$line" | awk '{print $5}' | tr -d '%')

    if [ $usage -gt 60 ]; then
        echo "警告：$disk 磁盘使用率超过 60%，当前使用率为 $usage%"
    else
        echo "正常：$disk 磁盘使用率为 $usage%"
    fi
done <<< "$(echo "$df_output" | tail -n +2)"

