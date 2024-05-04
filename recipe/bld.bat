@echo on

cd release/cmd/tailscale

go-licenses save . ^
    --save_path ../../library_licenses

set "GIT_SHORT_HASH=!GIT_FULL_HASH:~0,9!"
go install -v ^
    -ldflags "-s -w -X 'tailscale.com/version.shortStamp=v%PKG_VERSION%' -X 'tailscale.com/version.longStamp=%PKG_VERSION%-t%GIT_SHORT_HASH%' -X 'tailscale.com/version.gitCommitStamp=%GIT_FULL_HASH%'" ^
    .
