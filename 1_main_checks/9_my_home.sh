#!/bin/bash

if ! [ "$SEARCH_IN_FOLDER" ]; then
	print_2title "Files inside $HOME (limit 20)"
	(ls -la $HOME 2>/dev/null | head -n 23) || echo_not_found
	echo ""
fi
