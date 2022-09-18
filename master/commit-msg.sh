#!/bin/bash
# THE BEER-WARE LICENSE:
# <leokewitz@gmail.com> wrote this file. As long as you retain this notice you
# can do whatever you want with this stuff. If we meet some day, and you think
# this stuff is worth it, you can buy me a beer in return.
# Leonardo Kewitz

# Color codes
red='\033[0;31m'
yellow='\033[0;33m'
blue='\033[0;34m'
green='\033[0;32m'
NC='\033[0m' # No colors

if ! [[ $(cat $1) =~ ^((chore|docs|feat|fix|merge|perf|refact|refactor|style|test|wip)(\([a-zA-Z0-9]+\))?:|Merge\ pull) ]]; then
  printf "${red}Please use semantic commit messages:\n"
  printf "${yellow}feat${NC}[${green}(scope)${NC}]: ${blue}add hat wobble\n"
  printf "${yellow}^--^${green} ^--*--^ ${blue}  ^------------^ -> Summary in present tense.\n"
  printf "${yellow} *      ${green}*-> [optional]: Scope of the commit.\n"
  printf "${yellow} *-> Type: chore, docs, feat, fix, merge, perf, refact, style, test, or wip.\n${NC}"
  exit 1
fi

while read line; do
  # Skip comments
  if [ "${line:0:1}" == "#" ]; then
    continue
  fi
  if [ ${#line} -gt 100 ]; then
    echo -e "${yellow}Commit messages are limited to 100 characters.${NC}"
    echo -e "The following commit message has ${red}${#line}${NC} characters."
    echo "${line}"
    exit 1
  fi
done < "${1}"

exit 0