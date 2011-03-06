(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(setq org-agenda-files (list "/Users/sbraznikov/Dropbox/MobileOrg/index.org"))

(setq org-todo-keywords
      '((sequence "TODO" "WAIT" "|" "DONE")
        ))
