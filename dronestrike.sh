#!/usr/bin/env bash
TMP_DIR=$(mktemp -d)
cd $TMP_DIR

WEAPONRY=(nmap)
for item in ${WEAPONRY[@]}; do
  if [ ! -d ${TMP_DIR}/$item ]; then
    mkdir ${TMP_DIR}/$item
  fi
done
#trap 'rm -rf -- "$TMP_DIR"' EXIT

TARGET="TARGET"
TARGET_ALIAS=""

USR_BIN=(nmap xsltproc xdg-open)

FILE_DATE_FORMAT="%m-%d-%Y-%H%M%S%Z"

RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
BLUE=$(tput setaf 4)
YELLOW=$(tput setaf 3) 
RESET=$(tput sgr0)

BOLD=$(tput bold)

LOG_LEVEL='INFO'
LOGGER_DATE_FORMAT="%m/%d/%Y-%H:%M:%S%Z"
LOGGER_PREFIX_DEBUG="${BOLD}${BLUE}[~]${RESET}"
LOGGER_PREFIX_INFO="${BOLD}${GREEN}[+]${RESET}"
LOGGER_PREFIX_WARN="${BOLD}${YELLOW}[*]${RESET}"
LOGGER_PREFIX_ERROR="${BOLD}${RED}[!]${RESET}"

SYMBOL_ACTION="${BOLD}${RED}>${RESET}"

NMAP_OUTPUT_OPTS="output opts"
NMAP_STD_OPTS_TCP="standard tcp opts"
NMAP_A_OPTS_TCP="aggressive tcp opts"
NMAP_STD_OPTS_UDP="standard udp opts"
NMAP_A_OPTS_UDP="aggressive udp opts"

log(){
  echo "$(date +$LOGGER_DATE_FORMAT) $1"
}

log_debug(){
  if [[ "$LOG_LEVEL" =~ ^(DEBUG)$ ]]; then
    log "$LOGGER_PREFIX_DEBUG $1"
  fi
}

log_info(){
  if [[ "$LOG_LEVEL" =~ ^(DEBUG|INFO)$ ]]; then
    log "$LOGGER_PREFIX_INFO $1"
  fi
}

log_warn(){
  if [[ "$LOG_LEVEL" =~ ^(DEBUG|INFO|WARN)$ ]]; then
    log "$LOGGER_PREFIX_WARN $1"
  fi
}

log_error(){
  if [[ "$LOG_LEVEL" =~ ^(DEBUG|INFO|WARN|ERROR)$ ]]; then
    log "$LOGGER_PREFIX_ERROR $1"
  fi
}

main(){
  log_debug "Creating ${TMP_DIR}"
  log_info  "${BOLD}${GREEN}(${RESET} Welcome to ${RED}DroneStrike${RESET}${BOLD} ${GREEN})${RESET}" 
  log_info  "${BOLD}${YELLOW}GENERATING OP ORDER${RESET}"
  log_info  "  ${RED}TARGET(s)${RESET}: ${GREEN}${TARGET}${RESET}"
  log_info  "  ${RED}NMAP${RESET}"
  log_info  "    ${BOLD}Loadout(TCP):${RESET}"
  log_info  "     ${RED}*${RESET} Standard:   nmap ${NMAP_STD_OPTS_TCP} ${NMAP_OUTPUT_OPTS} ${TARGET}"
  log_info  "     ${RED}*${RESET} Aggressive: nmap ${NMAP_A_OPTS_TCP}   ${NMAP_OUTPUT_OPTS} ${TARGET}"
  log_info  "    ${BOLD}Loadout(UDP):${RESET}"
  log_info  "     ${RED}*${RESET} Standard:   nmap ${NMAP_STD_OPTS_UDP} ${NMAP_OUTPUT_OPTS} ${TARGET}"
  log_info  "     ${RED}*${RESET} Aggressive: nmap ${NMAP_A_OPTS_UDP} ${NMAP_OUTPUT_OPTS} ${TARGET}"
}

preflight(){
  usr_bin_check
}

usr_bin_check(){
  for bin in ${USR_BIN[@]}; do
    if [ ! -f /usr/bin/$bin ]; then
      echo "$bin required but does not exist, quitting."
      exit 1
    fi
  done
}

generate_op_order(){
  true
}

approve_op_order(){
  true
}

execute_op_order(){
  true
}

convert_nmap_xml_to_html(){
  true
}

open_nmap_html(){
  true
}

preflight
main

exit 0 
