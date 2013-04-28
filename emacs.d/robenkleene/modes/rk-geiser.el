(provide 'rk-geiser)

(rk-install-package-if-missing 'geiser)
(setq geiser-active-implementations '(racket))
(setq geiser-racket-binary "/usr/local/bin/racket")
