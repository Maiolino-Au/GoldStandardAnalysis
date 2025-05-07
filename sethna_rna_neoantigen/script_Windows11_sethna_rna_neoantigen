@Set "Build=%CD%"
@Echo(%Build%
@If Not Exist "configurationFile_sethna_rna_neoantigen.txt" Set /P "=%Build%" 0<NUL 1>"configurationFile_sethna_rna_neoantigen.txt"
mkdir %Build%
copy configurationFile_sethna_rna_neoantigen.txt %Build%
del %Build%\id_sethna_rna_neoantigen.txt
docker run --platform linux/amd64 -itv %Build%:/sharedFolder -v /var/run/docker.sock:/var/run/docker.sock --privileged=true --cidfile  %Build%\id_sethna_rna_neoantigen.txt  -p  8888:8888 sethna_rna_neoantigen
