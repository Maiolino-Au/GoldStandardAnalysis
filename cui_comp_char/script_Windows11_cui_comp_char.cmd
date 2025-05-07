@Set "Build=%CD%"
@Echo(%Build%
@If Not Exist "configurationFile_cui_comp_char.txt" Set /P "=%Build%" 0<NUL 1>"configurationFile_cui_comp_char.txt"
mkdir %Build%
copy configurationFile_cui_comp_char.txt %Build%
del %Build%\id_cui_comp_char.txt
docker run --platform linux/amd64 -itv %Build%:/sharedFolder -v /var/run/docker.sock:/var/run/docker.sock --privileged=true --cidfile  %Build%\id_cui_comp_char.txt  -p  8888:8888 cui_comp_char
