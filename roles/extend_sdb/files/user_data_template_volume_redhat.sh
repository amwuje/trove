#disk partition & format

#usage:
#   format_disk "/dev/sdb"   "postgres:postgres" "/var/lib/postgresql/data" "DB"
format_disk()
{
    dev_name=$1 
    volume_owner=$2
    volume_path=$3
    omc_host_type=$4

    /usr/bin/expect /var/run/initdev.expect $dev_name | tee /var/log/init-debug.log
    if [ $omc_host_type == 'DB' ]; then
        #systemctl stop mysqld
        echo "mv ${volume_path} ${volume_path}-init" >> /var/log/init-debug.log
        mv ${volume_path} ${volume_path}-init
        # rm -fr $volume_path
    else
        rm -fr $volume_path
    fi
    mkdir -p $volume_path
    echo "mount ${dev_name}1 $volume_path" >> /var/log/init-debug.log
    mount ${dev_name}1 $volume_path
    echo "${dev_name}1    $volume_path     xfs    defaults        0 0" >> /etc/fstab
    echo "chown -R $volume_owner $volume_path" >> /var/log/init-debug.log
    chown -R $volume_owner $volume_path
    if [ $omc_host_type == 'DB' ]; then
        echo "mv ${volume_path}-init/* ${volume_path}/" >> /var/log/init-debug.log
        mv ${volume_path}-init/* ${volume_path}/
        echo "chown -R $volume_owner $volume_path" >> /var/log/init-debug.log
        chown -R $volume_owner $volume_path
        echo "rm -fr ${volume_path}-init" >> /var/log/init-debug.log
        rm -fr ${volume_path}-init
        # echo "rm -fr /var/lib/HBdb-init" >> /var/log/init-debug.log
        # rm -fr /var/lib/HBdb-init
    fi
}

format_disk "$1"   "$2" "$3" "$4"
