# Introduction

Simple dockerfile to install [jsonnet-bundler](https://github.com/jsonnet-bundler/jsonnet-bundler)
and [go-jsonnet](https://github.com/google/go-jsonnet) into a runnable container.

# Usage
You need to mount the jsonnet files to `/src` in the container. Existing
`jsonnetfile.json` dependencies will be installed and the jsonnet compiled. You
can pass extra arguments to jsonnet:

```
docker run --rm -it -v $(pwd):/src syseleven/jsonnet-builder ${ARGS}
```

If the `jsonnetfile.json` file is not directly located in the mounted folder
you can change the basedir with the BASEDIR argument.  All entrypoint commands
(jb and jsonnet) will be relative to `/src/${BASEDIR}` (or `${BASEDIR}` if
specified as absolute path).

# Example
Assuming you have the following structure

```
$ find .
one/
one/jsonnetfile.json
one/one.jsonnet
two/
two/two.jsonnet
```

If `one.jsonnet` imports `../two/two.jsonnet` and you want to pass the `-S`
flag to the build, you can use the command

```
docker run --rm -it -v $(pwd):/src -e BASEDIR=one/ syseleven/jsonnet-builder -S one.jsonnet
```
