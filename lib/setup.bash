#!/usr/bin/env bash

set -euo pipefail

CURR_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# shellcheck source=lib/asset.bash
. "${CURR_DIR}/asset.bash"
# shellcheck source=lib/version.bash
. "${CURR_DIR}/version.bash"

# Downloads oblt-cli and configures it
# Arguments:
#   $1: version
#   $2: username
#   $3: slack_channel
# Returns:
#   None
function setup() {
	local version=$1
	local username=$2
	local slack_channel=$3
	local bin_dir="${HOME}/oblt-cli/bin"
	local asset_id
	asset_id=$(get_asset_id "$version")
	mkdir -p "${bin_dir}"
	download_asset "$asset_id" "$bin_dir"
	export PATH="${bin_dir}:${PATH}"
	oblt-cli configure \
		--git-http-mode \
		--username="${username}" \
		--slack-channel="${slack_channel}"
}
