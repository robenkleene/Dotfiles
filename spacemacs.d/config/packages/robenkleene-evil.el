;;; robenkleene-evil.el --- robenkleene-evil
;;; Commentary:
;;; Code:

(defvar robenkleene-leader-map (make-keymap))
(define-key robenkleene-leader-map (kbd "w") 'toggle-truncate-lines)
(define-key robenkleene-leader-map (kbd "t") 'robenkleene/open-terminal-window)
(define-key robenkleene-leader-map (kbd "f") 'robenkleene/open-finder-window)

(defvar robenkleene-unimpaired-next-map (make-keymap))
(define-key robenkleene-unimpaired-next-map (kbd "q") 'next-error)
(defvar robenkleene-unimpaired-previous-map (make-keymap))
(define-key robenkleene-unimpaired-previous-map (kbd "q") 'previous-error)

;; Only use highlight in motion and normal modes
(global-hl-line-mode)
(make-variable-buffer-local 'global-hl-line-mode)
(add-hook 'evil-normal-state-entry-hook (lambda () (setq global-hl-line-mode t)))
(add-hook 'evil-motion-state-entry-hook (lambda () (setq global-hl-line-mode t)))
(add-hook 'evil-insert-state-entry-hook (lambda () (setq global-hl-line-mode nil)))


(eval-after-load 'evil-evilified-state
  '(progn
     (defvar evil-evilified-state-map)
     (define-key evil-evilified-state-map "\C-w" 'evil-window-map)
     (define-key evil-evilified-state-map "\C-b" 'evil-scroll-page-up)
     (define-key evil-evilified-state-map "\C-f" 'evil-scroll-page-down)
     (define-key evil-evilified-state-map "\C-l" 'evil-search-highlight-persist-remove-all)
     (define-key evil-evilified-state-map (kbd "C-o") 'evil-jumper/backward)
     (define-key evil-evilified-state-map (kbd "C-i") 'evil-jumper/forward)
     (define-key evil-evilified-state-map "{" 'evil-backward-paragraph)
     (define-key evil-evilified-state-map "}" 'evil-forward-paragraph)
     (define-key evil-evilified-state-map "?" 'evil-search-backward)
     (define-key evil-evilified-state-map "-" 'robenkleene/dired-jump)
     (define-key evil-evilified-state-map (kbd "\\") robenkleene-leader-map)
     (define-key evil-evilified-state-map (kbd "[") robenkleene-unimpaired-previous-map)
     (define-key evil-evilified-state-map (kbd "]") robenkleene-unimpaired-next-map)
     ;; Evilify
     (declare-function evilify "ext:evil-evilified-state.el")
     ;; Custom
     (defvar Custom-mode)
     (defvar custom-mode-map)
     (evilify Custom-mode custom-mode-map)
     ;; Debugger
     (defvar debugger-mode)
     (defvar debugger-mode-map)
     (evilify debugger-mode debugger-mode-map)
     ;; Dired
     (defvar dired-mode)
     (defvar dired-mode-map)
     (evilify dired-mode dired-mode-map)
     (defvar helm-ag-mode)
     (defvar helm-ag-mode-map)
     (evilify helm-ag-mode helm-ag-mode-map)
     ;; Magit
     (defvar magit-diff-mode)
     (defvar magit-diff-mode-map)
     (defvar magit-status-mode)
     (defvar magit-status-mode-map)
     (evilify magit-diff-mode magit-diff-mode-map)
     (evilify magit-status-mode magit-status-mode-map
              "}" 'magit-goto-next-section
              "{" 'magit-goto-previous-section
              (kbd "C-i") 'magit-toggle-section
              )
     )
  )

(eval-after-load 'evil
  '(progn
     (defvar evil-insert-state-map)
     (defvar evil-normal-state-map)
     (defvar evil-motion-state-map)
     ;; Disable insert mode key map
     (setcdr evil-insert-state-map nil)
     ;; Re-enable esc
     (define-key evil-insert-state-map [escape] 'evil-normal-state)
     (define-key evil-normal-state-map "\C-l" 'evil-search-highlight-persist-remove-all)
     (define-key evil-motion-state-map "\C-l" 'evil-search-highlight-persist-remove-all)
     (define-key evil-normal-state-map "-" 'robenkleene/dired-jump)
     (define-key evil-motion-state-map "-" 'robenkleene/dired-jump)
     ;; Other Leader
     (define-key evil-normal-state-map (kbd "\\") robenkleene-leader-map)
     (define-key evil-motion-state-map (kbd "\\") robenkleene-leader-map)
     ;; Unimpaired
     (define-key evil-normal-state-map (kbd "[") robenkleene-unimpaired-previous-map)
     (define-key evil-normal-state-map (kbd "]") robenkleene-unimpaired-next-map)
     (define-key evil-motion-state-map (kbd "[") robenkleene-unimpaired-previous-map)
     (define-key evil-motion-state-map (kbd "]") robenkleene-unimpaired-next-map)
     )
  )



(custom-set-faces
 ;; Persist search inherits from region
 `(evil-search-highlight-persist-highlight-face ((t (:background nil))))
 )

(provide 'robenkleene-evil)
;;; robenkleene-evil.el ends here
