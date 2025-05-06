@Set "Build=%CD%"
@Echo(%Build%
@If Not Exist "configurationFile_pashos_h3k36.txt" Set /P "=%Build%" 0<NUL 1>"configurationFile_pashos_h3k36.txt"
mkdir %Build%
copy configurationFile_pashos_h3k36.txt %Build%
del %Build%\id_pashos_h3k36.txt
docker run --platform linux/amd64 -itv %Build%:/sharedFolder -v /var/run/docker.sock:/var/run/docker.sock --privileged=true --cidfile  %Build%\id_pashos_h3k36.txt  -p  8888:8888 pashos_h3k36

