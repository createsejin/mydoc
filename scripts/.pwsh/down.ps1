$commander = "C:\Users\creat\Projects\the_cave\tests\downloader_test02\Commander\bin\Debug\net8.0\Commander.exe"
$controller = "C:\Users\creat\Projects\the_cave\tests\downloader_test02\Controller\bin\Debug\net8.0\Controller.exe"

if ($args[0] -eq "cmd") {
  Start-Process -FilePath $commander
} elseif ($args[0] -eq "ctrl") {
  Start-Process -FilePath $controller
} else {
  Start-Process -FilePath $controller
  Start-Process -FilePath $commander
}