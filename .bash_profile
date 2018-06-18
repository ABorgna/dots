#!/usr/bin/env bash

if [ -f ~/.bashrc ]; then
      . ~/.bashrc   # --> Read ~/.bashrc, if present.
fi

if [ -e /home/z/.nix-profile/etc/profile.d/nix.sh ]; then . /home/z/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
