(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(column-number-mode t)
 '(custom-enabled-themes nil)
 '(custom-safe-themes
   (quote
    ("c87cc60d01cf755375759d165c1d60d9586c6a31f0b5437a0378c2a93cfc8407" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "53e29ea3d0251198924328fd943d6ead860e9f47af8d22f0b764d11168455a8e" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" default)))
 '(fci-rule-color "#343d46")
 '(menu-bar-mode nil)
 '(show-paren-mode t)
 '(tool-bar-mode nil)
 '(tool-bar-position (quote top))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#bf616a")
     (40 . "#DCA432")
     (60 . "#ebcb8b")
     (80 . "#B4EB89")
     (100 . "#89EBCA")
     (120 . "#89AAEB")
     (140 . "#C189EB")
     (160 . "#bf616a")
     (180 . "#DCA432")
     (200 . "#ebcb8b")
     (220 . "#B4EB89")
     (240 . "#89EBCA")
     (260 . "#89AAEB")
     (280 . "#C189EB")
     (300 . "#bf616a")
     (320 . "#DCA432")
     (340 . "#ebcb8b")
     (360 . "#B4EB89"))))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "unknown" :slant normal :weight normal :height 98 :width normal)))))

(load "package")
(package-initialize)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(setq package-archive-enable-alist '(("melpa" deft magit)))

;; Default packages to be installed
(defvar abedra/packages '(ac-slime
                          auto-complete
                          autopair
                          clojure-mode
                          coffee-mode
                          csharp-mode
                          deft
                          erlang
                          feature-mode
                          flycheck
                          gist
                          go-mode
                          graphviz-dot-mode
                          haml-mode
                          haskell-mode
                          htmlize
                          magit
                          markdown-mode
                          marmalade
                          nodejs-repl
                          o-blog
                          org
                          paredit
                          php-mode
                          puppet-mode
                          restclient
                          rvm
                          scala-mode
                          smex
                          sml-mode
                          solarized-theme
                          spacegray-theme
                          web-mode
                          writegood-mode
                          yaml-mode
                          hlinum
                          matlab-mode
                          jedi
                          jazz-theme
                          zenburn
                          yasnippet
                          auto-complete-clang
                          popup
                          haxe-mode)
  "Default packages")

