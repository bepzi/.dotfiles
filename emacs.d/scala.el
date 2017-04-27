;; ~/.emacs.d/scala.el
;; Configuration file for how Emacs handles Scala code

(use-package ensime
  :ensure t
  :pin melpa)

(use-package scala-mode
  :pin melpa)

(use-package sbt-mode
  :pin melpa)

;; Make it so that saving files while in Scala-mode
;; C-c C-c compiles/tests the code
(defun scala-mode-setup ()
  (setq compile-command "sbt test && sbt compile")
  (define-key (current-local-map) "\C-c\C-c" 'compile))

(add-hook 'scala-mode-hook 'scala-mode-setup)
