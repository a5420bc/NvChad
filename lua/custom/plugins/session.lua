vim.api.nvim_exec(
  [[
     "定义自定义标题
     let g:startify_custom_header = [
     \ '██╗   ██╗██╗███╗   ███╗██╗██████╗ ███████╗',
     \ '██║   ██║██║████╗ ████║██║██╔══██╗██╔════╝',
     \ '██║   ██║██║██╔████╔██║██║██║  ██║█████╗',
     \ '╚██╗ ██╔╝██║██║╚██╔╝██║██║██║  ██║██╔══╝',
     \  ' ╚████╔╝ ██║██║ ╚═╝ ██║██║██████╔╝███████╗',
     \  '  ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝╚═════╝ ╚══════╝',
     \]
     " 不展示empty buffer 和quit界面
     let g:startify_enable_special = 0
     " 自动加载session
     let g:startify_session_autoload  = 0
     " 切换session时关闭所有的terminal
     let g:startify_session_before_save = [
     \ 'echo "Cleaning up before saving.."',
     \ 'silent FloatermKill!',
     \ 'call writefile([fnamemodify(v:this_session, ":t")], g:startify_session_dir . "/last-session.txt")'
     \ ]
     let g:startify_session_persistence = 1
     let g:session_swap_name = ""
     let g:startify_session_dir = stdpath('data') . '/session'
     function MySessionReload(name, bang) abort
       if g:session_swap_name != ""  && a:name == ""
         let s_session_name_old = g:session_swap_name
         let g:session_swap_name =  fnamemodify(v:this_session, ':t')
         call startify#session_load(a:bang, s_session_name_old)
       else
         let g:session_swap_name =  fnamemodify(v:this_session, ':t')
         call startify#session_load(a:bang, a:name)
       endif
       if &filetype == "php"
         exe "silent! LspRestart"
       endif
     endfunction
     command! -bar -bang -nargs=? -complete=customlist,startify#session_list MyOpenSession  call MySessionReload(<q-args>, <q-bang>)
     function! s:get_last_or_default_session()
       let last_session_file = g:startify_session_dir . "/last-session.txt"
       let has_last_session = filereadable(last_session_file)
       if has_last_session
         let lines = readfile(last_session_file)
         return [has_last_session, lines[0] ]
        else
          return [has_last_session, g:session_default_name]
        endif
     endfunction
     function!  s:auto_load()
       let [has_last_session, session] = s:get_last_or_default_session()
       let path = g:startify_session_dir . '/' .  session
       if (has_last_session && filereadable(path))
           call startify#session_load("", session)
       endif
     endfunction
     au VimEnter * nested call s:auto_load()
]],
  true
)
