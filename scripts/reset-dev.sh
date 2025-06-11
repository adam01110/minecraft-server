#!/usr/bin/env bash

VOLUMES=(
  "minecraft-server-dev_velocity-logs"
  "minecraft-server-dev_minecraft"
  "minecraft-server-dev_minecraft-logs"
)

DIRECTORIES=(
  "datapacks"
  "plugins/minecraft"
  "plugins/velocity"
  "worlds/world"
  "worlds/nether"
  "worlds/end"
)

KEEP_FILES=(
  "bukkit"
  ".paper-remapped"
  "bStats"
  "spark"
  "gale-world.yml"
  "paper-world.yml"
  "datapacks"
)

# loop through all volumes and delete
for volume in "${VOLUMES[@]}"; do
  echo " Deleting docker volume: $volume"
  docker volume rm "$volume" >/dev/null 2>&1
done

# count total items to process
total_items=0
for directory in "${DIRECTORIES[@]}"; do
  if [[ -d "$directory" ]]; then
    for item in "$directory"/*; do
      if [[ -e "$item" ]]; then
        ((total_items++))
      fi
    done
  fi
done

# create temporary folder with timestamp
temp_folder="minecraft-dev-$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
mkdir -p "$temp_folder"

# process items with progress bar
processed_items=0
for directory in "${DIRECTORIES[@]}"; do
  if [[ -d "$directory" ]]; then
    for item in "$directory"/*; do
      if [[ -e "$item" ]]; then
        ((processed_items++))

        # calculate progress (0-10)
        progress=$((processed_items * 10 / total_items))

        # build progress bar
        bar=""
        for ((i = 1; i <= 10; i++)); do
          if [[ $i -le $progress ]]; then
            bar+="="
          elif [[ $i -eq $((progress + 1)) ]]; then
            bar+=">"
          else
            bar+=" "
          fi
        done

        basename_item=$(basename "$item")
        keep_file=false
        for keep in "${KEEP_FILES[@]}"; do
          if [[ "$basename_item" == "$keep" ]]; then
            keep_file=true
            break
          fi
        done

        if [[ "$keep_file" == true ]]; then
          action="Keeping"
          icon="󰆓"
        else
          action="Deleting"
          icon=""
          mv "$item" "$temp_folder/"
        fi

        # clear entire screen area and reposition
        echo -ne "\033[2K\r[$bar] Processing directory: $directory\n"
        echo -ne "\033[2K$icon $action: $basename_item"
        echo -ne "\033[1A\033[999C"
      fi
    done
  else
    echo "󰅙 Directory not found: $directory"
  fi
done

# move the entire folder to trash
if [[ -d "$temp_folder" && $(ls -A "$temp_folder" 2>/dev/null) ]]; then
  trashy put "$temp_folder"
else
  rmdir "$temp_folder" 2>/dev/null
fi

echo -ne "\033[1B\n"
