(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(
                         ("gnu" . "https://elpa.gnu.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")
                         ("melpa" . "https://melpa.org/packages/")
                         ))
(package-initialize)

;; `condition-case' logs the error and continues, so one failing package (e.g.,
;; `is a system package, not deleting') doesn't abort the rest of the install
(defmacro rk-install--try (label &rest body)
  `(condition-case err
       (progn ,@body)
     (error (message "[rk-install] %s failed: %s" ,label
                     (error-message-string err)))))

;; Same as `package-autoremove', but deletes each package separately, the
;; `package-selected-packages' check avoids deleting everything if it's empty
(when package-selected-packages
  (dolist (package (package--removable-packages))
    (rk-install--try (format "Deleting %s" package)
      (package-delete (cadr (assq package package-alist)) t))))

;; Same as `package-upgrade-all', but upgrades each package separately
(package-refresh-contents)
(dolist (package (package--upgradeable-packages))
  (rk-install--try (format "Upgrading %s" package)
    (package-upgrade package)))

(dolist (package package-selected-packages)
  (rk-install--try (format "Installing %s" package)
    (package-install package)))
