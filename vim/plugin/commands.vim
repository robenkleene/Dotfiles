command! SessionRestoreAuto :source ~/.vim/vim_auto_session
command! Sr :SessionRestoreAuto
command! -nargs=+ Z :call commands#Z(<q-args>)
command! -nargs=1 -complete=customlist,commands#completeMan9 Man9 execute 'Man 9' <f-args>
