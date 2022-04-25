#!/usr/bin/env zsh
# vi: set expandtab ft=zsh tw=80 ts=2

function loadDocopts() {
  whence docopts >&! /dev/null && return
  local cwd=$(pwd)
  if [[ ! -f ${cwd}/docopts ]]; then
    local fileURL="${DOCOPTS_URL:-https://github.com/astzweig/docopts/releases/download/v.0.7.0/docopts_darwin_amd64}"
    curl --output ${cwd}/docopts -fsSL "${fileURL}" || return
    chmod u+x ${cwd}/docopts
  fi
  [[ -f ${cwd}/docopts ]] && path+=(${cwd})
}

function loadZShLib() {
  local libFuncs=(
    abbreviatePaths
    askUser
    checkCommands
    config
    getMissingPaths
    getPrefDir
    hio
    indicateActivity
    isTerminalBackgroundDark
    lop
    pf
    showSpinner
    traps
  )
  autoload -Uz ${libFuncs}
  if ! pf --help >&! /dev/null; then
    local cwd=$(pwd)
    if [[ ! -f ${cwd}/zshlib.zwc ]] && whence curl >&! /dev/null; then
      local fileURL=${ZSHLIB_URL:-https://github.com/astzweig/zshlib/releases/download/v1.0.1/zshlib.zwc}
      curl --output ${cwd}/zshlib.zwc -fsSL ${fileURL}
    fi
    [[ -f ${cwd}/zshlib.zwc ]] && fpath+=(${cwd}/zshlib.zwc)
  fi
  pf --help >&! /dev/null
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
