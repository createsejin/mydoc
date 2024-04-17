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
badd +1 ~/git.txt
badd +117 configs/.zshrc
badd +58 ~/.config/tmux/tmux.conf
badd +16 ~/.config/nvim/init_live
badd +17 ~/.config/nvim/init.vim
badd +1 configs/.oh-my-zsh/themes/xiong-chiamiov-plus.zsh-theme
badd +1 suda:///home/bae/Documents/root_configs/.oh-my-zsh/themes/xiong-chiamiov-plus.zsh-theme
badd +2 root_configs/copy.sh
badd +5 arg-nvim_config
badd +28 scripts/init_live
badd +4 term://~/Documents//2713:/usr/bin/zsh
badd +123 root_configs/.zshrc
badd +5 scripts/du.sh
badd +4 scripts/.scripts/du.sh
badd +0 scripts/.scripts/copy_config.sh
argglobal
%argdel
$argadd ~/git.txt
$argadd configs/.zshrc
$argadd root_configs/.zshrc
$argadd ~/.config/tmux/tmux.conf
$argadd scripts/init_live
$argadd scripts/.scripts/du.sh
$argadd scripts/.scripts/copy_config.sh
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
exe 'vert 1resize ' . ((&columns * 93 + 96) / 192)
exe 'vert 2resize ' . ((&columns * 98 + 96) / 192)
argglobal
2argu
balt root_configs/.zshrc
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
let s:l = 117 - ((30 * winheight(0) + 28) / 57)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 117
normal! 0
lcd ~/Documents
wincmd w
argglobal
7argu
balt ~/Documents/scripts/init_live
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
let s:l = 10 - ((9 * winheight(0) + 28) / 57)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 10
normal! 031|
lcd ~/Documents
wincmd w
2wincmd w
exe 'vert 1resize ' . ((&columns * 93 + 96) / 192)
exe 'vert 2resize ' . ((&columns * 98 + 96) / 192)
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
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
