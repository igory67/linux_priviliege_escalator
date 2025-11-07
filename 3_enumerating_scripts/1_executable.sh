print_2title "Executable files from user (up to 70)"
find / -type f -executable -printf "%T + %p\n" 2>/dev/null |
#grep -E -v "000|/site-packages|/python|/node_modules|\.sample|/gems|/cgroup|/dpkg|/selftests|/shell" \
grep -E -v $notexec \
| sort -r \
| head -n 70
echo ""
# "000|/site-packages|/python
# "000|/site-packages|/python1
