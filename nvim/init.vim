set encoding=utf-8 " default character encoding

" Set leader keys before anything else
let mapleader      = "\<SPACE>"
let maplocalleader = ','

let g:polyglot_disabled = ['elm', 'markdown']

filetype off
call plug#begin('~/.config/nvim/plugged')
Plug 'janko/vim-test'

Plug 'airblade/vim-rooter'
Plug 'wakatime/vim-wakatime'

" Plug 'mhartington/oceanic-next'
" Plug 'glepnir/oceanic-material'
" Plug 'sainnhe/forest-night'

Plug 'sainnhe/gruvbox-material'
Plug 'romainl/vim-cool'

Plug 'Yggdroot/indentLine'
Plug 'pedrohdz/vim-yaml-folds'

Plug 'vim-scripts/SQLComplete.vim'

Plug 'scrooloose/nerdtree'

Plug 'mattn/emmet-vim'

Plug 'elmcast/elm-vim'

Plug 'rust-lang/rust.vim'
Plug 'sheerun/vim-polyglot'

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-abolish'

Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-dispatch'
Plug 'easymotion/vim-easymotion'

Plug 'radenling/vim-dispatch-neovim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'jceb/vim-orgmode'
Plug 'mildred/vim-bufmru'

Plug 'mhinz/vim-startify'

Plug 'airblade/vim-gitgutter'

Plug 'https://github.com/gilacost/ale.git', { 'branch': 'allow-erlfmt-as-fixer' }
" Plug '~/Repos/ale'

Plug 'gcmt/taboo.vim'

Plug 'hashivim/vim-terraform'

Plug 'neoclide/coc.nvim', { 'branch': 'release' }

Plug 'hyhugh/coc-erlang_ls', {'do': 'yarn install --frozen-lockfile'}

Plug 'elixir-lsp/coc-elixir', {'do': 'yarn install && yarn prepack'}
Plug 'elixir-editors/vim-elixir'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim' " Fuzzy Search
call plug#end()

"""""""""""""""""""""" GENERAL""""""""""""""""""""""""""""""""
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1

  set mouse=""

  set hidden
  set undofile
  set undodir=$HOME/.vim/undo

  set undolevels=1000
  set undoreload=10000

  set lazyredraw
  set synmaxcol=128
  syntax sync minlines=256

  set clipboard+=unnamed,unnamedplus
  set number

  set shiftwidth=2
  set shiftround
  set smarttab
  set autoindent
  set copyindent
  set smartindent
  set colorcolumn=60,80,100,120
  set tabstop=2
  set softtabstop=2
  set expandtab
  set shiftwidth=2
  set hlsearch
  set incsearch
  set ignorecase
  set smartcase
  set cursorline

  set title
  set synmaxcol=150

  set lazyredraw
  set ttyfast
  set regexpengine=1

  set splitbelow
  set splitright

  syntax enable


  let g:python3_host_prog = '/usr/local/bin/python3'

  let $NVIM_TUI_ENABLE_TRUE_COLOR=1

  if has('termguicolors')
    set termguicolors
  endif
  let g:gruvbox_material_background = 'medium'
  let g:gruvbox_material_enable_italic = 1
  let g:gruvbox_material_disable_italic_comment = 0
  " colorscheme OceanicNext
  " set background=dark
  colorscheme gruvbox-material

  set spell spelllang=en_gb

  set noswapfile

  autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
  autocmd InsertLeave * if pumvisible() == 0|pclose|endif

  autocmd BufRead,BufNewFile *.json.mustache set filetype=json.mustache

  autocmd FileType gitcommit set bufhidden=delete
  autocmd FileType markdown setlocal spell wrap textwidth=80

  let g:user_emmet_install_global = 0
  autocmd FileType html,css EmmetInstall

  function! LinterStatus() abort
      let l:counts = ale#statusline#Count(bufnr('%'))

      let l:all_errors = l:counts.error + l:counts.style_error
      let l:all_non_errors = l:counts.total - l:all_errors

      return l:counts.total == 0 ? 'OK' : printf(
      \   '%dW %dE',
      \   all_non_errors,
      \   all_errors
      \)
  endfunction
" Rename current file
  function! RenameFile()
      let old_name = expand('%')
      let new_name = input('New file name: ', expand('%'), 'file')
      if new_name != '' && new_name != old_name
          exec ':saveas ' . new_name
          exec ':silent !rm ' . old_name
          redraw!
      endif
  endfunction
" terminal in insert mode
  if has('nvim')
      autocmd TermOpen term://* startinsert
  endif

  highlight ExtraWhitespace ctermbg=red guibg=red
  au ColorScheme * highlight ExtraWhitespace guibg=red
  au BufEnter * match ExtraWhitespace /\s\+$/
  au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  au InsertLeave * match ExtraWhiteSpace /\s\+$/

"""""""""""""""""""""" PLUGINS """"""""""""""""""""""""""""""""
" ALE
  augroup elixir
    nnoremap <leader>ef :! elixir %<CR>
    autocmd FileType elixir nnoremap <C-]> :ALEGoToDefinitionInVSplit<CR>
    autocmd FileType elixir nnoremap <C-d> :ALEHover<CR>
  augroup END
  nmap <silent> <C-n> <Plug>(ale_previous_wrap)
  nmap <silent> <C-b> <Plug>(ale_next_wrap)

