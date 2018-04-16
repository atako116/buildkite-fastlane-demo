#!/bin/bash

set -eu

echo "--- :gem: Bundling gems"
gem install bundler
bundle install

echo "--- :swift: Installing Swift dependencies"
rm -rf Carthage/
bin/fetch

echo "--- :buildkite: Setting version metadata"
VERSION=$(/usr/libexec/PlistBuddy -c "Print :CFBundleShortVersionString" ../Venmo/Resources/Base.lproj/Info.plist)
buildkite-agent meta-data set "version" "${VERSION}"

echo "--- :fastlane: Running unit tests"
bundle exec fastlane scan --scheme Venmo --clean true --skip_slack true
