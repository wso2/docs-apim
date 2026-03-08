echo " ======== Converting GeoLite2-City-Blocks-IPv4.csv ======="

echo "Enter path to GeoLite2-City-Blocks-IPv4 directory: "
read original_dir
if [ -z $original_dir ]; then
    echo "path to patched directory not provided, execution terminated!"
    exit 0;
elif [ ! -d "$original_dir" ]; then
    echo "Cannot find the directory path $patch_dir, execution terminated! "
    exit 0;
elif [ -d "$original_dir" ];then
    echo "Enter path to geoip2-csv-converter home directory: "
    read bin_dir
    if [ -z $bin_dir ]; then
        echo "path to patched directory not provided, execution terminated!"
        exit 0;
    elif [ ! -d "$bin_dir" ]; then
        echo "Cannot find the directory path $bin_dir, execution terminated! "
        exit 0;
    elif [ -d "$bin_dir" ];then

        #Convert GeoLite2-City-Blocks-IPv4
        echo " ** convert GeoLite2-City-Blocks-IPv4"
        $bin_dir/geoip2-csv-converter -block-file=$original_dir/"GeoLite2-City-Blocks-IPv4.csv" -include-integer-range=true -output-file=$original_dir/"GeoLite2-City-Blocks-IPv4-converted.csv"

        #Get first column form original GeoLite2-City-Blocks-IPv4
        echo " ** get first column form original"
        cut -d , -f 1 $original_dir/GeoLite2-City-Blocks-IPv4.csv > first.csv

        #Change column name ‘network’ to ‘network_cidr’
        echo " ** change column name to ‘network_cidr’"
        sed -i '' '1s/network/network_cidr/' first.csv

        #Extract first two numbers from first.csv
        echo " ** Extract ip address data"
        cut -d "." -f -2 first.csv > last.csv

        #Change column name ‘network_cidr’ to ‘network_blocks’
        echo " ** change column name to ‘network_blocks’"
        sed -i '' '1s/network_cidr/network_blocks/' last.csv 

        #Extract entries from GeoLite2-City-Blocks-IPv4-converted.csv
        echo " ** extract entries from original"
        cut -d , -f 1-10 $original_dir/GeoLite2-City-Blocks-IPv4-converted.csv > middle.csv

        #Change column name ‘network_start_integer’ to ‘network’
        echo " ** change column name to ‘network’"
        sed -i '' '1s/network_start_integer/network/' middle.csv 

        #Change column name ‘network_last_integer’ to ‘broadcast’
        echo " ** change column name to ‘broadcast’"
        sed -i '' '1s/network_last_integer/broadcast/' middle.csv 

        #Merge csv files
        echo " ** merge csv files"
        paste -d , first.csv middle.csv last.csv > final.csv
        
    fi
fi

