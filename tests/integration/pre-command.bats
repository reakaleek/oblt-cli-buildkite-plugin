#!/usr/bin/env bats

load "$BATS_PLUGIN_PATH/load.bash"

@test "pre-command" {
	# act
	run env BUILDKITE_PLUGIN_OBLT_CLI_USERNAME="obltmachine" \
		BUILDKITE_PLUGIN_OBLT_CLI_SLACK_CHANNEL="#observablt-bots" \
		BUILDKITE_PLUGIN_OBLT_CLI_VERSION="" \
		BUILDKITE_PLUGIN_OBLT_CLI_VERSION_FILE="${PWD}/tests/fixtures/.tool-versions" \
		BUILDKITE_PLUGIN_OBLT_CLI_GITHUB_TOKEN="${GH_TOKEN:-${GITHUB_TOKEN}}" \
		"$PWD/hooks/pre-command"

	# assert
	assert_success
}

@test "pre-command2" {
	# act
	run env BUILDKITE_PLUGIN_OBLT_CLI_USERNAME="obltmachine" \
		BUILDKITE_PLUGIN_OBLT_CLI_SLACK_CHANNEL="#observablt-bots" \
		BUILDKITE_PLUGIN_OBLT_CLI_VERSION="7.3.0" \
		BUILDKITE_PLUGIN_OBLT_CLI_VERSION_FILE="" \
		BUILDKITE_PLUGIN_OBLT_CLI_GITHUB_TOKEN="${GH_TOKEN:-${GITHUB_TOKEN}}" \
		"$PWD/hooks/pre-command"

	# assert
	assert_success
}
