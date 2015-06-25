;;; packages.el --- robenkleene Layer packages File for Spacemacs
;;
;; Copyright (c) 2012-2014 Sylvain Benner
;; Copyright (c) 2014-2015 Sylvain Benner & Contributors
;;
;; Author: Sylvain Benner <sylvain.benner@gmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;; List of all packages to install and/or initialize. Built-in packages
;; which require an initialization must be listed explicitly in the list.

(setq robenkleene-packages
    '(
      ;; package robenkleenes go here
      ir-black-theme
      ;; tron-theme
      noctilux-theme
      moe-theme
      purple-haze-theme
      material-theme
      evil-smartparens
      ;; swift-mode
      ;; flycheck
      ))

(defun robenkleene/init-ir-black-theme ()
  nil
  )

(defun robenkleene/init-moe-theme ()
  nil
  )

(defun robenkleene/init-purple-haze-theme ()
  nil
  )

(defun robenkleene/init-material-theme ()
  nil
  )

(defun robenkleene/init-noctilux-theme ()
  nil
  )

(defun robenkleene/init-evil-smartparens ()
  (use-package evil-smartparens
    :defer t
    :init (add-hook 'smartparens-enabled-hook #'evil-smartparens-mode)
    )
  )
  
;; Can't get this mode working try again later
;; (defun robenkleene/init-swift-mode ()
;;   (use-package swift-mode
;;     :defer t))

;; (defun robenkleene/post-init-flycheck ()
;;   (add-to-list 'flycheck-checkers 'swift)
;;   (add-hook 'swift-mode 'flycheck-mode)
;;   )

;; (defun robenkleene/init-tron-theme ()
;;   nil
;;   )
