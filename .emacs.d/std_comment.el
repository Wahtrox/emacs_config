;;
;; std_comment.el for  in /home/marand_a/le-gay_t/childporn
;;
;; Made by antoine marandon
;; Login   <marand_a@epitech.net>
;;
;; Started onFri Apr 30 12:05:23 2010 antoine marandon
;; Last update Sat Feb 12 15:23:22 2011 estelle follet
;;

(global-set-key "h" 'update-std-header)
(global-set-key	"" 'do_insert_time)
(global-set-key	"" 'std-file-header)

(setq header-made-by	"Made by "
      header-login	"Login   "
      header-login-beg	"<"
      header-login-mid	"@"
      header-login-end	">"
      header-started	"Started on "
      header-last	"Last update "
      header-for	" for "
      header-in		" in "
      domaine-name	"epitech.net")
(if (setq user-nickname (getenv "USER_NICKNAME"))
    t
  (setq user-nickname (user-full-name))
)

(setq write-file-hooks (cons 'update-std-header write-file-hooks))

(setq std-c-alist               '( (cs . "/*") (cc . "** ") (ce . "*/") )
      std-css-alist             '( (cs . "/*") (cc . "** ") (ce . "*/") )
      std-cpp-alist             '( (cs . "//") (cc . "// ") (ce . "//") )
      std-pov-alist             '( (cs . "//") (cc . "// ") (ce . "//") )
      std-java-alist            '( (cs . "//") (cc . "// ") (ce . "//") )
      std-latex-alist           '( (cs . "%%") (cc . "%% ") (ce . "%%") )
      std-lisp-alist            '( (cs . ";;") (cc . ";; ") (ce . ";;") )
      std-fortran-alist         '( (cs . "! ") (cc . "! ") (ce . "! ") )
      std-xdefault-alist        '( (cs . "!!") (cc . "!! ") (ce . "!!") )
      std-pascal-alist          '( (cs . "{ ") (cc . "   ") (ce . "}" ) )
      std-makefile-alist        '( (cs . "##") (cc . "## ") (ce . "##") )
      std-text-alist            '( (cs . "##") (cc . "## ") (ce . "##") )
      std-fundamental-alist     '( (cs . "  ") (cc . "   ") (ce . "  ") )
      std-html-alist            '( (cs . "<!--") (cc . "  -- ") (ce . "-->"))
      std-php-alist		'( (cs . "#!/usr/local/bin/php\n<?php") (cc . "// ")(ce . "//"))
      std-nroff-alist           '( (cs . "\\\"") (cc . "\\\" ") (ce . "\\\""))
      std-sscript-alist         '( (cs . "#!/bin/sh")  (cc . "## ") (ce . "##"))
      std-perl-alist            '( (cs . "#!/usr/local/bin/perl -w")  (cc . "## ")(ce . "##"))
      std-cperl-alist           '( (cs . "#!/usr/local/bin/perl -w")  (cc . "## ")(ce . "##"))
      )


(setq std-modes-alist '(("C"                    . std-c-alist)
			("C/l"                  . std-c-alist)
			("ObjC/l"               . std-c-alist)
                        ("CSS"                  . std-c-alist)
                        ("PoV"                  . std-pov-alist)
                        ("C++"                  . std-cpp-alist)
                        ("C++/l"                . std-cpp-alist)
                        ("Lisp"                 . std-lisp-alist)
                        ("Lisp Interaction"     . std-lisp-alist)
                        ("Emacs-Lisp"           . std-lisp-alist)
                        ("Fundamental"          . std-fundamental-alist)
                        ("Shell-script"         . std-sscript-alist)
                        ("Makefile"             . std-makefile-alist)
                        ("GNUmakefile"          . std-makefile-alist)
                        ("BSDmakefile"          . std-makefile-alist)
                        ("Perl"                 . std-cperl-alist)
                        ("CPerl"                . std-cperl-alist)
                        ("xdefault"             . std-xdefault-alist)
                        ("java"                 . std-java-alist)
                        ("latex"                . std-latex-alist)
                        ("Pascal"               . stdp-ascal-alist)
                        ("Text"                 . std-text-alist)
                        ("HTML"                 . std-html-alist)
			("PHP"		        . std-php-alist)
                        ("Nroff"                . std-nroff-alist)
                        ("Assembler"            . std-lisp-alist)
                        ("TeX"                  . std-latex-alist)
                        ("LaTeX"                . std-latex-alist)
                        ("Fortran"              . std-fortran-alist))
      )

(defun std-get (a)
  (interactive)
  (cdr (assoc a (eval (cdr (assoc mode-name std-modes-alist)))))
  )

(defun update-std-header ()
  "Updates std header with last modification time & owner.\n(According to mode)"
  (interactive)
  (save-excursion
    (if (buffer-modified-p)
        (progn
          (goto-char (point-min))
          (if (search-forward header-last nil t)
              (progn
;               (delete-region (point-at-bol) (point-at-eol))
                (delete-region
                 (progn (beginning-of-line) (point))
                 (progn (end-of-line) (point)))
                (insert (concat (std-get 'cc)
                                       header-last
                                       (current-time-string)
                                       " "
                                       user-nickname))
                (message "Last modification header field updated."))))))
  nil)

(defun std-file-header ()
  "Puts a standard header at the beginning of the file.\n(According to mode)"
  (interactive)
  (goto-char (point-min))
  (let ((projname "toto")(location "tiuti"))
    (setq projname (read-from-minibuffer
		    (format "Type project name (RETURN to quit) : ")))
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
			   (getenv "USER")
			   header-login-mid
			   domaine-name
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
    (newline)))

(defun insert-std-vertical-comments ()
  "Inserts vertical comments (according to mode)."
  (interactive)
  (beginning-of-line)
  (insert (std-get 'cs))
  (newline)
  (let ((ok t)(comment ""))
    (while ok
      (setq comment (read-from-minibuffer
		     (format "Type comment (RETURN to quit) : ")))
      (if (= 0 (length comment))
	  (setq ok nil)
	(progn
	  (insert (concat (std-get 'cc) comment))
	  (newline)))))
  (insert (std-get 'ce))
  (newline))

(defun std-toggle-comment ()
  "Toggles line comment on or off (according to mode)."
  (interactive)
  (save-excursion
    (let (beg end)
      (beginning-of-line)
      (setq beg (point))
      (end-of-line)
      (setq end (point))
      (save-restriction
	(if (not (equal beg end))
	    (progn
	      (narrow-to-region beg end)
	      (goto-char beg)
	      (if (search-forward (std-get 'cs) end t)
		  (progn
		    (beginning-of-line)
		    (replace-string (std-get 'cs) "")
		    (replace-string (std-get 'ce) ""))
		(progn
		  (beginning-of-line)
		  (insert (std-get 'cs))
		  (end-of-line)
		  (insert (std-get 'ce)))))))))
  ;;  (indent-according-to-mode)
  (indent-for-tab-command)
  (next-line 1))

;;; Added by Eole Wednesday May 29 2002,  1:33:55
;;; Extended bindings for this package and for commenting code

(global-set-key "h" 'update-std-header)
(global-set-key "" 'std-file-header)

;;;; Generating local keymaps for exotics modes.

;;; In CPerl mode, C-c C-h is used to do some help.
;;; so it is C-c C-h h
;;; For working, it requires info pages about perl
(add-hook 'cperl-mode-hook
	  '(lambda ()
	     (define-key cperl-mode-map ""
	       'comment-region)
	     (define-key cperl-mode-map "h"
	       'std-file-header)))

;; for perl-mode
(add-hook 'perl-mode-hook
	  '(lambda ()
	     (define-key perl-mode-map ""
	       'comment-region)))

;; for all kind of lisp code
(add-hook 'emacs-lisp-mode-hook
 	  '(lambda ()
 	     (define-key emacs-lisp-mode-map  ""
 	       'comment-region)))

(add-hook 'lisp-mode-hook
 	  '(lambda ()
 	     (define-key lisp-mode-map  ""
 	       'comment-region)))



;; for La(TeX)-mode
(add-hook 'tex-mode-hook
	  '(lambda ()
	     (define-key tex-mode-map ""
	       'comment-region)))

