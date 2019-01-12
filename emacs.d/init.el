;;; init.el --- Entry point for Emacs configuration
;;; Commentary:
;;
;; Loads the literate config file, then runs all of the included
;; elisp.

;;; Code:

;; Automatically follow symlinks without prompting
;; Necessary since we use symlinks to manage our config files
(setq vc-follow-symlinks t)

(org-babel-load-file "~/.emacs.d/emacs-config.org")

;;; init.el ends here
