(provide 'rk-org)

(setq org-support-shift-select 'always)

(eval-after-load "org"
  '(progn
    (define-key org-mode-map (kbd "M-S-<left>") nil)
    (define-key org-mode-map (kbd "M-S-<right>") nil)
    (define-key org-mode-map (kbd "C-s-<up>") 'org-metaup)
    (define-key org-mode-map (kbd "C-s-<down>") 'org-metadown)
    (define-key org-mode-map (kbd "C-s-<left>") 'org-metaleft)
    (define-key org-mode-map (kbd "C-s-<right>") 'org-metaright)
    (define-key org-mode-map (kbd "s-\[") 'org-metaleft)
    (define-key org-mode-map (kbd "s-\]") 'org-metaright)
    ))
