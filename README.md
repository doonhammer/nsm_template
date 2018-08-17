# Building NSM dataplanes from templates

This is a starting point for a developer who wants to extend the Network Service Mesh with their own plugin(s). It separates out the concerns and only shows the files that are necessary to build a new plugin.

This set files enables building a complete directory structure and build system for a new dataplane implementation. There is a script that automates the process:

```
$ scripts/mk-template.sh -h
```

```
Usage: mk-template.sh [-h] [-t template name] [-p path to directory to create] [-d directory to delete]
 
     -h          display this help and exit
     -t          create template files and directory structure, default 'simple'
     -p          define path for template directory, default nsm_template/samples
     -d          delete an existing template directory

```

The script will substitute the name of your dataplane into the appropriate files and directories, by replacing "template" and "NSMTEMPLATEDATAPLANE"

Once the new directory structure is built the developer should only need to modify a few files:

```
pkg/nsm/apos/template/template.go
cmd/template/template.go
```

By default the new tree is created in the samples directory. There is a simple-dataplane example (created from simple-dataplane example in main tree). This is created by

```
$scripts/mk-template.sh -t simple-dataplane
```
This creates a dieecotry within the samples directory

```
$ ls samples/nsm-simple-dataplane
```
From this directory a developer can build the simple-dataplane and then start modifing it to suite their requirements.