# Introduction

Simple dockerfile to intall jsonnet-bundler (jb) and go-jsonnet into a runnable
container.

# Usage
You need to mount the to-be-build directory to `/src` in the container. Existing
jsonnetfile.json dependencies will be installed and the jsonnet compiled. You
can pass extra arguments to the jsonnet:

```
docker run --rm -it -v $(pwd):/src syseleven/jsonnet-builder ${ARGS}
```

## Change jsonnet basedir
If you require modules in another folder, you can mount both into /src and
specify the basedir for your jsonnet build. Assuming you have the following
structure:

```
$ find .
one/
one/jsonnetfile.json
one/one.jsonnet
two/
two/two.jsonnet
```

If `one` requires `two`, you can use the command

```
docker run --rm -it -v $(pwd):/src -e BASEDIR=one/ syseleven/jsonnet-builder '-S "one.jsonnet"'
```

All entrypoint commands (jb and jsonnet) will be relative to `/src/${BASEDIR}`
(or `${BASEDIR}` if specified as absolute path).
