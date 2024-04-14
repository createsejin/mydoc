# check LVM snapshot
lsblk | grep "n1p6" -A 12
# frequently check capacity of snapshot 
# because snapshot will fill origin files when they have been changed.
sudo lvs
sudo lvdisplay | grep "Files/snap" -A 20
# check Free space in Volume Group
sudo vgs
# resize snapshot
sudo lvresize -L +2.8G --resizefs Files/snap_2024-04-01-001

# create snapshot
sudo lvcreate --size 20G --snapshot --name snap_2024-04-14-003 /dev/Files/root

# delete snapshot
sudo lvremove Files/snap_2024-04-01-001

# revert system from snapshot
sudo lvconvert --merge Files/snap_2024-04-12-001

# after merge and reboot, clear origin snapshot
sudo vgscan
sudo vgchange -ay
# and you should make a new snapshot to keep your current system files.
sudo lvcreate ..