(require 'cl)
;; Install Default Packages
(defun abedra/packages-installed-p ()
  (loop for pkg in abedra/packages
        when (not (package-installed-p pkg)) do (return nil)
        finally (return t)))

(unless (abedra/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg abedra/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

(setq inhibit-splash-screen t
      initial-scratch-message nil
      initial-major-mode 'org-mode)

(require 'cc-mode)
;;(require 'haxe-mode)

;;; yasnippet
;;; should be loaded before auto complete so that they can work together
(require 'yasnippet)
(yas-global-mode 1)

;; Makes the default C-indentation not look like shit
(setq c-default-style "linux"
      c-basic-offset 4)

;; I have some modifications to the default display. First, a minor tweak to the frame title.
;; It's also nice to be able to see when a file actually ends. This will put empty line markers into the left hand side.
(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b"))))

(setq-default indicate-empty-lines t)
(when (not indicate-empty-lines)
  (toggle-indicate-empty-lines))


(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)

;;There's nothing I dislike more than tabs in my files. Make sure I don't share that discomfort with others.
(setq tab-width 2
      indent-tabs-mode nil)

;; Some people like to have them. I don't. Rather than pushing them to a folder, never to be used, just turn the whole thing off.
(setq make-backup-files nil)

;; Ido. Browse file system
(ido-mode t)
(setq ido-enable-flex-matching t
      ido-use-virtual-buffers t)

;; Indentation and buffer cleanup
;; This re-indents, untabifies, and cleans up whitespace. It is stolen directly from the emacs-starter-kit.
(defun untabify-buffer ()
  (interactive)
  (untabify (point-min) (point-max)))

(defun indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(defun cleanup-buffer ()
  "Perform a bunch of operations on the whitespace content of a buffer."
  (interactive)
  (indent-buffer)
  (untabify-buffer)
  (delete-trailing-whitespace))

(defun cleanup-region (beg end)
  "Remove tmux artifacts from region."
  (interactive "r")
  (dolist (re '("\\\\│\·*\n" "\W*│\·*"))
    (replace-regexp re "" nil beg end)))

(global-set-key (kbd "C-x M-t") 'cleanup-region)
(global-set-key (kbd "C-c n") 'cleanup-buffer)

(setq-default show-trailing-whitespace t)

;; Nobody likes to have to type out the full yes or no when Emacs asks. Which it does often. Make it one character.
(defalias 'yes-or-no-p 'y-or-n-p)

;; Miscellaneous key binding stuff that doesn't fit anywhere else.
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-;") 'comment-or-uncomment-region)
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-c C-k") 'compile)
(global-set-key (kbd "C-x g") 'magit-status)

;; This makes sure that brace structures (), [], {}, etc. are closed as soon as the opening character is typed.
(require 'autopair)
;;hoppla
(autopair-global-mode 1)
(setq autopair-autowrap t)

(add-to-list 'load-path "~/.emacs.d/custom-packages")
;;(require 'member-functions)
;;(setq mf--source-file-extension "cpp")

(require 'member-functions)

;;expand member functions automatically when entering a cpp file
(defun c-file-enter ()
  "Expands all member functions in the corresponding .h file"
  (let* ((c-file (buffer-file-name (current-buffer)))
         (h-file-list (list (concat (substring c-file 0 -3 ) "h")
                            (concat (substring c-file 0 -3 ) "hpp")
                            (concat (substring c-file 0 -1 ) "h")
                            (concat (substring c-file 0 -1 ) "hpp"))))
    (if (or (equal (substring c-file -2 ) ".c")
            (equal (substring c-file -4 ) ".cpp")
            (equal (substring c-file -8 ) ".cc"))
        (mapcar (lambda (h-file)
                  (if (file-exists-p h-file)
                      (expand-member-functions h-file c-file)))
                h-file-list))))

(add-hook 'c++-mode-hook 'c-file-enter)

;;; auto complete mod
;;; should be loaded after yasnippet so that they can work together
(require 'auto-complete-config)

;;(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auto-complete-20150116.1520/dict/")
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)

;; Start auto-completion after 2 characters of a word
(setq ac-auto-start 2)

;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")

(require 'auto-complete-clang)
(define-key c++-mode-map (kbd "C-<tab>") 'ac-complete-clang)
;; replace C-S-<return> with a key binding that you want

(setq ac-clang-flags
      (mapcar (lambda (item)(concat "-I" item))
              (split-string
               "
 /usr/lib/gcc/x86_64-pc-cygwin/4.9.2/include/c++
 /usr/lib/gcc/x86_64-pc-cygwin/4.9.2/include/c++/x86_64-pc-cygwin
 /usr/lib/gcc/x86_64-pc-cygwin/4.9.2/include/c++/backward
 /usr/lib/gcc/x86_64-pc-cygwin/4.9.2/include
 /usr/lib/gcc/x86_64-pc-cygwin/4.9.2/include-fixed
 /usr/include
 /usr/lib/gcc/x86_64-pc-cygwin/4.9.2/../../../../lib/../include/w32api
"
               )))

(cond ((eq system-type 'windows-nt)
       (setq ac-clang-flags
             (mapcar (lambda (item)(concat "-I" item))
                     (split-string
                      "
 /usr/lib/gcc/x86_64-pc-cygwin/4.9.2/include/c++
 /usr/lib/gcc/x86_64-pc-cygwin/4.9.2/include/c++/x86_64-pc-cygwin
 /usr/lib/gcc/x86_64-pc-cygwin/4.9.2/include/c++/backward
 /usr/lib/gcc/x86_64-pc-cygwin/4.9.2/include
 /usr/lib/gcc/x86_64-pc-cygwin/4.9.2/include-fixed
 /usr/include
 /usr/lib/gcc/x86_64-pc-cygwin/4.9.2/../../../../lib/../include/w32api
"
                      ))))
      ((eq system-type 'gnu/linux)
       (setq ac-clang-flags
             (mapcar (lambda (item)(concat "-I" item))
                     (split-string
                      "
 /usr/include/c++/4.7
 /usr/include/c++/4.7/x86_64-linux-gnu
 /usr/include/c++/4.7/backward
 /usr/lib/gcc/x86_64-linux-gnu/4.7/include
 /usr/local/include
 /usr/lib/gcc/x86_64-linux-gnu/4.7/include-fixed
 /usr/include/x86_64-linux-gnu
 /usr/include

"
                      )))))


;; Load spacegray if in a graphical environment. Load the wombat theme if in a terminal.
(if window-system
    (load-theme 'jazz t)
  (load-theme 'wombat t))

;; --------------
;; Language Hooks
;; --------------

;; Web mode
(add-to-list 'auto-mode-alist '("\\.hbs$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb$" . web-mode))

;; Ruby
(add-hook 'ruby-mode-hook
          (lambda ()
            (autopair-mode)))

(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile" . ruby-mode))

;; RVM: Enable Ruby Version Manager mode and tell it to use the default Ruby.
(rvm-use-default)

;; YAML
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))

;; CoffeeScript Mode
(defun coffee-custom ()
  "coffee-mode-hook"
  (make-local-variable 'tab-width)
  (set 'tab-width 2))

(add-hook 'coffee-mode-hook 'coffee-custom)

;; JavaScript Mode
(defun js-custom ()
  "js-mode-hook"
  (setq js-indent-level 2))

(add-hook 'js-mode-hook 'js-custom)

;; Markdown Mode
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.mdown$" . markdown-mode))
(add-hook 'markdown-mode-hook
          (lambda ()
            (visual-line-mode t)
            (writegood-mode t)
            (flyspell-mode t)))
(setq markdown-command "pandoc --smart -f markdown -t html")
;;(setq markdown-css-path (expand-file-name "markdown.css" abedra/vendor-dir))



(setq initial-frame-alist '((top . 0) (left . 0) (width . 80) (height . 30)))

;; I like to see what is selected in the buffer.  This turns on visual
;; feedback on selections.
(setq transient-mark-mode t)

                                        ; Temporary files cluttering up the space are annoying.  Here's how we
                                        ; can deal with them -- create a directory in your home directory, and
                                        ; save to there instead!  No more random ~ files.
(defvar user-temporary-file-directory
  "~/.emacs-autosaves/")
(make-directory user-temporary-file-directory t)
(setq backup-by-copying t)
(setq backup-directory-alist
      `(("." . ,user-temporary-file-directory)
        (tramp-file-name-regexp nil)))
(setq auto-save-list-file-prefix
      (concat user-temporary-file-directory ".auto-saves-"))
(setq auto-save-file-name-transforms
      `((".*" ,user-temporary-file-directory t)))

;; set keybindings
(global-set-key [f4] 'goto-line)

;; Activate font-lock mode (syntax coloring).
(global-font-lock-mode t)

;; Line numbers are good.  Getting column numbering as well is better.
(column-number-mode t)

;; Always end files in a newline.
(setq require-final-newline 't)


(global-linum-mode 1)

(defadvice linum-update-window (around linum-dynamic activate)
  (let* ((w (length (number-to-string
                     (count-lines (point-min) (point-max)))))
         (linum-format (concat " %" (number-to-string w) "d ")))
    ad-do-it))

(require 'hlinum)
(hlinum-activate)

;;(require 'flymake)


(defun switch-full-screen ()
  (interactive)
  (shell-command "wmctrl -r :ACTIVE: -btoggle,fullscreen"))

;;(if (eq system-type 'gnu/linux) (global-set-key [f11] 'switch-full-screen))
