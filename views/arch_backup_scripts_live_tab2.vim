let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
arglocal
%argdel
$argadd /mnt/root/home/bae/Documents/scripts/arch_back/arch_backup.sh
$argadd /mnt/root/home/bae/Documents/scripts/arch_back/test/arch_backup_test.sh
$argadd /mnt/root/home/bae/Documents/scripts/arch_back/arch_restore.sh
$argadd /mnt/root/home/bae/Documents/scripts/arch_back/test/arch_restore_test.sh
$argadd /mnt/root/home/bae/Documents/scripts/arch_back/arch_backup_exc.txt
$argadd /mnt/root/home/bae/Documents/scripts/arch_back/test/find_test.sh
$argadd /mnt/root/home/bae/Documents/scripts/.scripts/copy_config.sh
$argadd /mnt/root/home/bae/Documents/scripts/arch_back/test/test_du.sh
if bufexists(fnamemodify("/mnt/root/home/bae/Documents/scripts/arch_back/test/arch_restore_test.sh", ":p")) | buffer /mnt/root/home/bae/Documents/scripts/arch_back/test/arch_restore_test.sh | else | edit /mnt/root/home/bae/Documents/scripts/arch_back/test/arch_restore_test.sh | endif
if &buftype ==# 'terminal'
  silent file /mnt/root/home/bae/Documents/scripts/arch_back/test/arch_restore_test.sh
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
let s:l = 60 - ((36 * winheight(0) + 28) / 56)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 60
normal! 015|
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
doautoall SessionLoadPost
" vim: set ft=vim :