" FZF
  let g:fzf_preview_window = 'right:60%'

" RIPGREP
  let g:rg_binary = '/usr/local/bin/rg'

" startyify
  let g:startify_change_to_vcs_root = 1

" vim-jsx
  let g:jsx_ext_required = 0

  let g:ale_linters = {
  \   'elixir': [],
  \   'erlang': [],
  \   'ansible': ['ansible-lint'],
  \   'dockerfile': ['hadolint'],
  \   'terraform': ['tflint'],
  \   'yaml': ['yamllint'],
  \   'yml': ['yamllint'],
  \   'json': ['prettier'],
  \   'css': ['prettier'],
  \   'scss': ['prettier'],
  \   'html': ['tidy', 'prettier'],
  \   'javascript': ['prettier'],
  \   'typescript': ['tsserver', 'tslint'],
  \}

   let g:ale_fixers = {
   \   '*': ['remove_trailing_lines', 'trim_whitespace'],
   \   'html': ['prettier'],
   \   'elixir': ['mix_format'],
   \   'erlang': ['erl_fmt'],
   \   'elm': ['format'],
   \   'rust': ['rustfmt'],
   \   'terraform': ['terraform'],
   \   'yaml': ['prettier'],
   \   'yml': ['prettier'],
   \   'json': ['prettier'],
   \   'css': ['prettier'],
   \   'scss': ['prettier'],
   \   'javascript': ['prettier'],
   \   'typescript': ['prettier'],
   \}
"
" GitGutter
"
  let g:gitgutter_eager = 1    " runs diffs on buffer switch
  let g:gitgutter_enabled = 1  " enables gitgutter (hunks only)
  let g:gitgutter_realtime = 1 " runs diffs when stop writting
  let g:gitgutter_signs = 1    " shows signs on the gutter
  let g:gitgutter_sign_added = '·'
  let g:gitgutter_sign_modified = '·'
  let g:gitgutter_sign_removed = '·'
  let g:gitgutter_sign_removed_first_line = '·'
  let g:gitgutter_sign_modified_removed = '·'
  noremap <Leader>hn :GitGutterNextHunk<CR>
  noremap <Leader>hp :GitGutterPrevHunk<CR>
  noremap <Leader>hs :GitGutterStageHunk<CR>
  noremap <Leader>hu :GitGutterUndoHunk<CR>
"""""""""""""""""""""""" YAML """"""""""""""""""""""""""""""""""""""
" za: Toggle current fold
" zR: Expand all folds
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
let g:indentLine_char = '⦙'
set foldlevelstart=20
"""""""""""""""""""""""" YAML """"""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""" COC """"""""""""""""""""""""""""""""""""""
autocmd FileType elixir let b:coc_root_patterns = ['mix.exs']
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has('patch-8.1.1564')
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" ALE - Asynchronous Linting Engine
  let g:ale_fix_on_save = 1
  let g:ale_sign_column_always = 1
  let g:ale_lint_on_text_changed = 'always'
  let g:ale_sign_error = 'E'
  let g:ale_sign_warning = 'W'

  let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
  let g:ale_elixir_elixir_ls_release = $HOME.'/Repos/elixir-ls/release'

" Write this in your vimrc file
  let g:ale_set_loclist = 0
  let g:ale_set_quickfix = 1

" vim-javascript
  let g:javascript_plugin_jsdoc = 1
  let g:javascript_plugin_flow = 1

" Elm Cast
  let g:elm_detailed_complete = 1
  let g:elm_format_autosave = 1

" Ultisnips
  let g:UltiSnipsSnippetsDir = $HOME.'/.config/nvim/snips'
  let g:UltiSnipsSnippetDirectories = ['snips', 'priv_snips', 'UltiSnips' ]
  let g:UltiSnipsEditSplit = 'vertical'

" Show those languages with syntax highliting inside Markdown
  let g:vim_markdown_folding_level = 2

" le test
  let test#strategy = 'neovim'

" FZF override
function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout!' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
  \ 'source': s:list_buffers(),
  \ 'sink*': { lines -> s:delete_buffers(lines) },
  \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
\ }))
"""""""""""""""""""""" KEYS """"""""""""""""""""""""""""""""

