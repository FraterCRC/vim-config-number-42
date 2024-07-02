set relativenumber
call plug#begin()

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
Plug 'moll/vim-bbye'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
Plug 'davidhalter/jedi-vim'
Plug 'neomake/neomake'

call plug#end()
call neomake#configure#automake('nrwi', 500)
set completeopt=menuone,noinsert,noselect
set pumheight=10  " Limit the number of items in the popup menu
let g:neomake_python_enabled_makers = ['pylint']
let g:jedi#completions_enabled = 0
let g:jedi#use_splits_not_buffers = "right"
let g:airline_powerline_fonts = 1
let g:airline_theme='tomorrow' 
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete=1
let g:python_host_prog = '/Users/ivanbrovkin/Git/nvim-venv/nvim-venv/bin/python'
let g:python3_host_prog = '/Users/ivanbrovkin/Git/nvim-venv/nvim-venv/bin/python'

" Kmaps "
nnoremap <silent> <F7> :NERDTreeToggle<CR>
nnoremap <silent> <F8> :NERDTreeFind<CR>
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-b> :Buffers<CR>
nnoremap <silent> <C-l> :Lines<CR>
nnoremap <silent> <Tab> :BufferLineCycleNext<CR>
nnoremap <silent> <S-Tab> :BufferLineCyclePrev<CR>
nnoremap <silent> <leader>bd :Bdelete<CR>
nnoremap <silent> <leader>bc :BCreate<CR>
nnoremap <silent> <leader>n :enew<CR>
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

function! GetAllSnippets()
  call UltiSnips#SnippetsInCurrentScope(1)
  let list = []
  for [key, info] in items(g:current_ulti_dict_info)
    let parts = split(info.location, ':')
    call add(list, {
      \ 'text': key,
      \ 'filename': parts[0],
      \ 'lnum': parts[1],
      \ 'context': info.description,
      \ })
  endfor
  call setqflist([], ' ', { 'title': 'Snippets', 'items' : list})

  " Open Quickfix list as soon as it is populated
  copen
endfunction
nnoremap <leader>ls :call GetAllSnippets()<CR>


" Bufferline settings "
lua << EOF
require'bufferline'.setup {
  options = {
    numbers = "both",
    close_command = "Bdelete! %d",
    right_mouse_command = "Bdelete! %d",
    left_mouse_command = "buffer %d",
    middle_mouse_command = nil,
    indicator_icon = '▎',
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    max_name_length = 18,
    max_prefix_length = 15,
    tab_size = 18,
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,
    offsets = {{filetype = "NvimTree", text = "File Explorer", text_align = "center"}},
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true,
    separator_style = "slant",
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    sort_by = 'id',
  }
}
EOF

" Doesn't let fzf open files in NERD buffer "
function! FZFOpen(command_str)
  if (expand('%') =~# 'NERD_tree' && winnr('$') > 1)
    exe "normal! \<c-w>\<c-w>"
  endif
  exe 'normal! ' . a:command_str . "\<cr>"
endfunction

" Highlintning options "
set termguicolors
colorscheme gruvbox
" Highlighting for Python syntax
hi pythonFunction guifg=#c678dd guibg=NONE
hi pythonClass guifg=#e5c07b guibg=NONE
hi pythonBuiltin guifg=#98c379 guibg=NONE
hi pythonString guifg=#56b6c2 guibg=NONE
hi pythonComment guifg=#5c6370 guibg=NONE
hi pythonKeyword guifg=#e06c75 guibg=NONE
hi pythonOperator guifg=#c678dd guibg=NONE
hi pythonNumber guifg=#d19a66 guibg=NONE
