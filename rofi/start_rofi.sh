#!/usr/bin/env bash

exec rofi -show $1 -normal-window -terminal $TERMINAL -config "$(dirname "$0")/$2"
