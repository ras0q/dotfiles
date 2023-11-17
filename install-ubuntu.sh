#!/bin/bash -eu

function info {
  echo "\033[32m[INFO]\033[0m $1"
}

IS_NONROOT="FALSE"

while getopts n OPT
do
  case $OPT in
    "n" ) IS_NONROOT="TRUE" ; info "Running as non-root user" ;;
  esac
done

TASKS_DIR="./ubuntu"$([ $IS_NONROOT = "TRUE" ] && echo "/tasks_nonroot" || echo "/tasks")

# Execute tasks in $TASKS_DIR one by one
for task in $TASKS_DIR/*; do
  info "$(basename $task): Executing..."
  sh -c $task
  info "$(basename $task): Done!"
done
info "All tasks are done!"
