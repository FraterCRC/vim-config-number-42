set relativenumber
call plug#begin()

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
Plug 'moll/vim-bbye'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}

Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
call plug#end()
lua << EOF
  vim.g.coq_settings = {
    auto_start = 'shut-up',
  }
EOF
" Configure LSP for Python using pyright
lua << EOF
  local lspconfig = require('lspconfig')
  local coq = require('coq')
  vim.g.coq_settings = {
    auto_start = true,
    clients = {
      snippets = {
        enabled = true,
      },
    },
  }
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "pyright" },
  automatic_installation = true 
})
require'lspconfig'.pyright.setup{}

-- Automatically install LSP servers

EOF

nnoremap <silent> <leader>bc :BCreate<CR>
nnoremap <silent> <leader>n :enew<CR>

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
