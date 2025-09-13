#!/usr/bin/env bash
# treesmart.sh  –  always expand dirs, limit files per folder
# default: depth=3, limit=10

treesmart() {
  local dir="."
  local limit=10         # files-per-folder limit
  local depth=3          # recursion depth

  # Parse CLI
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --help|-h)
        cat <<EOF
Usage: treesmart [DIR] [--limit N] [--depth N]

Always lists ALL sub-directories, but shows at most N *files* per folder
(default limit=10). Recursion depth defaults to 3.

Options
  --limit N   Max files shown per directory (default 10)
  --depth N   Max recursion depth        (default 3)
  --help      Show this help and exit
EOF
        return 0 ;;
      --limit) shift; limit="$1" ;;
      --depth) shift; depth="$1" ;;
      *)       dir="$1" ;;
    esac
    shift
  done

  [[ -d "$dir" ]] || { echo "treesmart: '$dir' is not a directory." >&2; return 1; }

  find "$dir" -maxdepth "$depth" -printf '%p|%y\n' | \
  awk -F'|' -v LIMIT="$limit" '
  function basename(path) {
    n = split(path, arr, "/");
    return arr[n];
  }
  {
      path = $1
      type = $2
      n = split(path, arr, "/")
      parent = (n > 1 ? substr(path, 1, length(path) - length(arr[n]) - 1) : "")
      filecnt[parent] += (type=="f")
      indent = ""; for(i=2;i<=n;i++) indent=indent"│   ";

      if (type=="d") {          
          print indent "├── " "\033[1;34m" basename(path) "\033[0m";
      } else if (type=="f") {
          if (filecnt[parent] <= LIMIT) {
              print indent "├── " basename(path);
          } else if (filecnt[parent] == LIMIT+1) {
              print indent "└── ... (more files)";
          }
      }
  }'
}

treesmart "$@"

