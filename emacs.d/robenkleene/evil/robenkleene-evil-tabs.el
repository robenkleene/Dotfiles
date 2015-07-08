;;; robenkleene-evil-tabs.el --- robenkleene-evil-tabs
;;; Commentary:
;;; Code:

(require 'evil-common)
(require 'evil-types)
(require 'evil-commands)

(evil-define-command robenkleene/evil-tab-edit (file)
  :repeat nil
  (interactive "<f>")
  (make-frame)
  (delete-other-windows)
  (evil-edit file)
  ;; (find-file file)
  )
(evil-define-command robenkleene/evil-tab-new ()
  :repeat nil
  (interactive)
  (make-frame)
  (delete-other-windows)
  (switch-to-buffer (get-buffer-create "*scratch*"))
  )
(evil-ex-define-cmd "tabe[dit]" 'robenkleene/evil-tab-edit)
(evil-ex-define-cmd "tabnew" 'robenkleene/evil-tab-new)

(define-key evil-motion-state-map (kbd "gt") 'other-frame)
(define-key evil-motion-state-map (kbd "gT") (lambda ()
                                               (interactive)
                                               (other-frame -1)
                                               )
  )

(provide 'robenkleene-evil-tabs)
;;; robenkleene-evil-tabs.el ends here
