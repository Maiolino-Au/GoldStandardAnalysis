@Set "Build=%CD%"
@Echo(%Build%
@If Not Exist "configurationFile_wurth_circulation_tumor.txt" Set /P "=%Build%" 0<NUL 1>"configurationFile_wurth_circulation_tumor.txt"
mkdir %Build%
copy configurationFile_wurth_circulation_tumor.txt %Build%
del %Build%\id_wurth_circulation_tumor.txt
docker run --platform linux/amd64 -itv %Build%:/sharedFolder -v /var/run/docker.sock:/var/run/docker.sock --privileged=true --cidfile  %Build%\id_wurth_circulation_tumor.txt  -p  8888:8888 wurth_circulation_tumor
