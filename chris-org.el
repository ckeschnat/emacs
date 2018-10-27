(add-to-list 'auto-mode-alist '("\\.txt\\'" . org-mode))

(with-eval-after-load 'org
    ;; here goes your Org config :)
    ;; background colors for export http://ivanmalison.github.io/dotfiles/#setbackgroundcolorofsourceblocksforexport
    (use-package org
      :config
      (progn
        (defun imalison:org-inline-css-hook (exporter)
          "Insert custom inline css to automatically set the
  background of code to whatever theme I'm using's background"
          (when (eq exporter 'html)
            (let* ((my-pre-bg (face-background 'default))
                  (my-pre-fg (face-foreground 'default)))
              (setq
              org-html-head-extra
              (concat
                org-html-head-extra
                (format "<style type=\"text/css\">\n pre.src {background-color: %s; color: %s;}</style>\n"
                        my-pre-bg my-pre-fg))))))

        (add-hook 'org-export-before-processing-hook 'imalison:org-inline-css-hook)))

    (evil-define-key 'evilified org-agenda-mode-map (kbd "j") 'org-agenda-next-item)
    (evil-define-key 'evilified org-agenda-mode-map (kbd "k") 'org-agenda-previous-item)

    (load "~/.emacs.d/org-archive-subtree-hierarchical")

    (setq org-startup-indented t)
    (setq org-export-with-sub-superscripts nil)

    ;; (setq org-agenda-files (list "c:/Users/NOBODY/Documents/Seafile/docs/org"))
    ;; (setq org-default-notes-file "c:/Users/NOBODY/Documents/Seafile/docs/org/notes.org")
    (setq home-org-dir "c:/Users/NOBODY/Documents/Seafile/docs/org/")
    (setq work-org-dir "c:/Users/chris.keschnat/Documents/docs/org/")
    (setq org-agenda-files
          (cond ((file-directory-p home-org-dir) (list home-org-dir))
                ((file-directory-p work-org-dir) (list work-org-dir))
          )
    )

    (setq org-blank-before-new-entry '((heading . nil) (plain-list-item . nil)))

    (setq org-enforce-todo-dependencies t)
    (setq org-enforce-todo-checkbox-dependencies t)

    (setq org-log-redeadline (quote time))
    (setq org-log-reschedule (quote time))

    (setq org-default-notes-file (concat (car org-agenda-files) "inbox.org"))
    ;; More headings for refile
    ;; (setq org-refile-targets '((org-agenda-files . (:maxlevel . 6))))
    (setq org-refile-targets '((nil :maxlevel . 9)
                               (org-agenda-files :maxlevel . 9)))
    (setq org-refile-use-outline-path 'file)              ; Show full paths for refiling
    (setq org-outline-path-complete-in-steps nil)         ; Refile in a single go

    (setq helm-org-rifle-show-path t)
    ;; (defun +org-search ()
    ;;   (interactive)
    ;;   (org-refile '(4)))
    ;; (spacemacs/set-leader-keys "or" (lambda () (interactive) (org-refile '(4))))
    ;; TODO (spacemacs/set-leader-keys "or" 'helm-org-rifle-agenda-files)
    (setq org-refile-allow-creating-parent-nodes 'confirm)

    (setq org-todo-keyword-faces
          '(("TODO" . org-warning)
            ("NEXT" . org-todo)
            ("SOMEDAY" . (:foreground "moccasin" :weight bold))
            ("WAITING" . (:foreground "lavender blush" :weight bold))
            ("CANCELLED" . org-done)))

    (setq org-todo-keywords
          '((sequence "TODO(t)" "NEXT(n)" "WAITING(w)" "SOMEDAY(s)" "|" "CANCELLED(c)" "DONE(d)")))
    (setq org-tag-alist '(("@work" . ?w) ("@home" . ?h)))
                                        ; Tags with fast selection keys
    (setq org-tag-alist (quote (
                                ("@home" . ?h)
                                ("@work" . ?w)
                                ("WAITING" . ?w)
                                ("PERSONAL" . ?P)
                                ("WORK" . ?W)
                                ("NOTE" . ?n)
                                ("CANCELLED" . ?c)
                                ("FLAGGED" . ??)
                                )))

    (setq org-capture-templates
          (quote (("t" "todo" entry (file "") "* TODO %?\n%U\n%a\n")
                  ("n" "note" entry (file "") "* %? :NOTE:\n%U\n%a\n")
                  )))

    (add-to-list 'org-structure-template-alist
                 (list "hh" (concat "#+SETUPFILE: themes/theme-readtheorg-local.setup\n"
                                    "#+OPTIONS: html-postamble:nil num:nil\n"
                                    "#+FILETAGS: ?\n")))

    (add-to-list 'org-structure-template-alist
                 (list "p" (concat ":PROPERTIES:\n"
                                   "?\n"
                                   ":END:")))

    (add-to-list 'org-structure-template-alist
                 (list "eh" (concat ":EXPORT_FILE_NAME: ?\n"
                                    ":EXPORT_TITLE:\n"
                                    ":EXPORT_OPTIONS: html-postamble:nil num:nil")))


    (setq org-use-fast-todo-selection t)
    (setq org-todo-state-tags-triggers
          (quote (("CANCELLED" ("CANCELLED" . t))
                  ("WAITING" ("WAITING" . t))
                  (done ("WAITING"))
                  ("TODO" ("WAITING") ("CANCELLED"))
                  ("NEXT" ("WAITING") ("CANCELLED"))
                  ("DONE" ("WAITING") ("CANCELLED")))))


    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;; https://blog.aaronbieber.com/2016/09/24/an-agenda-for-life-with-org-mode.html
    ;; maybe use https://github.com/alphapapa/org-super-agenda

    (defun air-org-skip-subtree-if-priority (priority)
      "Skip an agenda subtree if it has a priority of PRIORITY.

      PRIORITY may be one of the characters ?A, ?B, or ?C."
      (let ((subtree-end (save-excursion (org-end-of-subtree t)))
            (pri-value (* 1000 (- org-lowest-priority priority)))
            (pri-current (org-get-priority (thing-at-point 'line t))))
        (if (= pri-value pri-current)
            subtree-end
          nil)))

    ;; (setq org-agenda-custom-commands
    ;;       '(("c" "Simple agenda view"
    ;;          ((tags "PRIORITY=\"A\""
    ;;                 ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
    ;;                  (org-agenda-overriding-header "High-priority unfinished tasks:")))
    ;;           (agenda "")
    ;;           (alltodo ""
    ;;                    ((org-agenda-skip-function
    ;;                      '(or (air-org-skip-subtree-if-priority ?A)
    ;;                           (org-agenda-skip-if nil '(scheduled deadline))))))))))

    (setq org-agenda-custom-commands
          '(("d" "Daily agenda and all TODOs"
             ((tags "PRIORITY=\"A\""
                    ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                     (org-agenda-overriding-header "High-priority unfinished tasks:")))
              (agenda "" ((org-agenda-span 'day)))
              (alltodo ""
                       ((org-agenda-skip-function '(or (air-org-skip-subtree-if-priority ?A)
                                                       (org-agenda-skip-if nil '(scheduled deadline))))
                        (org-agenda-overriding-header "ALL normal priority tasks:"))))
             ((org-agenda-compact-blocks t)))))


    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



    ;; (setq org-agenda-custom-commands
    ;;       (quote (("N" "Notes" tags "NOTE"
    ;;                (
    ;;                 (org-agenda-overriding-header "Notes")
    ;;                 (org-tags-match-list-sublevels t)
    ;;                 )
    ;;                )
    ;;              )
    ;;       )
    ;; )


    (setq org-hide-emphasis-markers t)

    (let* ((variable-tuple
        (cond ((x-list-fonts "Source Sans Pro") '(:font "Source Sans Pro"))
              ((x-list-fonts "Lucida Grande")   '(:font "Lucida Grande"))
              ((x-list-fonts "Verdana")         '(:font "Verdana"))
              ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
              (nil (warn "Cannot find a Sans Serif Font.  Install Source Sans Pro."))))
       (base-font-color     (face-foreground 'default nil 'default))
       (headline           `(:inherit default :weight bold :foreground ,base-font-color)))

    (custom-theme-set-faces
    'user
    `(org-level-8 ((t (,@headline ,@variable-tuple))))
    `(org-level-7 ((t (,@headline ,@variable-tuple))))
    `(org-level-6 ((t (,@headline ,@variable-tuple))))
    `(org-level-5 ((t (,@headline ,@variable-tuple))))
    `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.1))))
    `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.25))))
    `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.5))))
    `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.75))))
    `(org-document-title ((t (,@headline ,@variable-tuple :height 2.0 :underline nil))))))

    ;; circles instead of dashes in lists
    (font-lock-add-keywords 'org-mode
                            '(("^ *\\([-]\\) "
                               (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))
)
