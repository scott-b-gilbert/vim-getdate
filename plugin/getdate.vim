" Vim plug-in
" Author: Scott Gilbert <scott.b.gilbert@protonmail.com>
" Last Change: 2021-01-10
" URL: https://github.com/scott-b-gilbert/vim-getdate

" Don't source the plug-in when it's already been loaded or &compatible is set.
if &cp || exists('g:loaded_vim_getdate')
  finish
endif

if !executable('getdate.sh')
		echom "getdate.sh is not installed on this system or not in path"
    finish
endif

" Make sure the plug-in is only loaded once.
let g:loaded_vim_getdate = 1


command! -nargs=+ GetDate call s:RunShellCommand('getdate.sh '.<q-args>)
nnoremap <leader>h :set operatorfunc=<SID>GetDateOperator<cr>g@
vnoremap <silent> <leader>da  :<c-u>call <SID>GetDateOperator(visualmode())<cr>

function! Chomp(string)
    return substitute(a:string, '\n\+$', '', '')
endfunction

function! s:GetDateOperator(type)
  let saved_unnamed_register = @@
  echom a:type
  if a:type ==# 'v'
        normal! `<v`>y
    elseif a:type ==# 'V'
        normal! `<v`>y
    elseif a:type ==# 'char'
        normal! `[v`]y
    else
        return
    endif
  let @@ = Chomp(@@)
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, '# ' . shellescape(@@))
  call setline(3,substitute(getline(2),'.','=','g'))
  silent execute '$read !'. "getdate.sh " . shellescape(@@)
  setlocal nomodifiable
  let @@ = saved_unnamed_register
endfunction

" RunShellCommand code comes from 
" https://vim.fandom.com/wiki/Display_output_of_shell_commands_in_new_window
function! s:RunShellCommand(cmdline)
  echo a:cmdline
  let expanded_cmdline = a:cmdline
  for part in split(a:cmdline, ' ')
     if part[0] =~ '\v[%#<]'
        let expanded_part = fnameescape(expand(part))
        let expanded_cmdline = substitute(expanded_cmdline, part, expanded_part, '')
     endif
  endfor
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1, 'You entered:    ' . a:cmdline)
  call setline(2, 'Expanded Form:  ' .expanded_cmdline)
  call setline(3,substitute(getline(2),'.','=','g'))
  execute '$read !'. expanded_cmdline
  setlocal nomodifiable
  1
endfunction

" vim: ts=2 sw=2 et
