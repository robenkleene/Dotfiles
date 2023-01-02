;;; robenkleene-alias.el --- robenkleene-alias
;;; Commentary:
;;; Code:

;; Shorthand
(defalias 'rg 'robenkleene/rg)
(defalias 'oi 'robenkleene/edit-init)
(defalias 'yg 'robenkleene/grep-from-clipboard)
(defalias 'esh 'eshell)
(defalias 'bd 'kill-this-buffer)
(defalias 'doc 'robenkleene/consult-doc)
(defalias 'scw 'robenkleene/source-control-open-web)
(defalias 'scwp (lambda ()
                  (interactive)
                  (robenkleene/source-control-open-web "-p")))
(defalias 'repla 'robenkleene/open-in-repla)
(defalias 'u 'robenkleene/egit-update)

;; Vim
(defalias 'new 'robenkleene/new-empty-other-window)
(defalias 'vnew 'robenkleene/new-empty-other-window-vertical)
(defalias 'enew 'robenkleene/new-empty)

;; Kill
(defalias 'kill-buffer-file-name 'robenkleene/kill-buffer-file-name)
(defalias 'kill-default-directory 'robenkleene/kill-default-directory)
(defalias 'kill-buffer-name 'robenkleene/kill-buffer-name)
(defalias 'kill-date-today 'robenkleene/kill-date-today)

;; cd
(defalias 'git-cd 'robenkleene/git-cd)
(defalias 'hg-cd 'robenkleene/hg-cd)
(defalias 'pwd-cd 'robenkleene/pwd-cd)

;; Buffers
(defalias 'switch-to-scratch 'robenkleene/open-emacs-scratch)
(defalias 'switch-to-messages 'robenkleene/open-emacs-messages)
(defalias 'switch-to-home 'robenkleene/open-home)

;; Text Converstions
(defalias 'archive-this-buffer 'robenkleene/archive-current-file)
(defalias 'archive-region 'robenkleene/archive-region)
(defalias 'convert-region-to-title-case 'robenkleene/convert-region-to-title-case)
(defalias 'date-today 'robenkleene/date-today)

;; Text
(defalias 'switch-to-inbox 'robenkleene/switch-to-inbox)
(defalias 'switch-to-archive 'robenkleene/switch-to-archive)
(defalias 'switch-to-text 'robenkleene/switch-to-text)
(defalias 'switch-to-notes 'robenkleene/switch-to-notes)
(defalias 'inbox-create 'robenkleene/inbox-create)
(defalias 'switch-to-daily 'robenkleene/daily)
(defalias 'daily-create 'robenkleene/daily-create)

;; Slug Project
(defalias 'slug-project-create 'robenkleene/slug-project)
(defalias 'slug-project-archive 'robenkleene/slug-project-archive)
(defalias 'slug-project-archive-readme 'robenkleene/slug-project-archive-readme)

(provide 'robenkleene-alias)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-alias.el ends here
