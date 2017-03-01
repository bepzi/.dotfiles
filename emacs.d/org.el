;; ~/.emacs.d/org.el
;; Configuration for Emacs Org-mode

;; Include general recurring info (holidays, etc.) in Agenda
(setq org-agenda-include-diary t)

;; Some capture templates
(setq org-capture-templates
      '(("t" "Add a task to the TODO list." entry
         (file "~/documents/tasks.org")
         "* TODO %?
SCHEDULED: %t DEADLINE: %t")
        ("a" "Add an upcoming date to the calendar." entry
         (file "~/documents/dates.org")
         "* %? %t")))

;; Default task sequence
(setq org-todo-keywords
      '((sequence "TODO" "IN-PROGRESS" "WAITING" "|" "DONE" "CANCELED")))

;; Global keybindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

;; Directory for agenda files
(setq org-agenda-files '("~/documents/"))
