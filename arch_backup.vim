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
badd +34 ~/.config/nvim/init.vim
badd +1 scripts/init_live
badd +4 scripts/.scripts/du.sh
badd +14 scripts/.scripts/copy_config.sh
badd +1 ~/git.txt
badd +121 configs/.zshrc
badd +105 root_configs/.zshrc
badd +17 ~/.config/nvimt/init.vim
badd +6 ~/.gitconfig
badd +28 scripts/arch_back/arch_backup.sh
badd +1 scripts/arch_back/arch_restore.sh
badd +10 scripts/arch_back/arch_backup_exc.txt
badd +12 scripts/arch_back/find_test.sh
badd +2 scripts/arch_back/test_exc.txt
badd +1 ~/.config/nvimt/tmux.conf
badd +1 test4
badd +1 test3
badd +1 test1
badd +5 scripts/.scripts/du_exc.txt
badd +99 ~/.config/nvim/.zshrc
badd +0 global
argglobal
%argdel
$argadd ~/git.txt
$argadd configs/.zshrc
$argadd root_configs/.zshrc
$argadd ~/.config/tmux/tmux.conf
$argadd ~/.config/nvim/init.vim
$argadd global
set stal=2
tabnew +setlocal\ bufhidden=wipe
tabnew +setlocal\ bufhidden=wipe
tabrewind
edit configs/.zshrc
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
$argadd ~/.config/nvim/.zshrc
$argadd ~/Documents/root_configs/.zshrc
$argadd ~/.config/tmux/tmux.conf
$argadd ~/.config/nvim/init.vim
2argu
balt ~/.config/nvim/.zshrc
setlocal fdm=diff
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
137
normal! zo
let s:l = 115 - ((114 * winheight(0) + 28) / 56)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 115
normal! 0
lcd ~/Documents
wincmd w
arglocal
%argdel
$argadd ~/git.txt
$argadd ~/Documents/configs/.zshrc
$argadd ~/.config/nvim/.zshrc
$argadd ~/Documents/root_configs/.zshrc
$argadd ~/.config/tmux/tmux.conf
$argadd ~/.config/nvim/init.vim
3argu
balt ~/Documents/configs/.zshrc
setlocal fdm=diff
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
132
normal! zo
let s:l = 115 - ((114 * winheight(0) + 28) / 56)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 115
normal! 0
lcd ~/Documents
wincmd w
exe 'vert 1resize ' . ((&columns * 96 + 96) / 192)
exe 'vert 2resize ' . ((&columns * 95 + 96) / 192)
tabnext
edit ~/Documents/scripts/init_live
arglocal
%argdel
$argadd ~/git.txt
$argadd scripts/init_live
$argadd scripts/arch_back/arch_backup.sh
$argadd scripts/arch_back/arch_restore.sh
$argadd scripts/arch_back/arch_backup_exc.txt
$argadd scripts/.scripts/du.sh
$argadd scripts/.scripts/du_exc.txt
$argadd scripts/.scripts/copy_config.sh
$argadd scripts/arch_back/find_test.sh
$argadd scripts/arch_back/test_exc.txt
1argu
if bufexists(fnamemodify("~/Documents/scripts/init_live", ":p")) | buffer ~/Documents/scripts/init_live | else | edit ~/Documents/scripts/init_live | endif
if &buftype ==# 'terminal'
  silent file ~/Documents/scripts/init_live
endif
balt ~/Documents/scripts/.scripts/copy_config.sh
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
let s:l = 79 - ((47 * winheight(0) + 28) / 56)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 79
normal! 037|
tabnext
edit ~/git.txt
argglobal
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
let s:l = 1 - ((0 * winheight(0) + 28) / 56)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
lcd ~/Documents
tabnext 2
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
