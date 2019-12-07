" == VIM PLUG ================================
call plug#begin('~/.vim/plugged')
"------------------------ COC ------------------------
" coc for tslinting, auto complete and prettier
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'} " coc extensions
let g:coc_global_extensions = ['coc-tslint-plugin', 'coc-tsserver', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-yank', 'coc-prettier'] "------------------------ VIM TSX ------------------------
" by default, if you open tsx file, neovim does not show syntax colors
" vim-tsx will do all the coloring for jsx in the .tsx file
Plug 'ianks/vim-tsx' "------------------------ VIM TSX ------------------------
" by default, if you open tsx file, neovim does not show syntax colors
" typescript-vim will do all the coloring for typescript keywords
Plug 'leafgarland/typescript-vim' "------------------------ THEME ------------------------
" most importantly you need a good color scheme to write good code :D
Plug 'dikiaap/minimalist'
" Vim ext for FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Navigation tree
Plug 'scrooloose/nerdtree'           
Plug 'Nopik/vim-nerdtree-direnter' " Fix for opening files and directories in tabs   
" Git
Plug 'tpope/vim-fugitive'     " Git utils ( I only use annotate )
Plug 'mhinz/vim-signify'      " Shows what is changed in a sidebar           
call plug#end()
" == VIMPLUG END ================================

" == AUTOCMD ================================ 
" by default .ts file are not identified as typescript and .tsx files are not
" identified as typescript react file, so add following
au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx
" == AUTOCMD END ================================



" ============================
" SETTINGS
" ============================
language en_US           " had to put this for Neovim
set clipboard^=unnamed   " Use the system register for everything
set backspace=2          " Backspace deletes like most programs in insert mode
set hidden
let mapleader = ","

" Lines and columns
" set invcursorline
set number
" set numberwidth=5
set textwidth=80         " line to limit to 80 chars
set colorcolumn=+1
set so=7                 " Set 7 lines to the cursor - when moving vertically using j/k
set mouse=a

" Colors and appearance
set termguicolors " enable true color for Vim
colorscheme minimalist

" Folding
set foldenable        " don't fold by default
set foldmethod=indent " fold based on indent
set foldlevelstart=10 " open most folds by default
set foldnestmax=10    " 10 nested fold max

" SPLITS
set splitbelow
set splitright
set fillchars=vert:│  " Vertical separator between windows (unicode)"


" ----------------------------------------------------------------------------
" NerdTree
" ----------------------------------------------------------------------------
let NERDTreeShowHidden=1 " Always show dot files
let NERDTreeQuitOnOpen=1
let g:NERDTreeMapOpenInTab = '<ENTER>'
let g:NERDTreeWinPos = "right"

" ============================
" Fuzzy Finder Setup
" ============================
let g:fzf_action = {
       \ 'enter': 'tab split',
       \ 'ctrl-x': 'split',
       \ 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'down': '~40%'  }
nnoremap <Leader><Leader> :Files<cr>
nnoremap <Leader>f :Rg <C-R><C-W><cr>
vnoremap <Leader>f y:Rg <C-R>"<cr>
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, <bang>0)

" Buffer
function! s:buflist()
  redir => ls
  silent ls
  redir END
  return split(ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <Leader><Enter> :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })<CR>


" ============================
" COC
" ============================
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader> ff  <Plug>(coc-format-selected)
nmap <leader> ff  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>