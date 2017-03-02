;; ~/.emacs.d/org.el
;; Configuration for Emacs Org-mode

;; Include general recurring info (holidays, etc.) in Agenda
(setq org-agenda-include-diary t)

;; Some capture templates
(setq org-capture-templates
      '(("t" "Add a task to the TODO list." entry
         (file "~/documents/tasks.org")
         "* TODO [#A] %?
SCHEDULED: %t DEADLINE: %t")
        ("a" "Add an upcoming date to the calendar." entry
         (file "~/documents/dates.org")
         "* %? %t")))

;; Default task sequence
(setq org-todo-keywords
      '((sequence "TODO" "IN-PROGRESS" "WAITING" "|" "DONE" "CANCELED")))

;; Set colors for priorities
(setq org-priority-faces '((?A . (:foreground "#F0DFAF" :weight bold))
                           (?B . (:foreground "LightSteelBlue"))
                           (?C . (:foreground "OliveDrab"))))

;; Always open Agenda to replace the current window
(setq org-agenda-window-setup (quote current-window))

;; Don't show tasks as scheduled if they are already shown as a deadline
(setq org-agenda-skip-scheduled-if-deadline-is-shown t)

;; Sort tasks in order of when they are due and then by priority
(setq org-agenda-sorting-strategy
  (quote
   ((agenda deadline-up priority-down)
    (todo priority-down category-keep)
    (tags priority-down category-keep)
    (search category-keep))))

;; Global keybindings
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

;; Directory for Agenda files
(setq org-agenda-files '("~/documents/"))
