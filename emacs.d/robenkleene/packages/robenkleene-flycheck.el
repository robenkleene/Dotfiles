;;; robenkleene-flycheck.el --- robenkleene-flycheck
;;; Commentary:
;;; Code:

(eval-when-compile (require 'use-package))
(use-package flycheck
  :init
  (global-flycheck-mode)
  (setq flycheck-display-errors-delay 0.1)
  (setq flycheck-checkers
        '(
          c/c++-clang
          css-stylelint
          cuda-nvcc
          cwl
          d-dmd
          dockerfile-hadolint
          emacs-lisp
          emacs-lisp-checkdoc
          erlang-rebar3
          html-tidy
          javascript-eslint
          proselint
          ruby-rubocop
          ruby
          scss-stylelint
          sh-bash
          sh-posix-dash
          sh-posix-bash
          sh-zsh
          sh-shellcheck
          slim
          xml-xmllint
          ))
  )

(provide 'robenkleene-flycheck)
;; Local Variables:
;; byte-compile-warnings: (not free-vars)
;; End:
;;; robenkleene-flycheck.el ends here
