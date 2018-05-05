;; ~/.emacs.d/appearance.el
;; Configuration settings for how Emacs looks in general

;; Uncomment if you are unable to see your selections when highlighting text
;; '(region ((t (:background "#d3d3d3" :distant-foreground "gtk_selection_fg_color"))))

;; Enable line numbers
(global-linum-mode t)

;; Whitespace mode config
;; Sourced from: https://github.com/rexim/dotfiles/blob/master/.emacs.rc/whitespace-mode-rc.el
(defun rc/turn-on-whitespace-mode ()
  (interactive)
  (whitespace-mode 1))

(defun rc/delete-trailing-whitespace-on-save ()
  (interactive)
  (add-to-list 'write-file-functions 'delete-trailing-whitespace))

(defun rc/set-up-whitespace-handling ()
  (interactive)
  (rc/turn-on-whitespace-mode)
  (rc/delete-trailing-whitespace-on-save))

(setq whitespace-style '(space-mark tab-mark))

;; (let ((whitespace-enabled-modes
;;        '(
;;          tuareg-mode-hook
;;          c++-mode-hook
;;          c-mode-hook
;;          rust-mode-hook
;;          emacs-lisp-mode
;;          java-mode-hook
;;          lua-mode-hook
;;          rust-mode-hook
;;          scala-mode-hook
;;          markdown-mode-hook
;;          js2-mode-hook
;;          haskell-mode-hook
;;          python-mode-hook
;;          erlang-mode-hook
;;          asm-mode-hook
;;          nasm-mode-hook
;;          )))
;;   (dolist (mode whitespace-enabled-modes)
;; (add-hook mode 'rc/set-up-whitespace-handling)))

;; Custom font size
;; Height value is in 1/10pt, so 100=10pt
;; (set-face-attribute 'default nil :height 110)
