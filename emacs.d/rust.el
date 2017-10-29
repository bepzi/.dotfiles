;; ~/.emacs.d/rust.el
;; Configuration file for how Emacs handles Rust code

(use-package rust-mode
  :ensure t)

(use-package toml-mode
  :ensure t)

(use-package cargo
  :ensure t)

(use-package racer
  :ensure t)

;; (use-package flycheck-rust
;;   :ensure t)

;; Racer is a program that uses the Rust source code to complete snippets
;; Set the rust-src variable for Racer
(setq
 racer-rust-src-path "~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src")

(setq rust-format-on-save t)

;; C-c C-c compiles/tests the code
(defun rust-mode-setup ()
  (setq compile-command "cargo test && cargo check")
  (define-key (current-local-map) "\C-c\C-c" 'compile))

;; Start Racer, eldoc, and company when loading a Rust file
(add-hook 'rust-mode-hook 'rust-mode-setup)
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)
; (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)

(require 'rust-mode)

;; Bind TAB to Company's completion/indent
(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
