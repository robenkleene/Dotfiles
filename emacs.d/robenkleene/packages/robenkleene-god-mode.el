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
  (define-key god-local-mode-map (kbd "SPC") 'scroll-up-command)
  (define-key god-local-mode-map (kbd "DEL") 'robenkleene/god-backspace)
  (define-key god-local-mode-map (kbd "q") 'quit-window)
  (define-key god-local-mode-map (kbd ";") (lambda ()
                                             (interactive)
                                             (god-local-mode -1)
                                             (iedit-mode)))
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

  ;; `yassnippet'
  (add-to-list 'god-exempt-major-modes 'snippet-mode)

  (defun robenkleene/god-backspace ()
    "Delete the current region and enter insert mode."
    (interactive)

    (if (use-region-p)
        (progn
          (delete-region (region-beginning) (region-end))
          (god-local-mode -1)
          )
      (scroll-down-command)
      )

    )

  ;; (defun robenkleene/ascend ()
  ;;   "Enter god-more then hit `C-x'."
  ;;   (interactive)
  ;;   (god-mode-all)
  ;;   (execute-kbd-macro (kbd "C-x"))
  ;;   )

  ;; God Override Mode
  (defvar robenkleene/mortal-mode-map (make-keymap))
  (defvar robenkleene/mortal-map (make-keymap))
  (define-minor-mode robenkleene/mortal-mode
    "My bindings for `god-exempt-major-modes'"
    nil
    nil
    'robenkleene/mortal-mode-map)
  (define-key robenkleene/mortal-mode-map (kbd "SPC") 'scroll-up-command)
  (define-key robenkleene/mortal-mode-map (kbd "DEL") 'scroll-down-command)  
  (define-key robenkleene/mortal-mode-map (kbd "s") 'isearch-forward-regexp)
  (define-key robenkleene/mortal-mode-map (kbd "r") 'isearch-backward-regexp)
  (define-key robenkleene/mortal-mode-map (kbd "c") robenkleene/leader-map)
  ;; Bindings
  (define-key robenkleene/mortal-mode-map (kbd "x") robenkleene/mortal-map)
  (define-key robenkleene/mortal-map (kbd "o") 'other-window)
  (define-key robenkleene/mortal-map (kbd "1") 'delete-other-windows)
  (define-key robenkleene/mortal-map (kbd "2") 'split-window-below)
  (define-key robenkleene/mortal-map (kbd "3") 'split-window-right)
  (define-key robenkleene/mortal-map (kbd "0") 'delete-window)
  (define-key robenkleene/mortal-map (kbd "c") 'save-buffers-kill-terminal)
  (define-key robenkleene/mortal-map (kbd "s") 'save-buffer)
  (define-key robenkleene/mortal-map (kbd "b") 'ido-switch-buffer)
  (define-key robenkleene/mortal-map (kbd "f") 'find-file-at-point)
  (define-key robenkleene/mortal-map (kbd "<left>") 'previous-buffer)
  (define-key robenkleene/mortal-map (kbd "<right>") 'next-buffer)


  (defcustom robenkleene/mortal-exempt-major-modes
    '(git-commit-mode
      vc-annotate-mode
      git-commit-mode
      snippet-mode)
    "List of major modes that should not use the override map."
    :type '(function)
    )

  (defadvice god-mode-maybe-activate (after robenkleene/toggle-mortal-mode (&optional status) activate)
    (if (and (not (bound-and-true-p god-local-mode))
             (and (not (memq major-mode robenkleene/mortal-exempt-major-modes))
                  (not (god-git-commit-mode-p))
                  (not (minibufferp))
                  )
             )
        (robenkleene/mortal-mode)
      )
    )

  (with-current-buffer "*Messages*"
    (robenkleene/mortal-mode)
    )

  (add-hook 'god-mode-enabled-hook (lambda ()
                                     (setq global-hl-line-mode t)
                                     (robenkleene/mortal-mode -1)
                                     )
            )
  (add-hook 'god-mode-disabled-hook (lambda ()
                                      (setq global-hl-line-mode nil)
                                      )
            )

  (add-hook 'magit-status-mode-hook
            (lambda ()
              (make-local-variable 'robenkleene/mortal-mode-map)
              (setq robenkleene/mortal-mode-map (copy-tree robenkleene/mortal-mode-map))
              (define-key robenkleene/mortal-mode-map (kbd "c") nil)
              (define-key robenkleene/mortal-mode-map (kbd "r") nil)
              (define-key robenkleene/mortal-mode-map (kbd "s") nil)
              )
            )


  )

(provide 'robenkleene-god-mode)
;;; robenkleene-god-mode.el ends here
