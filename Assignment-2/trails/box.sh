#! bin/bash

#symbols for box drawing
TOP_LEFT='\u2554'
TOP_RIGHT='\u2557'
BOTTOM_LEFT='\u255a'
BOTTOM_RIGHT='\u255d'
HORIZONTAL='\u2550' #${HORIZONTAL} - is not working...
VERTICAL='\u2551'

#display box
echo -e "${TOP_LEFT}$(printf '%.0s\u2550' {1..45})${TOP_RIGHT}"
echo -e "${VERTICAL}                                             ${VERTICAL}"
echo -e "${VERTICAL}       ${YELLOW}SYSTEM INFORMATION DISPLAY${RESET}            ${VERTICAL}"
echo -e "${VERTICAL}                                             ${VERTICAL}"
echo -e "${BOTTOM_LEFT}$(printf '%.0s\u2550' {1..45})${BOTTOM_RIGHT}"