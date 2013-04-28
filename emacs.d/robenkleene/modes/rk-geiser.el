(provide 'rk-geiser)

(rk-install-package-if-missing 'geiser)

(eval-after-load 'geiser
  '(progn
     (setq geiser-active-implementations '(racket))
     (setq geiser-racket-binary "/usr/local/bin/racket")
     ))
