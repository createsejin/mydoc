# check LVM snapshot
lsblk | grep "n1p6" -A 12
# frequently check capacity of snapshot 
# because snapshot will fill origin files when they have been changed.
sudo lvdisplay | grep "Files/snap" -A 20
# check Free space in Volume Group
sudo vgs

# create snapshot
sudo lvcreate --size 5.3G --snapshot --name snap_2024-03-21-003 /dev/Files/root

# delete snapshot
sudo lvremove /dev/Files/snap_2024-03-21-003

# revert system from snapshot
sudo lvconvert --merge /dev/Files/snap_2024-03-21-003

# after merge and reboot, clear origin snapshot
sudo vgscan
sudo vgchange -ay
# and you should make a new snapshot to keep your current system files.
sudo lvcreate ..
