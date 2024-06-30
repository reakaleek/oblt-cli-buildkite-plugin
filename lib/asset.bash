#!/usr/bin/env bash

set -euo pipefail

function get_os() {
	local system=${1:-$(uname -s)}

	case "${system}" in
	Darwin*)
		echo 'darwin'
		;;
	Linux*)
		echo 'linux'
		;;
	*)
		>&2 echo "Unsupported OS. Exiting."
		exit 1
		;;
	esac
}

function get_arch() {
	local machine=${1:-$(uname -m)}
	case "${machine}" in
	x86_64)
		echo 'amd64'
		;;
	arm64)
		echo 'arm64'
		;;
	*)
		>&2 echo "Unsupported architecture. Exiting."
		exit 1
		;;
	esac
}

function get_asset_name() {
	local version=$1
	local system=${2:-}
	local machine=${3:-}
	local os
	local arch
	if ! os=$(get_os "$system"); then exit 1; fi
	if ! arch=$(get_arch "$machine"); then exit 1; fi
	echo "oblt-cli_${version}_${os}_${arch}.tar.gz"
}

function get_asset_id() {
	local gh_token=${GH_TOKEN:-}
	local version=$1
	local asset_name
	local release
	asset_name=$(get_asset_name "$version")
	release=$(curl -sL \
		-H "Accept: application/vnd.github+json" \
		-H "Authorization: Bearer ${gh_token}" \
		-H "X-GitHub-Api-Version: 2022-11-28" \
		"https://api.github.com/repos/elastic/observability-test-environments/releases/tags/${version}")
	echo "$release" | jq -r --arg name "$asset_name" '.assets | .[] | select(.name == $name) | .id'
}

function download_asset() {
	local gh_token=${GH_TOKEN:-}
	local asset_id=$1
	local target_dir=$2
	curl -sL \
		-H "Accept: application/octet-stream" \
		-H "Authorization: Bearer ${gh_token}" \
		-H "X-GitHub-Api-Version: 2022-11-28" \
		"https://api.github.com/repos/elastic/observability-test-environments/releases/assets/${asset_id}" | tar -xz -C "$target_dir"
	echo "$target_dir/oblt-cli"
}
