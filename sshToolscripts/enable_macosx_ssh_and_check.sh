#!/bin/sh
echo "enable the ssh server..."
systemsetup -setremotelogin on
sudo launchctl load -w /System/Library/LaunchDaemons/ssh.plist

echo "checking the ssh server.."
nc -z -v localhost 22
