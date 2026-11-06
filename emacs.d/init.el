;;; init.el --- init -*- lexical-binding: t; -*-
;;; Commentary:
;;; Code:

;; The `libgccjit' bundled with `Emacs.app' derives `-mmacosx-version-min' from
;; the Darwin version (Darwin 27 becomes `18.0'), which `clang' rejects, so pass
;; the real macOS version instead. `comp-run' only forwards
;; `native-comp-driver-options' to async compilation if it's bound, so `require'
;; `comp' first. We should periodically try removing this
(when (and (eq system-type 'darwin) (native-comp-available-p))
  (with-eval-after-load 'comp-run
    (require 'comp)
    (add-to-list 'native-comp-driver-options
                 (concat "-mmacosx-version-min="
                         (car (split-string
                               (shell-command-to-string
                                "sw_vers --productVersion")
                               "\\."))
                         ".0")
                 t)))

;; Without this, using `package.el` will add this content to this file
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(add-to-list 'load-path (expand-file-name "~/.emacs.d/robenkleene"))
(require 'robenkleene)

;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; init.el ends here
