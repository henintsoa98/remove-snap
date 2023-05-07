sudo systemctl disable snapd.service
sudo systemctl disable snapd.socket
sudo systemctl disable snapd.seeded.service

NUMBER=$(snap list --all | sed '1d' | wc | awk '{print $1}')
while [ $NUMBER -ne 0 ]
do
        COMMAND=$(snap list --all | sed '1d' |awk '{print $1}' | sed "s#^#sudo snap remove #" | sed "s#\$#;#") 
	eval "$COMMAND"
        NUMBER=$(snap list --all | sed '1d' | wc | awk '{print $1}')
done

sudo apt autoremove --purge snapd
sudo rm -rf /var/cache/snapd/
rm -rf ~/snap
echo "Your system will reboot after 5s, to take effect"
sleep 5
reboot
