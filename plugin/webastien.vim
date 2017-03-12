if exists('vim_tweaks__loaded') | finish | endif | let vim_tweaks__loaded = 1
" ###################################################################################################################################################
" ##  VIm options  ##################################################################################################################################
" ###################################################################################################################################################
if !exists('g:vim_tweaks__default_options_vim') || g:vim_tweaks__default_options_vim != 0
  syntax enable                                                 " Enable syntax highlighting
  set autochdir                                                 " Use relative path from the current file
  set completeopt=menu,preview,longest                          " Omnicompletion settings
  set cursorline                                                " Highlight current line
  set diffopt=filler,vertical                                   " Diff options
  set nobackup | set nowritebackup | set noswapfile             " Prevent temporary files, not really required today
  set encoding=utf-8 | set fileencoding=utf-8                   " Fix characters encoding
  set fileformat=unix                                           " Fix the line breaks
  set hlsearch | set ignorecase | set smartcase | set incsearch " Customize how the search works
  set laststatus=2                                              " Always display status bar
  set number                                                    " Display line number
  set ruler                                                     " Display informations about position
  set scrolloff=50                                              " Keep enought lines around cursor when scrolling to avoid empty screens
  set showcmd                                                   " Display incomplete command (bottom right)
  set splitbelow                                                " Display help and preview window at the bottom
  set statusline=%<%w%F\ %h%m%r%=%-10.(%l,%c%V\ \[%P\]%)        " Customize statusline to display full filepath
  set wildignorecase                                            " Make filename completion ignore case
  set wildmenu | set wildmode=longest,list                      " Customize command completion
  set tw=170 | set wrap | set linebreak | set display=lastline  " Wrap long lines, no words cut, display its begin when everything cannot be displayed
  set viminfo='10,\"100,:20,%,n~/.viminfo                       " VIm informations file
  set shiftwidth=2 | set tabstop=2 | set softtabstop=2 | set backspace=2 | set expandtab | set autoindent | set smartindent " Never tabs but 2 spaces
  set suffixes+=.jpg,.png,.jpeg,.gif,.svg,.swo,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.pyc,.pyo,.exe " Low priority files
  let &wildignore=substitute(&suffixes,'\.','*.','g')           " Ignore low priority files in word search
endif

" ###################################################################################################################################################
" ##  Plugins options  ##############################################################################################################################
" ###################################################################################################################################################
if !exists('g:vim_tweaks__default_options_plugins') || g:vim_tweaks__default_options_plugins != 0
  let g:syntastic_auto_loc_list=1                                                                                                       " Syntastic
  let NERDSpaceDelims=1                                                                                                                 " NERDcommenter
  let g:phpcomplete_mappings={ 'jump_to_def': '<C-G>' }                                                                                 " PHPComplete
  let g:AutoPreview_enabled=0 | set previewheight=1 | set updatetime=999 | let g:AutoPreview_allowed_filetypes=['php','java','c','cpp'] " Autopreview
  let g:tagbar_compact=1 | let g:tagbar_autofocus=1 | let g:tagbar_close=1 | let g:tagbar_map_togglefold=['o','za','<Space>']           " Tagbar
  let g:user_emmet_leader_key='<C-H>' | let g:user_emmet_togglecomment_key='<C-H>h'                                                     " Emmet
  let g:vim_tweaks__vimrc_url='https://raw.githubusercontent.com/webastien/vim/master/.vimrc'                                           " vim-tweaks
endif

if !exists('g:vim_tweaks__filetypes')
  let g:vim_tweaks__filetypes = {
    \  'dosini': [ '*.info', '*.ini' ],
    \  'php':    [ '*.php', '*.inc', '*.module', '*.theme', '*.install', '*.engine', '*.profile', '*.view', '*.test' ]
    \ }
endif

if !exists('g:vim_ctags__args')
  let g:vim_ctags__args = {
    \  'php': '--langmap=php:.php.inc.module.theme.install.engine.profile.view --php-kinds=cdfi --fields=+aimlS'
    \}
endif

