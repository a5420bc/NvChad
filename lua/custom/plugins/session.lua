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
     \ 'silent FloatermKill!'
     \ ]
     let g:startify_session_persistence = 1
     let g:session_autoload='yes'
     let g:session_autosave='no'
     let g:session_extension=""
     let g:session_default_to_last=1
     let g:session_lock_enabled=0
     let g:session_swap_name = ""
     let g:startify_session_dir = stdpath('data') . '/session'
     " let g:session_directory =  stdpath('data') . '/sessions'
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
]],
  true
)
