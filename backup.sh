#!/bin/sh -e

code --list-extensions > ~/.vscode_extensions

brew bundle dump --global --force
