#!/usr/bin/env sh
set -e
cd ${BASEDIR}

if [ -f "jsonnetfile.lock.json" ] || [ -f "jsonnetfile.json" ]; then
  jb install
fi

exec jsonnet -J vendor "$@"
