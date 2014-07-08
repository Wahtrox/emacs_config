;; BOCAL STAFF 2010-2011
;; FEDORA DUMP

(load "~/.emacs.d/std.el")
(load "~/.emacs.d/std_comment.el")
(load "~/.emacs.d/std_comment.elc")		;; Epitech classic header
(load "~/.emacs.d/std.elc")			;; Epitech classic header

(add-to-list 'load-path "~/.emacs.d")
(add-to-list 'load-path "~/.emacs.d/tools")
(add-to-list 'load-path "~/.emacs.d/modes")
(add-to-list 'load-path "~/.emacs.d/epitech")
(add-to-list 'load-path "~/.emacs.d/colors")

(require 'std_comment)
(require 'list-sources)
(require 'gnus-conf)
(require 'smalltalk-mode)
(require 'django-html-mode)
(require 'auto-complete)
(require 'auto-complete-words)
(require 'episnippet)
(require 'php-mode)
(require 'highlight-parentheses)
(require 'lua-mode)
(require 'd-mode)

(add-to-list 'auto-mode-alist '("\\.go$" . c-mode))
(add-to-list 'auto-mode-alist '("\\.d$" . d-mode))
(add-to-list 'auto-mode-alist '("\\.pl$" . cperl-mode))
(add-to-list 'auto-mode-alist '("\\.pm$" . cperl-mode))
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.tpl$" . sgml-mode))
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'auto-mode-alist '("dot.emacs$" . emacs-lisp-mode))
(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.eliom$" . tuareg-mode))
(add-to-list 'auto-mode-alist '("\\.eliomi$" . tuareg-mode))
(add-to-list 'auto-mode-alist '("\\.ml$" . tuareg-mode))
(add-to-list 'auto-mode-alist '("\\.mli$" . tuareg-mode))

(if (file-exists-p "~/.myemacs")
    (load-file "~/.myemacs"))
; EOF
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(cua-mode t nil (cua-base))
 '(display-time-mode t)
 '(fringe-mode 0 nil (fringe))
 '(global-auto-complete-mode t)
 '(inhibit-startup-screen t)
 '(nil nil t)
 '(normal-erase-is-backspacenormal-erase-is-backspace-mode 1 t)
 '(pong-timer-delay 0.02)
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(size-indication-mode t))
(defun insert-shell-shebang ()		;; Shell auto insertion
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (insert "#!/bin/sh\n\n")))

(defun insert-header-guard ()		;; Auto insertion in header file
  (interactive)
  (save-excursion
    (when (buffer-file-name)
          (goto-char (point-min))
        (let*
            ((name (file-name-nondirectory buffer-file-name))
             (macro (replace-regexp-in-string
                     "\\." "_"
                     (replace-regexp-in-string
                      "-" "_"
                      (upcase name)))))
          (insert "#ifndef " macro "_\n")
          (insert "# define " macro "_\n\n")
          (goto-char (point-max))
          (insert "\n#endif /* !" macro "_ */\n")))
    (insert-header-epitech)))



(defun insert-header-epitech ()
  "Puts a standard header at the beginning of the file."
  (interactive)
  (goto-char (point-min))
  (let ((projname (file-name-sans-extension (file-name-nondirectory buffer-file-name)))(location " "))
    (setq location (getenv "PWD"))

    (insert (std-get 'cs))
    (newline)
    (insert (concat (std-get 'cc)
		    (buffer-name)
		    header-for
		      projname
		      header-in
		      location))
      (newline)
      (insert (std-get 'cc))
      (newline)
      (insert (concat (std-get 'cc) header-made-by user-nickname))
      (newline)
      (insert (concat (std-get 'cc)
		      header-login
		      header-login-beg
		      user-mail-address
		      header-login-end))
      (newline)
      (insert (std-get 'cc))
      (newline)
      (insert (concat (std-get 'cc)
		      header-started
		      (current-time-string)
		      " "
		      user-nickname))
      (newline)
      (insert (concat (std-get 'cc)
		      header-last
		      (current-time-string)
		      " "
		      user-nickname))
      (newline)
      (insert (std-get 'ce))
      (newline)
      (newline)))

(defun insert-header ()
  (interactive))

;;;;;;;;;;;;;;;;;
;; Auto Insert ;;
;;;;;;;;;;;;;;;;;

(add-hook 'find-file-hooks
	  (lambda ()
	    (when (and (memq major-mode '(c-mode c++-mode)) (equal (point-min) (point-max)) (string-match ".*\\.hh?" (buffer-file-name)))
	      (insert-header-guard)
	      (goto-line 14)
	      (newline)
	      (goto-line 14)
	      )
	    (when (and (memq major-mode '(c-mode c++-mode)) (equal (point-min) (point-max)) (string-match ".*\\.cc?" (buffer-file-name)))
	      (insert-header-epitech)
	      (goto-line 11)
	      )
	    ))

(defun refresh-file ()
  (interactive)
  (revert-buffer t t t)
  (load-file "~/.emacs")
)

;; Don't switch to GDB-mode buffers
(setq ido-ignore-buffers (quote ("\\`\\*breakpoints of.*\\*\\'"
  "\\`\\*stack frames of.*\\*\\'" "\\`\\*gud\\*\\'"
  "\\`\\*locals of.*\\*\\'"  "\\` ")))
;; Better GDB-mode
(setq-default gdb-many-windows t)

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight bold :height 98 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))