" ###################################################################################################################################################
" ##  Autocommands  #################################################################################################################################
" ###################################################################################################################################################
if !exists('g:vim_tweaks__default_autocommands') || g:vim_tweaks__default_autocommands != 0
  au BufWritePre * :%s/\s\+$//e         " Always remove trailing whitespace on save
  au BufReadPost * :call LastPosition() " Apply last editing position, unfold if necessary and center the screen aroung the cursor
  " Adjust filetype for known extensions
  for customfiletype in keys(g:vim_tweaks__filetypes)
    exec 'au BufRead,BufNewFile '. join(g:vim_tweaks__filetypes[customfiletype], ',') .' set filetype='. customfiletype
  endfor
  " Auto-close quick fix buffer if it's the last buffer in a tab (useful with word search feature)
  aug QFClose " @see http://stackoverflow.com/questions/7476126/how-to-automatically-close-the-quick-fix-window-when-leaving-a-file
    au!
    au WinEnter * if winnr('$') == 1 && getbufvar(winbufnr(winnr()), "&buftype") == "quickfix" | q | endif
  aug END
  " Auto-close current window if in diff mode and the other part has been close
  au WinEnter * if &diff && winnr('$') == 1 | q | endif
  " Fix Autopreview plugin hard coded (and repeated...) highlight
  au BufLeave * if &previewwindow | hi previewWord ctermbg=NONE | endif
endif

" ###################################################################################################################################################
" ##  Custom functions  #############################################################################################################################
" ###################################################################################################################################################
" Replace the cursor on the last position in the file
function LastPosition()
  if line("'\"") > 0 && line("'\"") <= line("$") | exe "norm '\"zvzz" | endif
endfunction
" Toggle start of line / first nonblank character of the line
function SmartHome()
  let s:col  = col(".") | normal! ^
  if  s:col == col(".") | normal! 0
  endif
endfunction
" Search a word (the one under the cursor by default) in the given directory, recursively
function WordSearch()
  call inputsave() | let w = input('Word: ', expand("<cword>")) | call inputrestore() | if w == ''                    | return | endif
  call inputsave() | let d = input('Dir: ',  getcwd(), 'dir')   | call inputrestore() | if d == '' || !isdirectory(d) | return | endif
  redraw | echohl Search | echo 'Searching "'. w .'" in "'. d .'"...' | echohl None
  if !getwinvar(1, "pendingWordSearch") | exec "tabnew" | endif
  silent exec "noautocmd vimgrep /". w ."/ ". fnamemodify(d, ':p') ."**/*.*" | exec "copen"
  exec 'setlocal statusline=%#Search#\ \ %L\ results\ for\ «\ '. w .'\ »%=(into\ '. d .')\ \ %*'| exec "cfirst" | exec "norm zv"
  exec setwinvar(1, "pendingWordSearch", 1)
endfunction
" Execute tabularize with auto-detected parameters (Tabular plugin)
function TabAuto()
  let l = getline('.') | let p = stridx(l, '=') | if p == -1 || p < stridx(l, ':') | exec "Tabularize /:\\zs/l0r1" | else | exec "Tabularize /=" | endif
endfunction
" Helper function for my command abbreviations
function CommandAbbreviation(original, abbreviation)
  return (getcmdtype() == ':' && getcmdpos() == 1)? a:abbreviation : a:original
endfunction
" Helper function to remove the trailing space of an abbreviation, @see :help abbreviations (Eatchar function)
function AbbrebiationRemoveTrailingSpace()
  let c = nr2char(getchar(0)) | return (c =~ '\s')? '' : c
endfunction
" Update the .vimrc file with the one downloadable by given URL
function UpdateVimrc(...)
  if !exists('g:vim_tweaks__vimrc_url') | let g:vim_tweaks__vimrc_url='' | endif
  if a:0 > 0 | let vimrcfile = expand('~/.vimrc') | let tempfile = expand('/tmp/downloaded-vimrc')
    let test = empty(glob(vimrcfile))? system('touch '. vimrcfile .' && rm '. vimrcfile) : !filewritable(vimrcfile)
    if (test == 1 || test != '') | echohl ErrorMsg | echo '"'. vimrcfile.'" is not writable!' | echohl None | return | endif
    echohl Search | echo 'Downloading vimrc from '. a:1 .' to '. tempfile .'...' | echohl None
    silent exec system('curl -s "'. a:1 .'" -o '. tempfile) | redraw
    if !filereadable(tempfile) | echohl ErrorMsg | echo 'Cannot download the new vimrc...' | echohl None | return | endif
    let originalPreviewHeight = &previewheight | let &previewheight = 20 | silent exec 'pedit '. tempfile | let &previewheight = originalPreviewHeight
    redraw | let confirm = input('Do you want to replace your vimrc with the new one? (type "y" to confirm) ') | redraw
    if confirm == 'y' | silent exec system('cp '. tempfile .' '. vimrcfile) | echo "done." | silent exec 'source '. vimrcfile | else | echo "canceled." | endif | pclose
  else
    call inputsave() | let url = input('vimrc URL: ', g:vim_tweaks__vimrc_url) | call inputrestore() | if url == '' | return | endif
    redraw | call UpdateVimrc(url)
  endif
