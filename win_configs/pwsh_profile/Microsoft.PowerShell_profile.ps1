# 콘솔 입출력 인코딩 UTF-8로 변경
[Console]::InputEncoding = [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
# 기본 인코딩 UTF-8로 설정
$PSDefaultParameterValues['*:Encoding'] = 'utf8'

# oh-my-posh theme 설정
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\catppuccin_frappe.omp.json" | Invoke-Expression

# Import the module
Import-Module Catppuccin

# Alias ls, l invoke eza
function ls_func {
  eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions @args
}
Set-Alias -Name ls -Value ls_func
function l_func {
  eza -A --long --color=always --icons=always --git @args
}
Set-Alias -Name l -Value l_func
function tree_func([int]$level) {
  eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions -T -L $level
}
# Alias tree <level>
Set-Alias -Name tree -Value tree_func

# zoxide script setup
Invoke-Expression (& { (zoxide init powershell | Out-String) })
# zoxide Alias apply to cd
Remove-Alias -Name cd
Set-Alias -Name cd -Value z

# path, rpath Alias setup
Remove-Alias -Name rp -Force
Set-Alias -Name rp -Value Resolve-Path
function Resolve-RelativePath {
  param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$Path
  )
  Resolve-Path -Path $Path -Relative
}
Set-Alias -Name rpr -Value Resolve-RelativePath

# PowerShell parameter completion shim for the dotnet CLI
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
  param($wordToComplete, $commandAst, $cursorPosition)
  dotnet complete --position $cursorPosition "$commandAst" | ForEach-Object {
    [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
  }
}

# make symbolic link command Alias: ln <link_name> <target>
function mk_sym_link([string]$target_path, [string]$link_name) {
  Start-Process -FilePath "wt" -Wait -Verb RunAs -ArgumentList "-d", "$pwd", "pwsh", "-NoExit", "-c", `
    "New-Item -ItemType SymbolicLink -Path `"$link_name`" -Target `"$target_path`""
}
Set-Alias -Name ln -Value mk_sym_link

# set-path to access to the windows environment path setting
Set-Alias -Name set-path -Value "C:\Users\creat\mydoc\scripts\Path.lnk"

# Alias touch for file creating
function mk_file([string]$file_name) {
  New-Item -Path . -Name $file_name -ItemType "file"
}
Set-Alias -Name touch -Value mk_file

# set neovim alias: vim, vimt
function vimt_func {
  nvim -u C:\Users\creat\mydoc\configs\.config\nvimt\init.vim @args
}
Set-Alias -Name vimt -Value vimt_func
function vim_func {
  nvim @args
}
Set-Alias -Name vim -Value vim_func

# unzip compressed archive by bandizip
function band_unzip {
  param(
    [Parameter(Mandatory = $true)]
    [string]$archive,
    [string]$target_dir
  )
  $bz = "C:\Program Files\Bandizip\bz.exe"

  if (-not (Test-Path $archive)) {
    Write-Output "Error: Archive file '$archive' does not exist."
    return
  }

  if ($target_dir -eq "") {
    Write-Output "Target directory not specified, extracting to current directory."
    Start-Process -FilePath "$bz" -Wait -NoNewWindow -WorkingDirectory (Get-Location).Path `
      -ArgumentList "x -aos -y -cp:65001 -target:name -consolemode:utf8 `"$archive`""
    return
  }
  elseif (($target_dir -ne $null) -and -not (Test-Path $target_dir)) {
    Write-Output "Target directory '$target_dir' does not exist. Creating..."
    New-Item -ItemType Directory -Path $target_dir -Force | Out-Null
  }
  elseif (($target_dir -ne $null) -and (Test-Path $target_dir)) {
    Write-Output "Archive extracting to `"$target_dir`""
  }
  Start-Process -FilePath "$bz" -Wait -NoNewWindow -WorkingDirectory (Get-Location).Path `
    -ArgumentList "x -aos -o:`"$target_dir`" -y -cp:65001 -consolemode:utf8 `"$archive`""
}
Set-Alias -Name ban -Value band_unzip

# get command source path
function which_func {
  param(
    [Parameter(Mandatory = $true)]
    [string]$command
  )
  Get-Command -Name $command
}
Set-Alias -Name which -Value which_func

# execute windows file explorer current location
function explorer_func {
  Start-Process -FilePath "C:\Windows\explorer.exe" -ArgumentList "$pwd"
}
Set-Alias -Name ex -Value explorer_func

# clear shell
Set-Alias -Name cl -Value clear

# source $PROFILE
function source_profile {
  . $PROFILE
}
Set-Alias -Name so -Value source_profile

# execute command on administrator powershell
function execute_admin {
  Start-Process -FilePath "wt" -Verb RunAs -Wait -ArgumentList "-d", "$pwd", "pwsh", `
    "-NoExit", "-c $args" 
}
Set-Alias -Name sudo -Value execute_admin

# git command alias
function gst_f {
  git status
}
Set-Alias -Name gst -Value gst_f

function gaa_f {
  git add --all
}
Set-Alias -Name gaa -Value gaa_f

Remove-Alias -Name gl -Force
function gl_f {
  git pull
}
Set-Alias -Name gl -Value gl_f

Remove-Alias -Name gp -Force
function gp_f {
  git push
}
Set-Alias -Name gp -Value gp_f

function gcam_f {
  param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$msg
  )
  git commit --all --message $msg 
}
Set-Alias -Name gcam -Value gcam_f

function glod_f {
  git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset"
}
Set-Alias -Name glod -Value glod_f
function glols_f {
  git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --stat
}
Set-Alias -Name glols -Value glols_f
function glo_f {
  git log --oneline --decorate
}
Set-Alias -Name glo -Value glo_f

Set-Alias -Name dot -Value dotnet