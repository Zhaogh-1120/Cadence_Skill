dirPath="~/mySKILL/"
ilFilesName=rexMatchList(".il$" getDirFiles(dirPath) )
ilFilesList=foreach(mapcar x ilFilesName strcat(dirPath x))
foreach(ilFile ilFilesList load(ilFile))

