$commander = "C:\Users\creat\Projects\the_cave\tests\downloader_test02\Commander\bin\Debug\net8.0\Commander.exe"
$controller = "C:\Users\creat\Projects\the_cave\tests\downloader_test02\Controller\bin\Debug\net8.0\Controller.exe"
$searcher = "C:\Users\creat\Projects\the_cave\tests\downloader_test02\Searcher\bin\Debug\net8.0\Searcher.exe"

if ($args[0] -eq "cmd") {
  Start-Process -FilePath $commander
} elseif ($args[0] -eq "ctrl") {
  Start-Process -FilePath $controller
} elseif (($args[0] -eq "sear") -or ($args[0] -eq "searcher")) {
  Start-Process -FilePath $searcher
} else {
  Start-Process -FilePath $controller
  Start-Process -FilePath $commander
}