endfunction

" ###################################################################################################################################################
" ##  Custom abbreviations  /!\ Remember: Never add comments on an abbreviation line!  ##############################################################
" ###################################################################################################################################################
if !exists('g:vim_tweaks__default_abbreviations') || g:vim_tweaks__default_abbreviations != 0
  " Open VIm help in a new tab if the current file is not a VIm help
  ca h <C-R>=CommandAbbreviation('h', (&ft == 'help')? 'h' : 'tab h')<CR>
  " Prefill the edit command with the full current path (reduced if in home)
  ca e <C-R>=CommandAbbreviation('e', 'e '. fnamemodify(getcwd(), ':p:~'))<CR><C-R>=AbbrebiationRemoveTrailingSpace()<CR>
endif

" ###################################################################################################################################################
" ##  Custom commands  ##############################################################################################################################
" ###################################################################################################################################################
" Update the .vimrc file with the one downloadable by given URL
com! -nargs=0 UpdateVimrc call UpdateVimrc()

" ###################################################################################################################################################
" ##  Custom keyboard mappings  /!\ Remember: Never add comments on a mapping line!  ################################################################
" ###################################################################################################################################################
if !exists('g:vim_tweaks__default_mapping') || g:vim_tweaks__default_mapping != 0
  " Map a custom handler on Home key to toggle start of line / first nonblank character
  nnoremap <silent> <Home> :call SmartHome()<CR>
  " Remap the "à" key to work as "0" on qwerty keyboards ("à" and "0" share the same key on french keyboards...)
  map à <Home>
  " Map nohlsearch on semicolon
  map <silent> ; :noh<CR>
  " Page Up / Down and Begin / End of line
  map <S-K> <PageUp>
  map <S-J> <PageDown>
  map <S-H> <Home>
  map <S-L> $
  " Swap current line with the previous/next one
  noremap <silent> <C-K> :m .-2<CR>
  noremap <silent> <C-J> :m .+1<CR>
  " Buffers navigation
  nnoremap <Up>   <C-W><S-W>
  nnoremap <Down> <C-W>w
  " Tabs navigation
  map <silent> <C-T>   :tabnew<CR>
  map <silent> <C-W>   :tabclose<CR>
  map <silent> <Left>  :tabprevious<CR>
  map <silent> <Right> :tabnext<CR>
  " Keep the current text in memory when being pasted
  vnoremap p "_dP
  " Map quick return last editing position
  map <S-q> '.
  " Map fold state toggle on space bar
  noremap  <Space> za
  " Omnicompletion with CTRL-Space (insert mode) @see http://stackoverflow.com/questions/7722177/how-do-i-map-ctrl-x-ctrl-o-to-ctrl-space-in-terminal-vim
  inoremap <C-@> <C-X><C-O>
  " Map indentation on Tab key, reverse to Shift-Tab (for single lines and blocks)
  noremap  <Tab>   >>
  noremap  <S-Tab> <<
  inoremap <S-Tab> <C-O><<
  vnoremap <Tab>   >gv
  vnoremap <S-Tab> <gv
  " [ PLUGIN Autopreview ] Map preview toggle on F2
  nnoremap <silent> <F2> :AutoPreviewToggle<CR>
  " [ PLUGIN Nerd commenter ] Remap toggle on Shift-C
  map <S-C> <leader>c<space>
  " [ PLUGIN Tagbar ] Map visibility toggle on F8
  nmap <silent> <F8> :TagbarToggle<CR>
  " [ PLUGIN Tabular / VIm-tweaks ] Use my custom function for tabularization, without manually give parameters
  map <silent> + :call TabAuto()<CR>
  " [ PLUGIN VIm-tweaks ] WordSearch function mappings
  nnoremap <silent> <C-F> :call WordSearch()<CR>
  nnoremap <silent> <F6>  :cprevious<CR>zv
  nnoremap <silent> <F7>  :cnext<CR>zv
  " [ PLUGIN VIm-ctags ] Ctags build index and jump to definition mappings
  map      <silent> <F3> :call DisplayTag()<CR>
  map      <silent> <F4> :call DisplayGivenTag()<CR>
  nnoremap <silent> <F5> :call RebuildTags()<CR>
  " [ TO IMPROVE THE COLORS SETTINGS ] Get the highligh group of the element under the cursor
  map <F10> :echo synIDattr(synID(line("."),col("."),1),"name")<CR>
endif

