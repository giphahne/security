

local_log_dir=$1

username=${2:-"admin"}
router_ip=${3:-"192.168.1.1"}

# "//mnt/..." isn't a typo, there's
# supposed to be two slashes:
remote_log_dir="//mnt/log"

# use controlmaster in your ~/.ssh/config for now:
# (this is probably better than trying to handle
#  passwords here anyway)
#echo -n "router password: "
#read -s password


echo -e "\nfetching list of log files..."
files=$(ssh ${username}@${router_ip} -C "ls ${remote_log_dir}" 2> /dev/null)
echo -e "\nfiles:\n${files}"


# h=$(echo ${files} | cut -d ' ' -f 1)
# echo "h:"
# echo ${h}
# ssh ${username}@${router_ip} -C "catv ${remote_log_dir}/${h}" > "./${local_log_dir}/${h}" 2>/dev/null;
# echo "fetched: "
# du -kh "./${local_log_dir}/${h}"


echo "\n\nfetched: "
for f in $files;
do
	ssh ${username}@${router_ip} -C "catv ${remote_log_dir}/${f}" > "./${local_log_dir}/${f}" 2>/dev/null;
	ls -lh "./${local_log_dir}/${f}"
done

