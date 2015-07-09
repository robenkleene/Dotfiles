;;; robenkleene-evil-dired.el --- robenkleene-evil-dired
;;; Commentary:
;;; Code:

(require 'evil)
(defvar dired-mode-map)
(evil-declare-key 'normal dired-mode-map
  "r" 'revert-buffer)

(provide 'robenkleene-evil-dired)
;;; robenkleene-evil-dired.el ends here
