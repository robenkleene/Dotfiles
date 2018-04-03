;;; robenkleene-god-mode.el --- robenkleene-god-mode
;;; Commentary:
;;; Code:

(use-package god-mode
  :bind
  ("C-z" . god-mode-all)
  ("M-z" . god-mode-all)
  :ensure
  :init
  (global-hl-line-mode)
  (make-variable-buffer-local 'global-hl-line-mode)


  ;; (defvar robenkleene/ascend-mode-map (make-keymap))
  ;; (define-minor-mode robenkleene/ascend-mode
  ;;   "Ascend."
  ;;   nil
  ;;   nil
  ;;   'robenkleene/ascend-mode-map)
  ;; (define-key robenkleene/ascend-mode-map (kbd "C-x") 'robenkleene/ascend)
  ;; (robenkleene/ascend-mode -1)
  ;; (robenkleene/ascend-mode)

  (god-mode-all)
  :config
  (define-key god-local-mode-map (kbd "i") 'god-local-mode)
  (global-set-key (kbd "C-x C-o") 'other-window)
  (global-set-key (kbd "C-x C-1") 'delete-other-windows)
  (global-set-key (kbd "C-x C-2") 'split-window-below)
  (global-set-key (kbd "C-x C-3") 'split-window-right)
  (global-set-key (kbd "C-x C-0") 'delete-window)
  (global-set-key (kbd "C-x C-b") 'ido-switch-buffer)
  ;; (global-set-key (kbd "C-x C-^]") 'next-buffer)
  ;; (global-set-key (kbd "C-x C-^[") 'previous-buffer)
  ;; (global-set-key (kbd "C-x C-<right>") 'next-buffer)
  ;; (global-set-key (kbd "C-x C-<left>") 'previous-buffer)

  (add-hook 'emacs-startup-hook (lambda ()
                                  (add-hook 'after-change-functions
                                            (lambda (&rest args)
                                              (if (and (buffer-modified-p)
                                                       (bound-and-true-p god-local-mode)
                                                       (god-passes-predicates-p)
                                                       )
                                                  (call-interactively 'god-local-mode)
                                                )
                                              )
                                            )
                                  )
            )

  ;; This is hard to get right due to arguments
  ;; (define-key god-local-mode-map (kbd "DEL") (lambda ()
  ;;                                              (interactive)
  ;;                                              (sp-backward-delete-char)
  ;;                                              (call-interactively 'god-local-mode)
  ;;                                              ))
  
  ;; `yassnippet'
  (add-to-list 'god-exempt-major-modes 'snippet-mode)

  ;; (defun robenkleene/ascend ()
  ;;   "Enter god-more then hit `C-x'."
  ;;   (interactive)
  ;;   (god-mode-all)
  ;;   (execute-kbd-macro (kbd "C-x"))
  ;;   )

  ;; God Override Mode
  (defvar robenkleene/god-override-minor-mode-map (make-keymap))
  (defvar robenkleene/god-override-x-map (make-keymap))
  (define-minor-mode robenkleene/god-override-minor-mode
    "My bindings for `god-exempt-major-modes'"
    nil
    nil
    'robenkleene/god-override-minor-mode-map)
  (define-key robenkleene/god-override-minor-mode-map (kbd "x") robenkleene/god-override-x-map)
  (define-key robenkleene/god-override-minor-mode-map (kbd "SPC") 'scroll-up-command)
  (define-key robenkleene/god-override-minor-mode-map (kbd "DEL") 'scroll-down-command)
  ;; Bindings
  (define-key robenkleene/god-override-x-map (kbd "o") 'other-window)
  (define-key robenkleene/god-override-x-map (kbd "1") 'delete-other-windows)
  (define-key robenkleene/god-override-x-map (kbd "2") 'split-window-below)
  (define-key robenkleene/god-override-x-map (kbd "3") 'split-window-right)
  (define-key robenkleene/god-override-x-map (kbd "0") 'delete-window)
  (define-key robenkleene/god-override-x-map (kbd "c") 'save-buffers-kill-terminal)
  (define-key robenkleene/god-override-x-map (kbd "s") 'save-buffer)
  (define-key robenkleene/god-override-x-map (kbd "b") 'ido-switch-buffer)
  (define-key robenkleene/god-override-x-map (kbd "<left>") 'previous-buffer)
  (define-key robenkleene/god-override-x-map (kbd "<right>") 'next-buffer)

  ;; robenkleene/god-override-exempt-major-modes
  (defcustom robenkleene/god-override-exempt-major-modes
    '(git-commit-mode
      grep-mode
      vc-annotate-mode
      git-commit-mode
      snippet-mode)
    "List of major modes that should not use the override map."
    :type '(function)
    )

  (defadvice god-mode-maybe-activate (after robenkleene/toggle-god-override-mode (&optional status) activate)
    (if (and (not (bound-and-true-p god-local-mode))
             (and (not (memq major-mode robenkleene/god-override-exempt-major-modes))
                  (not (god-git-commit-mode-p))
                  (not (minibufferp))
                  )
             )
        (robenkleene/god-override-minor-mode)
      )
    )

  (with-current-buffer "*Messages*"
    (robenkleene/god-override-minor-mode)
    )

  (add-hook 'god-mode-enabled-hook (lambda ()
                                     (setq global-hl-line-mode t)
                                     (robenkleene/god-override-minor-mode -1)
                                     )
            )
  (add-hook 'god-mode-disabled-hook (lambda ()
                                      (setq global-hl-line-mode nil)
                                      )
            )

  
  )

(provide 'robenkleene-god-mode)
;;; robenkleene-god-mode.el ends here
