# https://gist.github.com/toelen/5221051

#Check if previous build exists and delete it
if [ ! -f $2.flp ]
then
	rm $2.flp
fi

if [ ! -f $2 ]
then
	rm $2
fi

#Compile the sourcecode
nasm -f bin -o $2.bin $1

#Appender
SRC_SIZE=$(stat -c%s "$2.bin")
SIZE=$(expr 1474560 - $SRC_SIZE)
dd bs=$SIZE seek=1 of=nullbytes count=0
cat $2.bin nullbytes > $2.flp
rm ./nullbytes
rm ./"$2.bin"


export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
VBoxManage controlvm test poweroff 
VBoxManage storagectl test --name floppy --remove
VBoxManage storagectl test --add floppy --name floppy --controller I82078 --bootable on
VBoxManage storageattach test --storagectl floppy --port 0 --device 0 --type fdd --medium "$2.flp"
VBoxManage startvm test
