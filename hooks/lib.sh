#!/usr/bin/env zsh
# vi: set expandtab ft=zsh tw=80 ts=2

function loadDocopts() {
  whence docopts >&! /dev/null && return
  local cwd=$(pwd)
  if [[ ! -f ${cwd}/docopts ]]; then
    local fileURL="${DOCOPTS_URL:-https://github.com/astzweig/docopts/releases/download/v.0.7.0/docopts_darwin_amd64}"
    [[ $(uname -m) == arm64 && -z ${DOCOPTS_URL} ]] && fileURL="https://github.com/astzweig/docopts/releases/download/v.0.7.0/docopts_darwin_arm64"
    curl --output ${cwd}/docopts -fsSL "${fileURL}" || return
    chmod u+x ${cwd}/docopts
  fi
  [[ -f ${cwd}/docopts ]] && path+=(${cwd})
}

function loadZShLib() {
  source autoload-zshlib
}

function getProcessTTY() {
  ps -p $$ -o tty= | sed 's/^/\/dev\//'
}

function loptty() {
  lop "$@" < $(getProcessTTY)
}

function checkExecPrerequisites() {
  local -A cmds
  getExecPrerequisites || return
  checkCommands -m 'This script needs %1$s to work. Please install and retry.' ${(k)cmds} || return
}

function app_main() {
  loadDocopts || { print -- 'This script needs docopts binary to work. Please install an retry.' >&2; exit 10 }
  loadZShLib || { print -- 'This script needs Astzweig'"'"'s zshlib library to work. Please install and retry.' >&2; exit 20 }
  checkExecPrerequisites || return
  configure_system
}

function {
  local name
  for name in getExecPrerequisites configure_system; do
    whence ${name} >&! /dev/null || function $_() {}
  done
}
