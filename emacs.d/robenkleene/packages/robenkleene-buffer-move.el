;;; robenkleene-buffer-move.el --- robenkleene-buffer-move
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))
(use-package buffer-move
  :bind (
         ;; We can't use the default shortcuts with control, because "Mission
         ;; Control" on OS X eats `C-S-<up>/<down>', so instead we use
         ;; `M-S-<up>/<down>' and then map those to `C-S-<up>/<down>' in
         ;; Terminal.app.
         ;; In OS X Terminal, these keys need to be added manually to the
         ;; keyboard profile:
         ;; `<M-S-up>': `\033[1;6A'
         ;; `<M-S-down>': `\033[1;6B'
         ;; `<M-S-right>': `\033[1;6C'
         ;; `<M-S-left>': `\033[1;6D'
         ;; ("<C-S-up>" . buf-move-up)
         ;; ("<C-S-down>" . buf-move-down)
         ;; ("<C-S-left>" . buf-move-left)
         ;; ("<C-S-right>" . buf-move-right)
         )
  )

(provide 'robenkleene-buffer-move)
;;; robenkleene-buffer-move.el ends here
