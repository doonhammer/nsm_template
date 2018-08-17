# Demo repository for building NSM dataplanes from a set of templates

This set files enables building a complete direcotry structure and build system for a new dataplane impalmentation. There is a script that automates the process.

'''
$ srcipts/mk-template.sh -h
'''

The script will substitute the name of your dataplane into the appropriate files and directories, by replacing "template" and "NSMTEMPLATEDATAPLANE"

Once the new directory structure is built the developer should only need to modify a few files:

pkg/nsm/apos/template/template.go
cmd/template/template.go
