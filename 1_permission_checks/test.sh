echo -e "/etc/a/file1\n/etc/a/file2\n/etc/a/file3\n/etc/a/file4\n/etc/a/file5\n/etc/a/file6\n/etc/b/file1" | \
awk -F/ '{
    dir=$0; 
    sub(/\/[^\/]+$/, "", dir);  
    count[dir]++
    if (count[dir] <= 5) print $0
    else if (count[dir] == 6) print "# More in: " dir
}'