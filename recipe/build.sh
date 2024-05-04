#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

cd release/cmd/tailscale

go-licenses save . \
    --save_path ../../library_licenses

GIT_COMMIT_SHA=$(cd $SRC_DIR/git && git rev-parse HEAD)
GIT_SHORT_SHA=${GIT_FULL_HASH:0:9}
go build -v \
    -ldflags "-s -w -X 'tailscale.com/version.shortStamp=$PKG_VERSION' -X 'tailscale.com/version.longStamp=$PKG_VERSION-t$GIT_SHORT_SHA' -X 'tailscale.com/version.gitCommitStamp=$GIT_COMMIT_SHA'" \
    -o $PREFIX/bin/tailscale
