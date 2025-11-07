if [ "$(ls /opt 2>/dev/null)" ]; then
	print_2title "unexpected in /opt "
	ls -la /opt
	echo ""
else
	echo_not_found "opt files"
fi
