;; ~/.emacs.d/behavior.el
;; Configuration settings for how Emacs should behave

(use-package better-defaults
  :ensure t)

(use-package helm
  :ensure t)
(helm-mode 1)

;; Always follow symlinks, do not prompt
(setq vc-follow-symlinks t)

;; Automatically download ELPA packages if not present
(setq use-package-always-ensure t)

;; Automatically fill paragraphs instead of doing M-q a whole bunch
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'org-mode-hook 'turn-on-auto-fill)
