;;; robenkleene-helm-directory-bookmarks.el --- robenkleene-helm-directory-bookmarks
;;; Commentary:
;;; Code:

(defun robenkleene/helm-directory-bookmarks ()
  "Select from listed directories."
  (interactive)
  (helm :sources '(robenkleene/helm-source-directory-bookmarks)
        :buffer "*helm-robenkleene-directory-bookmarks*"))
(setq-default
 robenkleene/bookmark-directories '(
                                    "~/Dotfiles/"
                                    "~/Development/"
                                    "~/Development/Scratch/"
                                    "~/Development/Scratch/Temp/"
                                    "~/Development/Projects/"
                                    ))

(defvar robenkleene/helm-source-directory-bookmarks)
(setq robenkleene/helm-source-directory-bookmarks
      '((name . "HELM at the Emacs")
        ;; (candidates . (1 2 3 4))
        (candidates . robenkleene/bookmark-directories)
        (action . (lambda (candidate)
                    (find-file candidate)))))

(provide 'robenkleene-helm-directory-bookmarks)
;;; robenkleene-helm-directory-bookmarks.el ends here
