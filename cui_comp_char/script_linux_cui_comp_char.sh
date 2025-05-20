#
#
if test -f "./configurationFile_cui_comp_char.txt"; then
echo "$FILE exists."
else
pwd > configurationFile_cui_comp_char.txt
fi
tt=$(head configurationFile_cui_comp_char.txt)
mkdir $tt
cp ./configurationFile_cui_comp_char.txt $tt
rm $tt/id_cui_comp_char.txt
docker run --platform linux/amd64 -itv $tt:/sharedFolder -v /var/run/docker.sock:/var/run/docker.sock --cidfile  $tt/id_cui_comp_char.txt --privileged=true -p  8888:8888 cui_comp_char
