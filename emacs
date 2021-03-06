;; Cameron Spickert
;; October 4, 2011

;; Tab behavior
(setq-default standard-indent 2)
(setq-default indent-tabs-mode nil)

;; Backup file behavior
(setq make-backup-files t)
(setq version-control t)
(setq backup-directory-alist (quote ((".*" . "~/.emacs_backups/"))))

;; Show line numbers
(line-number-mode 1)

;; Fill column setting
(setq-default fill-column 72)

;; Load path
(add-to-list 'load-path "~/.emacs.d/site-lisp/")

;; Hide the toolbar
(if window-system
    (tool-bar-mode -1))
