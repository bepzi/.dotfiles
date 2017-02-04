;; ~/.emacs.d/rust.el
;; Configuration file for how Emacs handles Rust code

;; Racer is a program that uses the Rust source code to complete snippets

;; Set the rust-src variable for Racer
(setq
racer-rust-src-path "~/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src")

;; Make it so that saving files while in Rust-mode
;; applies rustfmt and C-c C-c compiles/tests the code
(defun rust-mode-setup ()
  (setq compile-command "cargo test")
  (define-key (current-local-map) "\C-c\C-c" 'compile)
  (add-hook 'before-save-hook 'rust-format-buffer))

;; Start Racer, eldoc, and company when loading a Rust file
(add-hook 'rust-mode-hook 'rust-mode-setup)
(add-hook 'rust-mode-hook #'racer-mode)
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'racer-mode-hook #'company-mode)

(require 'rust-mode)

;; Bind TAB to Company's completion/indent
(define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common)
