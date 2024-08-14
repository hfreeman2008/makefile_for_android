#!/bin/bash

################################################################################
#功能说明：文件夹复制到目的文件夹
#调用说明：
#
#. overlay_codes_copy_hytera.sh $src_file $dest_path/
#overlay_codes_copy_hytera.sh $src_file $dest_path/
#
#
################################################################################


function copy() {
    local src=$1
    local des=$2
    echo "overlay_codes_copy_hytera.sh copy src : $src"
    echo "overlay_codes_copy_hytera.sh copy des : $des"

    if [ -d ${src} -a -d ${des} ]; then
        echo "cp -rf ${src}* ${des}"
        cp -rf ${src}* ${des}
    fi
}

function main()
{
    echo "*******do overlay codes copy hytera start********"
    echo "overlay_codes_copy_hytera.sh main src : $1"
    echo "overlay_codes_copy_hytera.sh main des : $2"
    copy $1 $2
    echo "*******do overlay codes copy hytera end********"
}


main $1 $2


