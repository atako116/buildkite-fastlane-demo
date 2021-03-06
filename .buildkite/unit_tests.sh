set -eu

echo "--- :gem: Bundling gems"
gem install bundler
bundle install

#echo "--- :buildkite: Setting version metadata"
VERSION=$(/usr/libexec/PlistBuddy -c "Print :CFBundleShortVersionString" "./Buildkite Fastlane Demo/Info.plist")
buildkite-agent meta-data set "version" "${VERSION}"
#
echo "--- :fastlane: Running unit tests"
bundle exec fastlane test
