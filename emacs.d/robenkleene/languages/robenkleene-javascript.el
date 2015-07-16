;;; robenkleene-javascript.el --- robenkleene-javascript
;;; Commentary:
;;; Code:

(require 'use-package)
(use-package js2-mode
  :ensure t
  :init
  :mode "\\.js\\'"
  :config
  (progn
    (use-package nodejs-repl
      :ensure t
      :config
      (progn
        (defvar nodejs-repl-command)
        (setq nodejs-repl-command "/Users/robenkleene/.nvm/versions/node/v0.12.2/bin/node")
        )
      )
    )
  )

(provide 'robenkleene-javascript)
;;; robenkleene-javascript.el ends here
