
;;; robenkleene-evil-helm.el --- robenkleene-evil-helm
;;; Helm:
;;; Code:

(require 'evil-commands)

;; Use helm's versions for Vim buffer commands
(evil-ex-define-cmd "ls" 'helm-buffers-list)
(evil-ex-define-cmd "ol" 'helm-recentf)

(provide 'robenkleene-evil-helm)
;;; robenkleene-evil-helm.el ends here
