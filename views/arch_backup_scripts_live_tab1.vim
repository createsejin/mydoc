let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
arglocal
%argdel
$argadd /mnt/root/home/bae/Documents/git.txt
$argadd /mnt/root/home/bae/Documents/scripts/init_live
$argadd /mnt/root/home/bae/Documents/scripts/arch_back/arch_backup.sh
$argadd /mnt/root/home/bae/Documents/scripts/arch_back/arch_restore.sh
$argadd /mnt/root/home/bae/Documents/scripts/arch_back/arch_backup_exc.txt
$argadd /mnt/root/home/bae/Documents/scripts/arch_back/test/find_test.sh
$argadd /mnt/root/home/bae/Documents/scripts/.scripts/copy_config.sh
$argadd /mnt/root/home/bae/Documents/scripts/.scripts/du.sh
if bufexists(fnamemodify("/mnt/root/home/bae/Documents/scripts/init_live", ":p")) | buffer /mnt/root/home/bae/Documents/scripts/init_live | else | edit /mnt/root/home/bae/Documents/scripts/init_live | endif
if &buftype ==# 'terminal'
  silent file /mnt/root/home/bae/Documents/scripts/init_live
endif
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 31 - ((24 * winheight(0) + 28) / 56)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 31
normal! 0
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
doautoall SessionLoadPost
" vim: set ft=vim :
