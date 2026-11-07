#!/usr/bin/env sh
# cangjie-skill installer — pulls a distilled skill's SKILL.md from the vault
# (Knowledge/40-Templates/cangjie/<name>/SKILL.md) into a Hermes profile.
# Usage: install.sh <skill-name> [profile=default]
set -eu
NAME="${1:?usage: install.sh <skill-name> [profile]}"
PROFILE="${2:-default}"
DEST="$HOME/.hermes/skills/software-development/$NAME"
mkdir -p "$DEST"
rclone copyto "macbook-vault:/Users/admin/Documents/Obsidian Vault/Knowledge/40-Templates/cangjie/$NAME/SKILL.md" \
  "$DEST/SKILL.md"
echo "installed $NAME -> $DEST"
