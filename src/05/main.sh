#!/bin/bash
START_TIME=$(date +%s.%N)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/validation.sh"
validate_input "$@"
TARGET_DIR=$1
TOTAL_FOLDERS=$(find "$TARGET_DIR" -type d | wc -l)
TOTAL_FOLFILES=$(find "$TARGET_DIR" -type f | wc -l)
CONF=$(find "$TARGET_DIR" -type f -name "*.conf" | wc -l)
LOG=$(find "$TARGET_DIR" -type f -name "*.log" | wc -l)
ARCH=$(find "$TARGET_DIR" -type f \( -iname "*.zip" -o -iname "*.tar" -o -iname "*.gz" -o -iname "*.tgz" -o -iname "*.bz2" -o -iname "*.xz" -o -iname "*.7z" -o -iname "*.rar" \) | wc -l)
SYM=$(find "$TARGET_DIR" -type l | wc -l)

count=0
while IFS= read -r -d '' file; do
  mime=$(file -b --mime-type "$file")
  if [[ "$mime" == text/* ]];then
    ((count++))
  fi
done < <(find "$TARGET_DIR" -type f -print0)
EXEC=$(find "$TARGET_DIR" -type f -executable| wc -l)
echo "Total number of folders (including all nested ones) = $TOTAL_FOLDERS"
echo "TOP 5 folders of maximum size arranged in descending order (path and size):"

i=1
du -h "$TARGET_DIR" | sort -hr | head -n 5 | while read -r size path; do
  echo "$i - $path, $size"
  i=$((i+1))
done

echo "Total number of files = $TOTAL_FOLFILES"

echo "Number of:"
echo "Configuration files (with the .conf extension) = $CONF"
echo "Text files = $count"
echo "Executable files = $EXEC"
echo "Log files (with the extension .log) = $LOG"
echo "Archive files = $ARCH"
echo "Symbolic links = $SYM"

echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
i=1
find "$TARGET_DIR" -type f  -printf "%s\t%p\n" | sort -nr | head -n 10 | while read -r size path; do
  name="${path##.}"
  if [[ "$name" == *.* ]]; then
    type="${name##*.}"
  else
    type="none"
  fi
  
  size=$((size/8))
  echo "$i - $path, $size KB, $type"
  i=$((i+1))
done

echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):"

i=1
find "$TARGET_DIR" -type f -executable -printf "%s\t%p\n" | sort -nr | head -n 10 | while read -r size path; do
  hash=$(md5sum "$path" | awk '{print $1}')

  size=$((size/8))
  echo "$i - $path, $size KB, $hash"
  i=$((i+1))
done
END_TIME=$(date +%s.%N)
EXEC_TIME=$(awk -v s="$START_TIME" -v e="$END_TIME" 'BEGIN {printf "%.3f", e - s}')
echo "Script execution time (in seconds) = $EXEC_TIME"