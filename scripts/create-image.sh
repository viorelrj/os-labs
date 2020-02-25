# https://gist.github.com/toelen/5221051

SRC_SIZE=$(stat -c%s "$1")
SIZE=$(expr 1474560 - $SRC_SIZE)
dd bs=$SIZE seek=1 of=nullbytes count=0
cat $1 nullbytes > $1.flp
rm ./nullbytes

export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"

VBoxManage storagectl test --name floppy --remove
VBoxManage storagectl test --add floppy --name floppy --controller I82078 --bootable on
VBoxManage storageattach test --storagectl floppy --port 0 --device 0 --type fdd --medium "$1.flp"
VBoxManage startvm test