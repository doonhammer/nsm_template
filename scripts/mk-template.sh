#!/bin/sh
#
#
# Create a directory structure for NSM
#
show_help() {
cat << EOF
Usage: ${0##*/} [-h] [-t template name] [-p path to directory to create] [-d directory to delete]
 
     -h          display this help and exit
     -t          create template files and directory structure, default 'simple'
     -p          define path for template directory, default nsm_template/samples
     -d          delete an existing template direcotry
EOF
}
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
DIR=${SCRIPT_DIR/scripts}
#echo "Root directory: $DIR"
#exit 1
SAMPLES=$DIR'/samples'
opt_p=$DIR
#
# Parse Command Line Arguments
#
while getopts "ht:d:p:" opt; do
    case "$opt" in
        h)
            show_help
            exit 0
            ;;
        p) opt_p=$OPTARG
           ;;
        t) opt_t=$OPTARG
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
if [ ! -z "$opt_t" ]; then
        nsm_dir='samples/nsm-'$opt_t
        echo "Creating new template directory structure below: $nsm_dir"
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
sed -e 's/NSMDATAPLANETEMPLATE/'$opt_t'/g' $opt_p/build/Dockerfile.template > $nsm_dir/build/Dockerfile
mkdir -p $nsm_dir/cmd/$opt_t
sed -e 's/NSMDATAPLANETEMPLATE/'$opt_t'/g' $opt_p/cmd/template/template.go > $nsm_dir/cmd/$opt_t/$opt_t'.go'
mkdir -p $nsm_dir/conf/$opt_t
sed -e 's/NSMDATAPLANETEMPLATE/'$opt_t'/g' $opt_p/conf/template/template.yaml > $nsm_dir/conf/$opt_t/$opt_t'.yaml'
mkdir -p $nsm_dir/pkg/nsm/apis/$opt_t
sed -e 's/NSMDATAPLANETEMPLATE/'$opt_t'/g' $opt_p/pkg/nsm/apis/template/template.proto > $nsm_dir/pkg/nsm/apis/$opt_t/$opt_t'.proto'
sed -e 's/NSMDATAPLANETEMPLATE/'$opt_t'/g' $opt_p/pkg/nsm/apis/template/doc.go > $nsm_dir/pkg/nsm/apis/$opt_t/doc.go
sed -e 's/NSMDATAPLANETEMPLATE/'$opt_t'/g' $opt_p/Makefile > $nsm_dir/Makefile
sed -e 's/NSMDATAPLANETEMPLATE/'$opt_t'/g' $opt_p/.nsm.mk > $nsm_dir/.nsm.mk
echo
exit 1