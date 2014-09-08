gem list | gawk '{print "gem uninstall " $1}' > ~/tmp/uninstall_gems.s
cd ~/tmp
source uninstall_gems.s
rm -i uninstall_gems.s

