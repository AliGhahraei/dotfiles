let g:config_dir = expand('~/.local/share/nvim')


function InitVimPlug()
  let vim_plug_dir = g:config_dir . '/site/autoload/'
  let vim_plug = vim_plug_dir . 'plug.vim'

  if filereadable(vim_plug)
    call s:Plug()
  else
    echo "Installing vim-plug...\n"

    let curl_vim_plug_cmd = '!curl -fLo "' . vim_plug . '" --create-dirs "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"'
    silent execute curl_vim_plug_cmd

    if v:shell_error
      echo "Curl error!: " . v:shell_error . "\n"
    endif

    call s:Plug() | PlugInstall
  endif
endfunction


function s:Plug()
  call plug#begin(g:config_dir . '/plugged')

  Plug 'dracula/vim', { 'as': 'dracula' }
  Plug 'dag/vim-fish', { 'for': 'fish' }

  call plug#end()
endfunction


function Config()
  colorscheme dracula
  set number
  let $LANG = 'en_US'
  set mouse=a
  au FileType crontab setlocal bkc=yes
endfunction


call InitVimPlug()
call Config()
