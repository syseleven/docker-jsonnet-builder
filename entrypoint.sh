#!/usr/bin/env sh
set -e
cd ${BASEDIR}

jb install
exec jsonnet -J vendor "$@"
