;; ~/.emacs.d/functional.el
;; Configuration file for how Emacs handles functional languages

(use-package racket-mode
  :ensure t)

;; Haskell stuff
(use-package flycheck
  :ensure t)

(use-package haskell-mode
  :ensure t)

(use-package intero
  :ensure t)

; (add-hook 'haskell-mode-hook 'intero-mode)
; (setq flycheck-check-syntax-automatically '(save new-line))
; (flycheck-add-next-checker 'intero '(warning . haskell-hlint))
