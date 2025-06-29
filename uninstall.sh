#!/bin/bash

systemctl --user stop scot.massie.FocusNotifier.listener.service;
systemctl --user disable scot.massie.FocusNotifier.listener.service;

rm "$HOME/.config/systemd/user/scot.massie.FocusNotifier.listener.service";
rm -rf "$HOME/.config/FocusNotifier"
rm "$HOME/.local/bin/activewindow";
rm "$HOME/.local/bin/FocusNotifierListener.sh";