" Support nested vim
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-v><Esc> <Esc>

" Fuzzy Finder (review)
  noremap <leader>sc :Rg<CR>
  noremap <C-p> :Files<CR>
  noremap <C-o> :Buffers<CR>
  noremap <Leader>i :BD<CR>
  noremap <C-c> :bd!<CR>
  noremap <Leader>sg :GitFiles<CR>

" Edit and reload vimrc
  nnoremap <leader>ve :edit $MYVIMRC<CR>
  nnoremap <leader>vr :source $MYVIMRC<CR>

" Errors list
  nnoremap <leader>lo :ALEDetail<CR>
  nnoremap <leader>ln :ALENext<CR>

" quick list and location list
  nnoremap <leader>qo :copen<CR>
  nnoremap <leader>qc :cclose<CR>

" Exit vim
  nnoremap <silent><leader>qq :qall<CR>

" Rename File
  map <leader>n :call RenameFile()<cr>

" Terminal emulation
  augroup terminal
  autocmd TermOpen * setlocal nospell
  autocmd TermOpen * setlocal nonumber
  autocmd TermOpen * setlocal scrollback=1000
  augroup END
  noremap <leader>zz :terminal<CR>
  noremap <leader>zv :vnew<CR>:terminal<CR>
  noremap <leader>zvm :vnew<CR>:terminal iex -S mix<CR>
  noremap <leader>zh :new<CR>:terminal<CR>
  noremap <leader>zhm :new<CR>:terminal iex -S mix<CR>
  tnoremap <Esc> <C-\><C-n>

" Show undo list
" nnoremap <leader>u :GundoToggle<CR>

" Tabs
  noremap <silent> nt :tabnew<CR>:terminal<CR>
  noremap <M-Left> gT
  noremap <M-Right> gt

" splits
  nnoremap <C-J> <C-W><C-J>
  nnoremap <C-K> <C-W><C-K>
  nnoremap <C-L> <C-W><C-L>
  nnoremap <C-H> <C-W><C-H>

" resizing
  nnoremap <C-n> <C-w>\|<C-w>_
  nnoremap <C-b> <C-w>=
"Max out the height of the current split
" ctrl + w _
"Max out the width of the current split
" ctrl + w |
"Normalize all split sizes, which is very handy when resizing terminal
" ctrl + w =

" Easy Motion
  map <Leader>f <Plug>(easymotion-bd-f)
  map <Leader>j <Plug>(easymotion-j)
  map <Leader>k <Plug>(easymotion-k)
  nmap s <Plug>(easymotion-s2)

  let g:EasyMotion_use_smartsign_us = 1
  let g:EasyMotion_smartcase = 1

  map  / <Plug>(easymotion-sn)
  omap / <Plug>(easymotion-tn)

" le replacer hack
  :nnoremap <Leader>r :%s/\<<C-r><C-w>\>/

" le test
  nmap <silent> t<C-n> :TestNearest<CR>
  nmap <silent> t<C-f> :TestFile<CR>
  nmap <silent> t<C-s> :TestSuite<CR>
  nmap <silent> t<C-l> :TestLast<CR>
  nmap <silent> t<C-g> :TestVisit<CR>

" le buffers
" Tab and Shift-Tab in normal mode to navigate buffers
  map <Tab> :BufMRUNext<CR>
  map <S-Tab> :BufMRUPrev<CR>

" Current directory
  nnoremap <leader>cd :cd %:p:h<CR>:pwd<CR>

