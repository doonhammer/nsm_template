#!/bin/sh
#
#
# Create a directory structure for NSM
#
show_help() {
cat << EOF
Usage: ${0##*/} [-h] [-s logical-switch] [-v logical VNF port] [-a logical qpplication port] [-d display current state] [-e echo the porposed commands] [-f dump flows after commands are applied] [-c clear configuration]
 
     -h          display this help and exit
     -c          create directory structure
EOF
}
#
# Parse Command Line Arguments
#
while getopts "hc:d:p:" opt; do
    case "$opt" in
        h)
            show_help
            exit 0
            ;;
        p) opt_p=$OPTARG
           ;;
        c) opt_c=$OPTARG
           ;;
        d) opt_d=$OPTARG
           ;;
        '?')
            show_help
            exit 1
            ;;
    esac
done
echo
if [ ! -z "$opt_c" ]; then
        nsm_dir='nsm_'$opt_c
        echo "Creating new directory structure below: $nsm_dir"
fi
if [ ! -z "$opt_p" ]; then
        echo "Path for template directory: $opt_p"
fi
if [ ! -z "$opt_d" ]; then
        echo -n "Are you sure you want to DELETE directory structure below $opt_d [Y/N]: "
        read response
        if [ "$response"=="Y" ]; then
            echo "Deleting all files below: $opt_d "
            rm -rf $opt_d
            exit 1
        else
            echo "NOT Deleting all files below: $opt_d "
            exit 1
        fi
fi
echo
mkdir -p $nsm_dir/build
sed -e 's/template/'$opt_c'/g' $opt_p/build/Dockerfile.template > $nsm_dir/build/Dockerfile
mkdir -p $nsm_dir/cmd/$opt_c
sed -e 's/template/'$opt_c'/g' $opt_p/cmd/template/template.go > $nsm_dir/cmd/$opt_c/$opt_c.go
mkdir -p $nsm_dir/conf/$opt_c
sed -e 's/template/'$opt_c'/g' $opt_p/conf/template/template.yaml > $nsm_dir/conf/$opt_c/$opt_c.yaml
mkdir -p $nsm_dir/pkg/nsm/apis/$opt_c
sed -e 's/template/'$opt_c'/g' $opt_p/pkg/nsm/apis/template/template.proto > $nsm_dir/pkg/nsm/apis/$opt_c/$opt_c.proto
sed -e 's/template/'$opt_c'/g' $opt_p/pkg/nsm/apis/template/doc.go > $nsm_dir/pkg/nsm/apis/$opt_c/doc.go
sed -e 's/template/'$opt_c'/g' $opt_p/Makefile > $nsm_dir/Makefile
sed -e 's/template/'$opt_c'/g' $opt_p/.nsm.mk > $nsm_dir/.nsm.mk
echo
exit 1