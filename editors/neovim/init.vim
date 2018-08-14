function Plug()
  call plug#begin('~/.local/share/nvim/plugged')

  Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'dag/vim-fish', { 'for': 'fish' }

  call plug#end()
endfunction

"""""""""""""""""""""
"Initialize vim-plug"
"""""""""""""""""""""
let vim_plug_dir = expand('~/.local/share/nvim/site/autoload/')
let vim_plug_location = vim_plug_dir . 'plug.vim'

if filereadable(vim_plug_location)
  " vim-plug is there. Proceed normally
  call Plug()
else
  echo "Installing vim-plug...\n"

  let curl_vim_plug_cmd = '!curl -fLo "' . vim_plug_location . '" --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
  silent execute curl_vim_plug_cmd

  if v:shell_error
    echo "Curl error!: " . v:shell_error . "\n"
  endif

  call Plug() | PlugInstall
endif

""""""""
"Config"
""""""""
colorscheme dracula
set number
let $LANG = 'en_US'
set mouse=a
au FileType crontab setlocal bkc=yes