"""""""""""""""""""""" STATUSLINE """"""""""""""""""""""""""""""""
      \
  let g:airline_theme='gruvbox_material'
  let g:airline#extensions#ale#enabled = 1
  let g:airline#extensions#tabline#enabled = 1
  let g:airline_powerline_fonts = 1
  let g:airline_section_b = '%{strftime("%c")}'
  let g:airline_section_y = 'BN: %{bufnr("%")}'
  let g:airline_section_x = '%{FugitiveStatusline()}'
  let g:airline_section_c = '%{LinterStatus()}'

"""""""""""""""""""""" PROJECTIONS """"""""""""""""""""""""""""""""

  let g:projectionist_heuristics = {
      \  'mix.exs': {
      \     'lib/**/views/*_view.ex': {
      \       'type': 'view',
      \       'alternate': 'test/{dirname}/views/{basename}_view_test.exs',
      \       'template': [
      \         'defmodule {dirname|camelcase|capitalize}.{basename|camelcase|capitalize}View do',
      \         '  use {dirname|camelcase|capitalize}, :view',
      \         'end'
      \       ]
      \     },
      \     'test/**/views/*_view_test.exs': {
      \       'alternate': 'lib/{dirname}/views/{basename}_view.ex',
      \       'type': 'test',
      \       'template': [
      \         'defmodule {dirname|camelcase|capitalize}.{basename|camelcase|capitalize}ViewTest do',
      \         '  use ExUnit.Case, async: true',
      \         '',
      \         '  alias {dirname|camelcase|capitalize}.{basename|camelcase|capitalize}View',
      \         'end'
      \       ]
      \     },
      \     'lib/**/controllers/*_controller.ex': {
      \       'type': 'controller',
      \       'alternate': 'test/{dirname}/controllers/{basename}_controller_test.exs',
      \       'template': [
      \         'defmodule {dirname|camelcase|capitalize}.{basename|camelcase|capitalize}Controller do',
      \         '  use {dirname|camelcase|capitalize}, :controller',
      \         'end'
      \       ]
      \     },
      \     'test/**/controllers/*_controller_test.exs': {
      \       'alternate': 'lib/{dirname}/controllers/{basename}_controller.ex',
      \       'type': 'test',
      \       'template': [
      \         'defmodule {dirname|camelcase|capitalize}.{basename|camelcase|capitalize}ControllerTest do',
      \         '  use {dirname|camelcase|capitalize}.ConnCase, async: true',
      \         'end'
      \       ]
      \     },
      \     'lib/**/channels/*_channel.ex': {
      \       'type': 'channel',
      \       'alternate': 'test/{dirname}/channels/{basename}_channel_test.exs',
      \       'template': [
      \         'defmodule {dirname|camelcase|capitalize}.{basename|camelcase|capitalize}Channel do',
      \         '  use {dirname|camelcase|capitalize}, :channel',
      \         'end'
      \       ]
      \     },
      \     'test/**/channels/*_channel_test.exs': {
      \       'alternate': 'lib/{dirname}/channels/{basename}_channel.ex',
      \       'type': 'test',
      \       'template': [
      \         'defmodule {dirname|camelcase|capitalize}.{basename|camelcase|capitalize}ChannelTest do',
      \         '  use {dirname|camelcase|capitalize}.ChannelCase, async: true',
      \         '',
      \         '  alias {dirname|camelcase|capitalize}.{basename|camelcase|capitalize}Channel',
      \         'end'
      \       ]
      \     },
      \     'test/**/features/*_test.exs': {
      \       'type': 'feature',
      \       'template': [
      \         'defmodule {dirname|camelcase|capitalize}.{basename|camelcase|capitalize}Test do',
      \         '  use {dirname|camelcase|capitalize}.FeatureCase, async: true',
      \         'end'
      \       ]
      \     },
      \     'lib/*.ex': {
      \       'alternate': 'test/{}_test.exs',
      \       'type': 'source',
      \       'template': [
      \         'defmodule {camelcase|capitalize|dot} do',
      \         'end'
      \       ]
      \     },
      \     'test/*_test.exs': {
      \       'alternate': 'lib/{}.ex',
      \       'type': 'test',
      \       'template': [
      \         'defmodule {camelcase|capitalize|dot}Test do',
      \         '  use ExUnit.Case, async: true',
      \         '',
      \         '  alias {camelcase|capitalize|dot}',
      \         'end'
      \       ]
      \     }
      \   }
      \ }

  "Refresh devicons
  if exists('g:loaded_webdevicons')
      call webdevicons#refresh()
  endif
