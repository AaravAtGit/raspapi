#!/bin/sh

GREEN='\033[0;32m'
CYAN='\033[0;36m'
RED='\033[0;31m'
BOLD='\033[1m'
RESET='\033[0m'

INFO=$(bunx wrangler whoami --json 2>/dev/null)
EMAIL=$(echo "$INFO" | grep -o '"email": "[^"]*"' | grep -o '[^"]*@[^"]*')
if [ -n "$EMAIL" ]; then
  echo -e "\n${GREEN}${BOLD}Already logged in as ${EMAIL}${RESET}"
  exit 0
fi

TMPFILE=$(mktemp)
bunx wrangler login > "$TMPFILE" 2>&1 &
WRANGLER_PID=$!

while ! grep -q "dash.cloudflare.com" "$TMPFILE" 2>/dev/null; do
  sleep 0.2
done

AUTH_URL=$(grep -o 'https://dash.cloudflare.com[^ ]*' "$TMPFILE")

echo -e "${BOLD}Open (ctrl-click) this URL & log in:${RESET}"
echo -e "${CYAN}${AUTH_URL}${RESET}\n"
echo -e "After logging in, copy & paste the URL (localhost:8976) from your address bar here: \c"
read -r CALLBACK_URL < /dev/tty

curl -s --max-time 5 "$CALLBACK_URL" > /dev/null
sleep 2
kill $WRANGLER_PID 2>/dev/null
wait $WRANGLER_PID 2>/dev/null

INFO=$(bunx wrangler whoami --json 2>/dev/null)
EMAIL=$(echo "$INFO" | grep -o '"email": "[^"]*"' | grep -o '[^"]*@[^"]*')
if [ -n "$EMAIL" ]; then
  echo -e "\n${GREEN}${BOLD}Logged in as ${EMAIL}${RESET}"
else
  echo -e "\n${RED}${BOLD}Login failed. Please try again.${RESET}"
  exit 1
fi
