# Building NSM dataplanes from templates

This set files enables building a complete direcotry structure and build system for a new dataplane impalmentation. There is a script that automates the process.

```
$ scripts/mk-template.sh -h
```

The script will substitute the name of your dataplane into the appropriate files and directories, by replacing "template" and "NSMTEMPLATEDATAPLANE"

Once the new directory structure is built the developer should only need to modify a few files:

```
pkg/nsm/apos/template/template.go
cmd/template/template.go
```

By default the new tree is created in the samples directory.