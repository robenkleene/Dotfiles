(provide 'rk-ediff)

(eval-after-load 'ediff
  '(progn
     (setq ediff-window-setup-function 'ediff-setup-windows-plain)
     ))


