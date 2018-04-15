(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (org irony-eldoc flycheck-irony company-irony irony neotree ox-gfm git-gutter magit lsp-ui modern-cpp-font-lock clang-format company-c-headers f lsp-rust lsp-mode helm-config helm intero flycheck-haskell haskell-mode racket-mode markdown-mode flycheck flycheck-rust ensime use-package toml-mode tidy racer company cargo rust-mode powerline better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("org" . "http://orgmode.org/elpa/")
   t)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (package-initialize))

;; Enable the loading of files in ~/.emacs.d/
(defun load-user-file (file)
  (interactive "f")
  "Load a file in current user's configuration directory"
  (load-file (expand-file-name file "~/.emacs.d/")))

;; Allow for running GUI-specific code through emacsclient
(defun new-frame-setup (&optional frame)
  (if (display-graphic-p frame)
      (load-user-file "xresources-theme/xresources-theme.el")))
(mapc 'new-frame-setup (frame-list))
(add-hook 'after-make-frame-functions 'new-frame-setup)

;; Load individual configuration files
(load-user-file "behavior.el")
(load-user-file "appearance.el")
(load-user-file "org.el")
(load-user-file "programming.el")
(load-user-file "company.el")

(if (display-graphic-p)
    (load-user-file "xresources-theme/xresources-theme.el"))
