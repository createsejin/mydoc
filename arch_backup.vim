let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/Documents
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +1 ~/.config/tmux/tmux.conf
badd +30 ~/.config/nvim/init.vim
badd +64 scripts/init_live
badd +5 scripts/.scripts/du.sh
badd +13 scripts/.scripts/copy_config.sh
badd +1 ~/git.txt
badd +104 configs/.zshrc
badd +1 root_configs/.zshrc
badd +17 ~/.config/nvimt/init.vim
badd +6 ~/.gitconfig
badd +30 scripts/arch_back/arch_backup.sh
badd +1 scripts/arch_back/arch_restore.sh
badd +17 scripts/arch_back/arch_backup_exc.txt
badd +12 scripts/arch_back/find_test.sh
badd +2 scripts/arch_back/test_exc.txt
badd +1 ~/.config/nvimt/tmux.conf
badd +1 test4
badd +1 test3
badd +1 test1
argglobal
%argdel
$argadd ~/git.txt
$argadd configs/.zshrc
$argadd root_configs/.zshrc
$argadd ~/.config/tmux/tmux.conf
$argadd ~/.config/nvim/init.vim
set stal=2
tabnew +setlocal\ bufhidden=wipe
tabrewind
edit ~/.config/nvim/init.vim
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 96 + 96) / 192)
exe 'vert 2resize ' . ((&columns * 95 + 96) / 192)
arglocal
%argdel
$argadd ~/git.txt
$argadd ~/Documents/configs/.zshrc
$argadd ~/Documents/root_configs/.zshrc
$argadd ~/.config/tmux/tmux.conf
$argadd ~/.config/nvim/init.vim
5argu
balt ~/.config/tmux/tmux.conf
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
let s:l = 103 - ((34 * winheight(0) + 28) / 56)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 103
normal! 022|
lcd ~/Documents
wincmd w
argglobal
5argu
balt ~/.config/tmux/tmux.conf
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
35,46fold
49,85fold
let &fdl = &fdl
let s:l = 48 - ((31 * winheight(0) + 28) / 56)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 48
normal! 0
lcd ~/Documents
wincmd w
2wincmd w
exe 'vert 1resize ' . ((&columns * 96 + 96) / 192)
exe 'vert 2resize ' . ((&columns * 95 + 96) / 192)
tabnext
edit ~/Documents/scripts/init_live
arglocal
%argdel
$argadd ~/git.txt
$argadd ~/Documents/scripts/init_live
$argadd ~/Documents/scripts/arch_back/arch_backup.sh
$argadd ~/Documents/scripts/arch_back/arch_restore.sh
$argadd ~/Documents/scripts/arch_back/arch_backup_exc.txt
$argadd ~/Documents/scripts/.scripts/du.sh
$argadd ~/Documents/scripts/.scripts/copy_config.sh
$argadd ~/Documents/scripts/arch_back/find_test.sh
$argadd ~/Documents/scripts/arch_back/test_exc.txt
2argu
balt ~/Documents/scripts/arch_back/arch_restore.sh
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
let s:l = 23 - ((22 * winheight(0) + 28) / 56)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 23
normal! 0
lcd ~/Documents
tabnext 1
set stal=1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
let g:this_session = v:this_session
let g:this_obsession = v:this_session
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
