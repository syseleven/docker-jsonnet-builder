#!/usr/bin/env sh

set -e
cd ${BASEDIR}

exec jsonnet -J vendor "$@"
