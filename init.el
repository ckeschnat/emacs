(require 'org) 
(org-babel-load-file (expand-file-name "config.org" user-emacs-directory))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (org-sticky-header ranger counsel use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-document-title ((t (:inherit default :weight bold :foreground "SystemWindowText" :font "Verdana" :height 2.0 :underline nil))))
 '(org-level-1 ((t (:inherit default :weight bold :foreground "SystemWindowText" :font "Verdana" :height 1.75))))
 '(org-level-2 ((t (:inherit default :weight bold :foreground "SystemWindowText" :font "Verdana" :height 1.5))))
 '(org-level-3 ((t (:inherit default :weight bold :foreground "SystemWindowText" :font "Verdana" :height 1.25))))
 '(org-level-4 ((t (:inherit default :weight bold :foreground "SystemWindowText" :font "Verdana" :height 1.1))))
 '(org-level-5 ((t (:inherit default :weight bold :foreground "SystemWindowText" :font "Verdana"))))
 '(org-level-6 ((t (:inherit default :weight bold :foreground "SystemWindowText" :font "Verdana"))))
 '(org-level-7 ((t (:inherit default :weight bold :foreground "SystemWindowText" :font "Verdana"))))
 '(org-level-8 ((t (:inherit default :weight bold :foreground "SystemWindowText" :font "Verdana")))))
