# Linux Monitoring v1.0

Bash scripts for Linux system research and monitoring with colored terminal output.

## Overview

A set of modular bash scripts that collect and display detailed system information from a Linux machine. Supports colored output configurable via CLI parameters or a config file.

## Features

- **System info** — hostname, timezone, current user, OS version, uptime, uptime in seconds, IP address, network mask, default gateway, RAM (total/used/free), disk space (root partition total/used/free)
- **Export to file** — save collected data to a timestamped `.status` file
- **Colored output** — configure background and font color for two columns via 4 CLI parameters (6 colors available)
- **Config-based colors** — set color scheme in `config.conf` instead of passing parameters every time
- **File system research** — analyze any directory: folder/file counts by type, top-5 folders and top-10 files by size, executable files with MD5 hashes, script execution time

## Project Structure

```
src/
├── 01/   # Parameter validation: text vs numeric input
├── 02/   # System info collector with Y/N file export
├── 03/   # Colored output via 4 CLI parameters
├── 04/   # Colored output via config file
└── 05/   # File system research script
```

## Usage

```bash
# Basic system info with file export option
bash src/02/main.sh

# Colored output (background_col1 font_col1 background_col2 font_col2)
# Colors: 1-white, 2-red, 3-green, 4-blue, 5-purple, 6-black
bash src/03/main.sh 1 3 4 5

# Colored output via config file
bash src/04/main.sh

# File system research
bash src/05/main.sh /var/log/
```

## Requirements

- Ubuntu Server 24.04 LTS
- Bash 5+

## Tech

`bash` · `linux` · `awk` · `df` · `free` · `ip` · `ANSI escape codes`
