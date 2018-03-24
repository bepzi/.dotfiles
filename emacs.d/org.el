;; ~/.emacs.d/org.el
;; Configuration for Emacs Org-mode

;; Add support for markdown
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

;; Allow org to export as Markdown
(use-package ox-gfm
  :ensure t)
(eval-after-load "org"
  '(require 'ox-gfm nil t))

'(org-export-backends (quote (ascii html icalendar latex md)))

;; Directory for Agenda files
(setq org-agenda-files '("~/documents/gtd"))

;; Include general recurring info (holidays, etc.) in Agenda
(setq org-agenda-include-diary t)

;; Capture templates
(setq org-capture-templates '(("t" "Todo [inbox]" entry
                               (file+headline "~/documents/gtd/inbox.org" "Tasks")
                               "* TODO %i%?")
                              ("T" "Tickler" entry
                               (file+headline "~/documents/gtd/tickler.org" "Tickler")
                               "* %i%? \n %U")))

(setq org-refile-targets '(("~/documents/gtd/gtd.org" :maxlevel . 3)
                           ("~/documents/gtd/someday.org" :level . 1)
                           ("~/documents/gtd/tickler.org" :maxlevel . 2)))

;; Default task sequence
(setq org-todo-keywords
      '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELED(c)")))

;; Set priority range from A to C with default A
(setq org-highest-priority ?A)
(setq org-lowest-priority ?C)
(setq org-default-priority ?B)

;; Always open Agenda to replace the current window
(setq org-agenda-window-setup (quote current-window))

;; How many days ahead the agenda view should look
(setq org-agenda-ndays 7)

;; How many days early until a deadline item starts appearing
(setq org-deadline-warning-days 14)

;; Show days that don't have anything scheduled on them
(setq org-agenda-show-all-dates t)

;; Don't show tasks as scheduled if they are already shown as a deadline
(setq org-agenda-skip-scheduled-if-deadline-is-shown t)

;; Hide deadline/scheduled tasks if they're done
(setq org-agenda-skip-deadline-if-done t)
(setq org-agenda-skip-scheduled-if-done t)

;; Begin the agenda view on the current day, not Sunday
(setq org-agenda-start-on-weekday nil)

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
