(defvar my-ibuffer-filter-groups nil)

(require 'mouse-copy)
(require 'mouse-drag)
(require 'ls-lisp)
(require 'dired-x)

(add-to-list 'load-path "~/.emacs.d/lisp")

(require 'yasnippet-bundle)
(require 'xcscope nil t)
(require 'w3m-load nil t)
(require 'kmacros)

(load "~/.emacs.pre" t)

(autoload 'slime "slime/slime" nil t)
(autoload 'haskell-mode "haskell-mode/haskell-site-file" nil t)
(autoload 'ruby-mode "ruby-mode" nil t)
(autoload 'sawfish-mode "sawfish" nil t)
(autoload 'cmake-mode "cmake-mode" nil t)
(autoload 'visual-basic-mode "visual-basic-mode" "" t)
(autoload 'run-prolog "prolog" "Start a Prolog sub-process." t)
(autoload 'prolog-mode "prolog" "Major mode for editing Prolog programs." t)
(autoload 'mercury-mode "prolog" "Major mode for editing Mercury programs." t)
(autoload 'tuareg-mode "tuareg-mode/tuareg" "Major mode for editing Caml code" t)
(autoload 'camldebug "tuareg-mode/camldebug" "Run the Caml debugger" t)

(fset 'yes-or-no-p 'y-or-n-p)
(setq comint-input-ring-size 10000)
(setq disabled-command-function nil)
(setq echo-keystrokes 0.1)
(setq hippie-expand-try-functions-list
  '(try-expand-local-abbrevs
    try-expand-dabbrev
    try-expand-list
    try-expand-line
    try-expand-dabbrev-all-buffers
    try-complete-file-name-partially
    try-complete-file-name
    try-expand-dabbrev-from-kill
    try-expand-all-abbrevs
    try-complete-lisp-symbol-partially
    try-complete-lisp-symbol))
(setq prolog-system 'gnu)

;;;; keys

(ffap-bindings)
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "M-X") 'in-directory)
(global-set-key (kbd "<C-tab>") 'indent-relative)
(global-set-key (kbd "<M-SPC>") 'fixup-whitespace)
(global-set-key (kbd "M-/") 'hippie-expand)
(global-set-key (kbd "M-RET") 'iswitchb-buffer)
(global-set-key (kbd "M-`") 'iswitchb-buffer)
(global-set-key (kbd "M-n") 'forward-paragraph)
(global-set-key (kbd "M-p") 'backward-paragraph)
(global-set-key (kbd "<C-up>") (lambda ()
                                 (interactive)
                                 (enlarge-window 4)))
(global-set-key (kbd "<C-down>") (lambda ()
                                   (interactive)
                                   (shrink-window 4)))
(global-set-key (kbd "C-<right>") 'forward-page-recenter)
(global-set-key (kbd "C-<left>") 'backward-page-recenter)
(global-set-key (kbd "C-x C-k") 'bury-buffer)
(global-set-key (kbd "C-x C-b") 'ibuffer-other-window)
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "M-]") 'next-error)
(global-set-key (kbd "M-[") 'previous-error)
(global-set-key (kbd "C-M-;") 'comment-or-uncomment-line)
(global-set-key (kbd "<f1>") 'other-window)
(global-set-key (kbd "C-S-n") 'other-window)
(global-set-key (kbd "C-S-p") (lambda () (interactive) (other-window -1)))
(global-set-key (kbd "C-S-b") 'windmove-left)
(global-set-key (kbd "C-S-f") 'windmove-right)
(global-set-key (kbd "<f2>") 'show-sections)
(global-set-key (kbd "<f5>") 'compile-dwim)
(global-set-key (kbd "<f6>") 'query-replace)
(global-set-key (kbd "<f7>") 'query-replace-regexp)
(global-set-key (kbd "<f8>") 'shell-dwim)
(global-set-key (kbd "<f9>") 'grep-dwim)
(global-set-key (kbd "<f10>") 'occur-current-word)
(global-set-key (kbd "<pause>") 'font-lock-fontify-buffer)
(global-set-key (kbd "<down-mouse-3>") 'mouse-drag-drag)
(global-unset-key (kbd "<S-down-mouse-1>"))
(global-set-key (kbd "<M-down-mouse-1>") 'mouse-drag-secondary-pasting)
(global-set-key (kbd "<S-mouse-1>") 'occur-current-word-mouse)
(global-set-key (kbd "<mouse-3>") 'ffap-at-mouse)
(global-set-key (kbd "<S-mouse-3>") 'ffap-at-mouse-other-window)
(global-set-key (quote [67108913]) 'delete-other-windows)    ;C-1
(global-set-key (quote [67108914]) 'split-window-vertically) ;C-2
(global-set-key (quote [67108915]) 'split-window-horizontally) ;C-3
(global-set-key (quote [67108912]) 'delete-window)           ;C-0

(define-key query-replace-map "p" 'backup)

(defvar my-keymap (make-sparse-keymap))
(defvar my-keymap2 (make-sparse-keymap))

(global-set-key (kbd "C-;") my-keymap)
(define-key my-keymap (kbd "e") 'ediff-buffers)
(define-key my-keymap (kbd "c") 'calculator)
(define-key my-keymap (kbd "d") 'insert-date)
(define-key my-keymap (kbd "f") 'find-name-dired)
(define-key my-keymap (kbd "F") 'find-dired)
(define-key my-keymap (kbd "g") 'grep-dwim)
(define-key my-keymap (kbd "o") 'occur-current-word)
(define-key my-keymap (kbd "r") 'recentf-open-files)
(define-key my-keymap (kbd "t") 'set-tab-width)
(define-key my-keymap (kbd "C-;") my-keymap2)
(define-key my-keymap2 (kbd "g") (lambda ()
                                   (interactive)
                                   (grep-dwim t)))


;;;; modes

(auto-fill-mode nil)

(add-to-list 'auto-mode-alist '("\\.bas$" . visual-basic-mode))
(add-to-list 'auto-mode-alist '("\\.cmake$" . cmake-mode))
(add-to-list 'auto-mode-alist '("CMakeLists\\.txt$" . cmake-mode))
(add-to-list 'auto-mode-alist '("CMakeCache\\.txt$" . conf-mode))
(add-to-list 'auto-mode-alist '("\\.hdl$" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hs$" . haskell-mode))
(add-to-list 'auto-mode-alist '("\\.mak$" . makefile-mode))
(add-to-list 'auto-mode-alist '("\\.ml\\w?" . tuareg-mode))
(add-to-list 'auto-mode-alist '("kmail.*\\.tmp$" . mail-mode))
(add-to-list 'auto-mode-alist '("sylpheed.*/tmp/" . mail-mode))
(add-to-list 'auto-mode-alist '("\\.th$" . conf-mode))
(add-to-list 'auto-mode-alist '("^/tmp/diff.*$" . diff-mode))
(add-to-list 'auto-mode-alist '("^/tmp/zsh.*$" . sh-mode))

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

(add-hook 'c-mode-common-hook 'c-subword-mode)
(add-hook 'c-mode-common-hook 'c-toggle-hungry-state)
(add-hook 'c-mode-common-hook 'hide-ifdef-mode)
(add-hook 'c-mode-common-hook 'hs-minor-mode)
(add-hook 'c-mode-common-hook 'my-c-mode-common)

(c-add-style "gnu++"
 '("gnu"
   (comment-start . "// ")
   (comment-end . "")
   (c-cleanup-list . (defun-close-semi
                      list-close-comma
                      scope-operator
                      comment-close-slash
                      space-before-funcall
                      compact-empty-funcall))
   (c-offsets-alist . ((arglist-intro . ++)
		       (innamespace . 0)
		       (member-init-intro . 2)
		       (member-init-cont . 0)
		       (func-decl-cont . 2)
		       (inextern-lang . 0)))))

(c-add-style "gnudv"
 '("gnu++"
   (c-basic-offset . 4)
   (c-offsets-alist . ((substatement-open . 0)
                       (statement-case-open . 2)))))


(defun my-c-mode-common ()
  (setq abbrev-mode nil)
  (define-section-marker "^////")
  (local-set-key (kbd "<f2>") (occur-binding "^\\("
                                             "\\|"
                                             "[a-zA-Z0-9_:~]+\\s *(\\|"
                                             ;; "struct [a-zA-Z0-9_]+\\|"
                                             ;; "static struct [a-zA-Z0-9_]+\\|"
                                             ;; "class [a-zA-Z0-9_]+\\|"
                                             "#define *[a-zA-Z0-9_]*(\\|"
                                             "/////"
                                             "\\)"))
  (local-set-key (kbd "RET") 'c-context-line-break)
  (local-set-key (kbd "C-5") (lambda ()
                               (interactive)
                               (ff-find-other-file nil t)))
  (setq c-auto-newline t)
  (c-set-style "gnu++"))


  ;; (c-set-style "gnu")
  ;; (c-set-offset 'arglist-intro '++)
  ;; (c-set-offset 'innamespace 0)
  ;; (c-set-offset 'member-init-intro 2)
  ;; (c-set-offset 'member-init-cont 0)
  ;; (c-set-offset 'case-label 0)
  ;; (c-set-offset 'func-decl-cont 2)
  ;; (c-set-offset 'inextern-lang 0)
  ;; (c-set-offset 'substatement-open 0)
  ;; (setq comment-start "// "
  ;;       comment-end ""
  ;;       c-auto-newline t
  ;;       c-basic-offset 4
  ;;       c-cleanup-list '(defun-close-semi
  ;;                        list-close-comma
  ;;                        scope-operator
  ;;                        space-before-funcall
  ;;                        compact-empty-funcall
  ;;                        comment-close-slash))


;;   (c-set-offset 'arglist-intro '++)
;;   (c-set-offset 'member-init-intro 2)
;;   (c-set-offset 'member-init-cont 0)
;;   (c-set-offset 'case-label 0)
;;   (c-set-offset 'func-decl-cont 2)
;;   (c-set-offset 'inextern-lang 0)
;;   (c-set-offset 'substatement-open 0)
;;   (setq comment-start "// "
;;         comment-end ""
;;         c-auto-newline t
;;         c-basic-offset 4
;;         c-hanging-braces-alist '((extern-lang-open . (after))
;;                                  (substatement-open . (after))
;;                                  (brace-list-open . (after))
;;                                  (module-open . (after))
;;                                  (namespace-open . (after))
;;                                  (defun-open . (after))
;;                                  (class-open . (after))
;;                                  (inline-open . (after))
;;                                  (statement-case-open . (after))
;;                                  (brace-list-close)
;;                                  (brace-list-intro)
;;                                  (brace-entry-open))
;;         c-cleanup-list '(brace-catch-brace
;;                          brace-else-brace
;;                          brace-elseif-brace
;;                          defun-close-semi
;;                          list-close-comma
;;                          scope-operator
;;                          space-before-funcall
;;                          compact-empty-funcall
;;                          comment-close-slash))
;; )

;; (defun my-c-mode-common ()
;;   (setq abbrev-mode nil)
;;   (define-section-marker "^////")
;;   (local-set-key (kbd "<f2>") (occur-binding "^\\("
;;                                              "\\|"
;;                                              "[a-zA-Z0-9_:~]+\\s *(\\|"
;;                                              ;; "struct [a-zA-Z0-9_]+\\|"
;;                                              ;; "static struct [a-zA-Z0-9_]+\\|"
;;                                              ;; "class [a-zA-Z0-9_]+\\|"
;;                                              "#define *[a-zA-Z0-9_]*(\\|"
;;                                              "/////"
;;                                              "\\)"))
;;   (local-set-key (kbd "RET") 'c-context-line-break)
;;   (local-set-key (kbd "C-5") (lambda ()
;;                                (interactive)
;;                                (ff-find-other-file nil t)))
;;   (c-set-style "gnu")
;;   (c-set-offset 'innamespace 0)
;;   (c-set-offset 'arglist-intro '++)
;;   (c-set-offset 'member-init-intro 2)
;;   (c-set-offset 'member-init-cont 0)
;;   (c-set-offset 'case-label 0)
;;   (c-set-offset 'func-decl-cont 2)
;;   (c-set-offset 'inextern-lang 0)
;;   (c-set-offset 'substatement-open 0)
;;   (setq comment-start "// "
;;         comment-end ""
;;         c-auto-newline t
;;         c-basic-offset 4
;;         c-hanging-braces-alist '((extern-lang-open . (after))
;;                                  (substatement-open . (after))
;;                                  (brace-list-open . (after))
;;                                  (module-open . (after))
;;                                  (namespace-open . (after))
;;                                  (defun-open . (after))
;;                                  (class-open . (after))
;;                                  (inline-open . (after))
;;                                  (statement-case-open . (after))
;;                                  (brace-list-close)
;;                                  (brace-list-intro)
;;                                  (brace-entry-open))
;;         c-cleanup-list '(brace-catch-brace
;;                          brace-else-brace
;;                          brace-elseif-brace
;;                          defun-close-semi
;;                          list-close-comma
;;                          scope-operator
;;                          space-before-funcall
;;                          compact-empty-funcall
;;                          comment-close-slash))
;; )

(add-hook 'c-mode-hook 'my-c-mode)
(defun my-c-mode ()
  (setq buffer-compile-command
        (lambda (file)
          (cons (format "gcc -Wall  -o %s %s && ./%s"
                        (file-name-sans-extension file)
                        file
                        (file-name-sans-extension file))
                11))))

(add-hook 'c++-mode-hook 'my-c++-mode)
(defun my-c++-mode ()
  (setq buffer-compile-command
        (lambda (file)
          (cons (format "g++ -Wall  -o %s %s && ./%s"
                        (file-name-sans-extension file)
                        file
                        (file-name-sans-extension file))
                11))))

;; (add-hook 'cmake-mode-hook 'yas/minor-mode)

(add-hook 'compilation-mode-hook 'my-compilation-mode)
(defun my-compilation-mode ()
  (set (make-local-variable 'truncate-lines) nil))

(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'my-lisp-mode)

(when (not (boundp 'skip-server-start))
  (add-hook 'emacs-startup-hook 'server-start))

(add-hook 'diff-mode-hook 'my-diff-mode)
(defun my-diff-mode ()
  (local-unset-key (kbd "M-RET")))

(add-hook 'dired-mode-hook 'dired-omit-mode)
(add-hook 'dired-mode-hook 'my-dired-mode)
(defun my-dired-mode ()
  (local-set-key (kbd "C-c r") 'wdired-change-to-wdired-mode)
  (local-set-key (kbd "C-c k") 'dired-kill-subdir)
  (local-set-key (kbd "n") 'dired-next-file-line)
  (local-set-key (kbd "p") 'dired-previous-file-line)
  (local-set-key (kbd "<f8>") (lambda ()
                                (interactive)
                                (let ((default-directory
                                       (dired-current-directory)))
                                  (call-interactively 'shell-dwim)))))

(add-hook 'grep-mode-hook 'my-grep-mode)
(defun my-grep-mode ()
  (setq truncate-lines t))

(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-decl-scan)
(add-hook 'haskell-mode-hook 'turn-on-haskell-hugs)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)

;; (defun my-hi-lock-mode ()
;;   (make-face 'page-delimiter-face)
;;   (set-face-background 'page-delimiter-face "grey85")
;;   (highlight-regexp "^\n" 'page-delimiter-face))
;; (add-hook 'hi-lock-mode-hook 'my-hi-lock-mode)

(add-hook 'hs-minor-mode-hook 'my-hs-minor-mode)
(defun my-hs-minor-mode ()
  (local-unset-key (kbd "<C-down-mouse-1>"))
  (local-set-key (kbd "<C-down-mouse-1>") 'hs-mouse-toggle-hiding))
  ;; (local-set-key (quote [67108918]) (quote hs-hide-all)) ;C-6
  ;; (local-set-key (quote [67108919]) (quote hs-show-all)) ;C-7
  ;; (local-set-key (quote [67108920]) (quote hs-toggle-hiding))) ;C-8

(add-hook 'ibuffer-mode-hook 'my-ibuffer-mode)
(defun my-ibuffer-mode ()
  (define-key ibuffer-name-map
    (kbd "<mouse-1>") 'ibuffer-mouse-visit-buffer-other-window)
  (define-key ibuffer-name-map
    (kbd "<mouse-2>") 'ibuffer-mouse-toggle-mark)
  (ibuffer-switch-to-saved-filter-groups "ws"))

(add-hook 'iswitchb-define-mode-map-hook 'my-iswitchb-mode-map)
(defun my-iswitchb-mode-map ()
  (define-key iswitchb-mode-map
      (kbd "M-`") 'iswitchb-exit-minibuffer)
  (define-key iswitchb-mode-map
      (kbd "M-RET") 'iswitchb-exit-minibuffer))
  ;; (define-key iswitchb-mode-map
  ;;     (kbd "<f2>") 'iswitchb-exit-minibuffer))

(add-hook 'latex-mode-hook 'my-latex-mode)
(defun my-latex-mode ()
  (setq buffer-compile-command "pdflatex %s"))

(add-hook 'lisp-mode-hook 'hs-minor-mode)
(add-hook 'lisp-mode-hook 'my-lisp-mode)
;; (add-hook 'lisp-mode-hook 'slime-mode)
(defun my-lisp-mode ()
  (define-section-marker "^;;;;")
  (local-set-key (kbd "<f2>") (occur-binding "^\\("
                                             "(defun \\|"
                                             ";;;;"
                                             "\\)"))
  (setq lisp-indent-function 'common-lisp-indent-function)
  (setq indent-tabs-mode nil)
  (setq common-lisp-hyperspec-root "/usr/share/doc/hyperspec/"))

(add-hook 'mail-mode-hook 'abbrev-mode)

(add-hook 'python-mode-hook 'my-python-mode)
(add-hook 'python-mode-hook 'hs-minor-mode)
(defun my-python-mode ()
  (define-section-marker "^####")
  (setq buffer-compile-command "python %s"))

(add-hook 'ruby-mode-hook 'hs-minor-mode)
(add-hook 'sawfish-mode-hook 'hs-minor-mode)

(add-hook 'sh-mode-hook 'my-sh-mode)
(defun my-sh-mode ()
  (define-section-marker "^####")
  (setq buffer-compile-command "/bin/sh -c ./%s"))

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'shell-mode-hook 'my-shell-mode)
(add-hook 'shell-mode-hook 'track-shell-directory/procfs)
(defun my-shell-mode ()
  (toggle-truncate-lines)
  ;; (local-set-key (kbd "M-s") 'iswitchb-buffer)
  (local-set-key (kbd "M-.") 'comint-insert-previous-argument))
;;   (local-set-key (kbd "<up>") 'comint-previous-input)
;;   (local-set-key (kbd "<down>") 'comint-next-input))

(add-hook 'scheme-mode-hook 'my-scheme-mode)
(defun my-scheme-mode ()
  (define-section-marker "^;;;;")
  (local-set-key (kbd "<f2>") (occur-binding "^\\("
                                             "(define \\|"
                                             ";;;;"
                                             "\\)"))
  (put 'when 'scheme-indent-function 1)
  (put 'unless 'scheme-indent-function 1)
  (put 'add-hook! 'scheme-indent-function 1)
  (put 'catch 'scheme-indent-function 1)
  (put 'parameterize 'scheme-indent-function 1)
  (put 'lambda* 'scheme-indent-function 1))


(add-hook 'slime-load-hook 'my-slime-mode)
(defun my-slime-mode ()
  (slime-setup '(slime-repl)))

(add-hook 'text-mode-hook 'auto-fill-mode)
(add-hook 'text-mode-hook 'my-text-mode)
(defun my-text-mode ()
  (setq default-fill-column 72))

(add-hook 'visual-basic-mode-hook 'c-subword-mode)
(add-hook 'visual-basic-mode-hook 'my-visual-basic-mode)
(add-hook 'visual-basic-mode-hook 'yas/minor-mode)
(defun my-visual-basic-mode ()
  (setq tab-width 8)
  (setq indent-tabs-mode t)
  (define-section-marker "^''''")
  (local-set-key (kbd "<f2>") (occur-binding "^\\("
                                             "'''' \\|"
                                             "' .*interaktiv:\\|"
                                             "[[:space:]]*\\(sub\\|function\\|type\\)[[:space:]]"
                                             "\\)")))

;;;; interactive

(defun in-directory ()
  "Reads a directory name, then runs execute-extended-command
with default-directory in the given directory."
  (interactive)
  (let ((default-directory (read-directory-name "In directory: " nil nil t)))
    (call-interactively 'execute-extended-command)))

(defun forward-page-recenter ()
  (interactive)
  (forward-page)
  (recenter 10))

(defun backward-page-recenter ()
  (interactive)
  (backward-page)
  (recenter 10))

(defun set-tab-width (width)
  (interactive (list (read-number "tab-width" tab-width)))
  (setq tab-width width))

(defun iswitchb-recent-buffer ()
  (interactive)
  (iswitchb-make-buflist nil)
  (switch-to-buffer (car iswitchb-buflist)))

(defun dired-next-file-line ()
  "Moves to the next dired line that have a file or directory name on it"
  (interactive)
  (call-interactively 'dired-next-line)
  (if (not (or (dired-move-to-filename) (eobp)))
      (dired-next-file-line)))

(defun dired-previous-file-line ()
  "Moves to the previous dired line that have a file or directory name on it"
  (interactive)
  (call-interactively 'dired-previous-line)
  (if (not (or (dired-move-to-filename) (bobp)))
      (dired-previous-file-line)))

(defun insert-with-space ()
  (interactive)
  (when (looking-back "\\sw" 1)
    (let ((last-command-char ?\s))
      (call-interactively 'self-insert-command)))
  (call-interactively 'self-insert-command))

(make-local-variable (defvar buffer-compile-command '(" %s" . 1)))
(setq-default compile-command "")

(defun compile-dwim (&optional arg)
  "Compile Do What I Mean.
Compile using `compile-command'.
When `compile-command' is empty prompt for its default value.
With prefix C-u always prompt for the default value of
`compile-command'.
With prefix C-u C-u prompt for buffer local compile command with
suggestion from `buffer-compile-command'.  An empty input removes
the local compile command for the current buffer."
  (interactive "P")
  (require 'compile)
  (cond
    ((and arg (> (car arg) 4))
     (let ((cmd (read-from-minibuffer
                 (format "Buffer local compile command: %s$ "
                         default-directory)
                 (let ((file (if (buffer-file-name)
                                 (file-relative-name (buffer-file-name))
                                 "")))
                   (cond ((functionp buffer-compile-command)
                          (funcall buffer-compile-command file))
                         ((stringp buffer-compile-command)
                          (format buffer-compile-command file))
                         ((consp buffer-compile-command)
                          (cons (format (car buffer-compile-command) file)
                                (cdr buffer-compile-command)))))
                 nil nil 'compile-history)))
       (cond ((equal cmd "")
              (kill-local-variable 'compile-command)
              (kill-local-variable 'compilation-directory))
             (t
              (set (make-local-variable 'compile-command) cmd)
              (set (make-local-variable 'compilation-directory)
                   default-directory))))
     (when (not (equal compile-command ""))
       ;; `compile' changes the default value of
       ;; compilation-directory but this is a buffer local
       ;; compilation
       (let ((dirbak (default-value 'compilation-directory)))
         (compile compile-command)
         (setq-default compilation-directory dirbak))))
    ((or (and arg (<= (car arg) 4))
         (equal compile-command ""))
     (setq-default compile-command (read-from-minibuffer
                                    (format "Compile command: %s$ "
                                            default-directory)
                                    (if (equal compile-command "")
                                        "make " compile-command)
                                    nil nil 'compile-history))
     (setq-default compilation-directory default-directory)
     (when (not (equal (default-value 'compile-command) ""))
       (compile (default-value 'compile-command))))
    (t
     (recompile))))

(defun comment-or-uncomment-line ()
  (interactive)
  (comment-or-uncomment-region
   (line-beginning-position) (line-end-position)))


(defun kill-current-buffer ()
  (interactive)
  (kill-buffer (current-buffer)))

(defun lock-buffer (&rest lock)
  (interactive)
  (set-window-dedicated-p (selected-window) (if lock (car lock) t)))

(defun unlock-buffer ()
  (interactive)
  (lock-buffer nil))

;; (setq window-size-fixed (if lock (car lock) t)))

(defun enable-popups (&rest enabled)
  (interactive)
  (setq pop-up-windows (if enabled (car enabled) t)))

(defun disable-popups (&rest enabled)
  (interactive)
  (enable-popups nil))

(defun insert-date ()
  (interactive)
  (defvar date-history '("Y-m-d" "d.m.Y" "H:M" "Y-m-d H:M"))
  (let* ((default (car date-history))
         (f (read-from-minibuffer
             (format "date-format (default %s): " default)
             nil nil nil 'date-history)))
    (insert
     (format-time-string
      (replace-regexp-in-string
       "\\([a-zA-Z]\\)" "%\\1" (if (equal f "") default f))))))

(defun insert-include-guards ()
  (interactive)
  (let* ((default (upcase
                   (format "%s_%s_%s_included"
                           (file-name-nondirectory (directory-file-name
                                                    (file-name-directory
                                                     (buffer-file-name))))
                           (file-name-nondirectory (file-name-sans-extension
                                                    (buffer-file-name)))
                           (file-name-extension (buffer-file-name)))))
         (guard (upcase (read-from-minibuffer
                         "include-guard: " (cons default 1) nil nil
                         'include-guards-prefix-history))))
    (save-excursion
      (goto-char (point-min))
      (insert (format "#ifndef %s\n#define %s\n\n" guard guard))
      (goto-char (point-max))
      (insert "\n#endif\n"))))

(defun set-compilation-window-layout ()
  (interactive)
  (split-window-horizontally)
  (select-window (next-window))
  (split-window-vertically)
  (select-window (next-window))
  (fit-window-to-buffer nil 12 12)
  (switch-to-buffer (get-buffer-create "*compilation*"))
  (lock-buffer)
  (select-window (next-window)))

(defvar section-marker-regexp nil)
(make-variable-buffer-local 'section-marker-regexp)

(defun define-section-marker (marker)
  (interactive (list (read-string "section-marker-regexp: ")))
  (setq section-marker-regexp marker)
  (font-lock-add-keywords nil
    `((,(concat "\\(" marker ".*\\)") 1 'section-header prepend))))

(defun show-sections ()
  (interactive)
  (if section-marker-regexp
      (occur section-marker-regexp)
      (message "show-sections: unknown mode")))

(defun ffap-at-mouse-other-window (e)
  "Like `ffap-at-mouse' but visit the file in another window."
  (interactive "e")
  (let ((ffap-file-finder 'find-file-other-window))
    (call-interactively 'ffap-at-mouse)))

(defun ibuffer-mouse-visit-buffer-other-window (event)
  "Visit the buffer chosen with the mouse in another window."
  (interactive "e")
  (switch-to-buffer-other-window
   (save-excursion
     (mouse-set-point event)
     (ibuffer-current-buffer t))))

(defun grep-dwim (&optional arg)
  (interactive "P")
  (grep (read-from-minibuffer
         (format "%s$ " default-directory)
         (let ((cw (or (current-word) ""))
               (beg (if arg "" "\\<"))
               (end (if arg "" "\\>"))
               (off (if arg 0 2)))
           (cond ((file-exists-p "SRC")
                  (let ((buf (concat "xargs -a SRC grep -nH -e '" beg cw end "'")))
                    (cons buf (- (length buf) off))))
                 ((file-exists-p "SRC.i")
                  (let ((buf (concat "xargs -a SRC.i grep -nHi -e '" beg cw end "'")))
                    (cons buf (- (length buf) off))))
                 (t
                  (let ((buf (concat "grep -nH -e '" beg cw end "' *")))
                    (cons buf (- (length buf) off 2))))))
         nil nil 'grep-history)))

;; (defun grep-dwim (&optional arg)
;;   (interactive "P")
;;   (grep (read-from-minibuffer
;;          (format "%s$ " default-directory)
;;          (let ((cw (if (region-active-p)
;;                        (buffer-substring-no-properties (region-beginning)
;;                                                        (region-end))
;;                        (or (current-word) "")))
;;                (beg (if (or arg (region-active-p)) "" "\\<"))
;;                (end (if (or arg (region-active-p)) "" "\\>"))
;;                (off (if (or arg (region-active-p)) 0 2)))
;;            (cond ((file-exists-p "SRC")
;;                   (let ((buf (concat "xargs -a SRC grep -nH -e '" beg cw end "'")))
;;                     (cons buf (- (length buf) off))))
;;                  ((file-exists-p "SRC.i")
;;                   (let ((buf (concat "xargs -a SRC.i grep -nHi -e '" beg cw end "'")))
;;                     (cons buf (- (length buf) off))))
;;                  (t
;;                   (let ((buf (concat "grep -nH -e '" beg cw end "' *")))
;;                     (cons buf (- (length buf) off 2))))))
;;          nil nil 'grep-history)))

;; (defun string-replace-all (s from to)
;;   (mapconcat (lambda (c) (if (= c from) to (string c))) s ""))
;; 
;; (defun shell-quote (arg)
;;   (concat "'" (string-replace-all arg ?' "'\\''") "'"))
;; 
;; (defun grep-dwim (&optional arg)
;;   (interactive "P")
;;   (grep (read-from-minibuffer
;;          (format "%s$ " default-directory)
;;          (let ((arg (if (region-active-p)
;;                         (buffer-substring-no-properties
;;                          (region-beginning) (region-end))
;;                         (or (current-word) ""))))
;;            (concat "grep -nH -e " (shell-quote
;;                                    (string-replace-all arg ?\\ "\\\\"))
;;                    " *"))
;;          nil nil 'grep-history)))

(defun occur-binding (&rest regex)
  `(lambda ()
     (interactive)
     (occur (apply 'concat (list ,@regex)))))

(defun occur-current-word ()
  (interactive)
  (let ((default (current-word)))
    (if (not default)
        (call-interactively 'occur)
      (occur
       (let* ((default (format "\\<%s\\>" default))
              (word (read-from-minibuffer
                     (format "List lines matching regexp (default %s): "
                             default)
                     nil nil nil 'regexp-history)))
         (when (equal word "")
           (setq word default)
           (add-to-history 'regexp-history word))
         word)))))

(defun occur-current-word-mouse (e)
  (interactive "@e")
  (save-excursion
    (mouse-set-point e)
    (let ((word (format "\\<%s\\>" (current-word))))
      (add-to-history 'regexp-history word)
      (occur word))))

;; (defun isearch-occur ()
;;   "Invoke `occur' from within isearch."
;;   ;; http://www.emacswiki.org/cgi-bin/wiki/OccurFromIsearch
;;   (interactive)
;;   (let ((case-fold-search isearch-case-fold-search))
;;     (occur (if isearch-regexp isearch-string
;;              (regexp-quote isearch-string)))))

(defun cmake-help (cmd)
  (shell-command (format "cmake --help-%s %s" cmd (symbol-at-point))
                 (get-buffer-create "*CMake Help*") nil))

(defun cmake-help-command () (interactive) (cmake-help "command"))
(defun cmake-help-module () (interactive) (cmake-help "module"))
(defun cmake-help-policy () (interactive) (cmake-help "policy"))
(defun cmake-help-property () (interactive) (cmake-help "property"))
(defun cmake-help-variable () (interactive) (cmake-help "variable"))
 
;;;; kbd macros

(defun point-to-beginning-of-region ()
  (interactive)
  (when (< (mark) (point))
    (call-interactively 'exchange-point-and-mark)))

(fset 'separate-by-newline
   [?\M-x ?r ?e ?p ?l ?a ?c ?e ?- ?r ?e ?g ?e ?x ?p return ?\\ ?\( ?\[ ?\[ ?: ?s ?p ?a ?c ?e ?: ?\] ?\] ?\\ ?| ?\C-q ?\C-j ?\\ ?\) ?+ return ?\C-q ?\C-j return])

(fset 'strip-whitespaces
   [?\M-x ?r ?e ?p ?l ?a ?c ?e ?- ?r ?e ?g ?e ?x ?p return ?\[ ?\[ ?: ?s ?p ?a ?c ?e ?: ?\] ?\] ?+ return ?  return])

(fset 'cpp-include-guards
    [?\C-\M-  ?\C-x ?q ?\C-w ?\M-< ?\C-o ?# ?i ?f ?n ?d ?e ?f ?  ?\C-y ?\C-x ?\C-x ?\C-x ?\C-u ?\C-x ?\C-x ?_ ?H ?_ ?I ?N ?C ?L ?U ?D ?E ?D return ?# ?d ?e ?f ?i ?n ?e ?  ?\C-y ?\C-x ?\C-x ?\C-x ?\C-u ?\C-x ?\C-x ?_ ?H ?_ ?I ?N ?C ?L ?U ?D ?E ?D return ?\M-> return ?# ?e ?n ?d ?i ?f ?  ?/ ?/ ?  ?\C-y ?\C-x ?\C-x ?\C-x ?\C-u ?\C-x ?\C-x ?_ ?H ?_ ?I ?N ?C ?L ?U ?D ?E ?D return])

(fset 'cpp-try
   (vconcat
    [?\M-x] "point-to-beginning-of-region" [return]
    [?\C-a ?\C-\M-o ?t ?r ?y return ?\C-q ?\{ ?\C-x ?\C-x ?\C-e return ?\C-q ?\} ?\C-\M-p ?\C-\M-  ?\C-\M-\\ ?\C-\M-n return ?c ?a ?t ?c ?h ?  ?\( ?s ?t ?d ?: ?: ?e ?x ?c ?e ?p ?t ?i ?o ?n ?& ?  ?e ?\) return ?\C-q ?\{ return ?\C-q ?\} ?\C-\M-p ?\C-\M-  ?\C-\M-\\ ?\C-e return]))

(fset 'cpp-try-log
   [?\M-x ?c ?p ?p ?- ?t ?r ?y return ?c ?l ?o ?g ?_ ?e ?x ?c ?e ?p ?t ?i ?o ?n ?\( ?e ?\) ?\C-q ?\; ?\C-n])

(fset 'cpp-extern-c
   (vconcat
    [?\M-x] "point-to-beginning-of-region" [return]
    [?\C-a ?\C-\M-o ?# ?i ?f ?d ?e ?f ?  ?_ ?_ ?c ?p ?l ?u ?s ?p ?l ?u ?s return ?e ?x ?t ?e ?r ?n ?  ?\" ?C ?\" ?\S-  ?\C-q ?\{ return ?# ?e ?n ?d ?i ?f return ?\C-x ?\C-x ?\C-e return return ?# ?i ?f ?d ?e ?f ?  ?_ ?_ ?c ?p ?l ?u ?s ?p ?l ?u ?s return ?\C-q ?\} ?  ?/ ?/ ?  ?e ?x ?t ?e ?r ?n ?  ?\" ?C ?\" return ?# ?e ?n ?d ?i ?f]))

(fset 'cpp-fwd-decl
   [?\C-e ?\C-d ?  ?\C-s ?\( ?\C-m ?\C-b ?\C-\M-  ?\C-\M-\\ ?\C-\M-n ?\C-q ?\; ?\C-\M-s ?^ ?\[ ?\[ ?: ?s ?p ?a ?c ?e ?: ?\] ?\] ?* ?\{ ?\C-m ?\C-b ?\C-\M-  ?\C-w ?\C-k ?\C-n])


;;;; shell

(defun track-shell-directory/procfs ()
  (shell-dirtrack-mode 0)
  (add-hook 'comint-preoutput-filter-functions
            (lambda (str)
              (prog1 str
                (when (string-match comint-prompt-regexp str)
                  (cd (file-symlink-p
                       (format "/proc/%s/cwd" (process-id
                                               (get-buffer-process
                                                (current-buffer)))))))))
            nil t))

(defun shell-buffer-p (buf)
  (string-match "^\\*shell\\*" (buffer-name buf)))

(defun shell-dwim (&optional arg)
  (interactive "P")
  (let ((shell-buffer-list (remove-if-not 'shell-buffer-p (buffer-list))))
    (defvar shell-dwim-ring nil)
    (setq shell-dwim-ring
          (remove-duplicates
           (append shell-buffer-list
                   (remove-if-not 'buffer-live-p shell-dwim-ring))))
    (let ((buf
           ;; find shell-buffer
           (or (cond
                 ((and arg (shell-buffer-p (current-buffer)))
                  (generate-new-buffer-name "*shell*"))
                 ((shell-buffer-p (current-buffer))
                  (let ((buf (pop shell-dwim-ring)))
                    (if (and shell-dwim-ring (equal buf (current-buffer)))
                        (progn
                          (setcdr (last shell-dwim-ring) (list buf))
                          (pop shell-dwim-ring))
                        buf)))
                 ((and shell-buffer-list arg)
                  (car shell-buffer-list))
                 (t
                  (block nil
                    (let ((dir (expand-file-name default-directory))
                          (buf (current-buffer)))
                      (dolist (buffer shell-dwim-ring)
                        (when (shell-buffer-p buffer)
                          (with-current-buffer buffer
                            (when (and (string= dir (expand-file-name
                                                     default-directory))
                                       (not (eq buf buffer)))
                              (return buffer)))))))))
               (generate-new-buffer-name "*shell*")))
          (win
           ;; find window displaying any shell-buffer
           (block nil
             (dolist (win (window-list))
               (when (shell-buffer-p (window-buffer win))
                 (return win))))))
      (setq shell-dwim-ring (delete buf shell-dwim-ring))
      ;; display shell-buffer in window
      (cond
        ((not win)
         (shell buf))
        ((not buf)
         (select-window win))
        ((not (buffer-live-p buf))
         (let ((newbuf (save-window-excursion (shell buf))))
           (select-window win)
           (switch-to-buffer newbuf)))
        (t
         (select-window win)
         (switch-to-buffer buf)))
      (message "%s" default-directory))))

;;;; hippie-expand

(defun try-expand-local-abbrevs (old)
  "Try to expand word before point according to the local abbrev table.
The argument OLD has to be nil the first call of this function, and t
for subsequent calls (for further possible expansions of the same
string).  It returns t if a new expansion is found, nil otherwise."
  (if (not old)
      (progn
	(he-init-string (he-dabbrev-beg) (point))
	(setq he-expand-list
	      (and (not (equal he-search-string ""))
		   (mapcar (function (lambda (sym)
			     (if (and (boundp sym) (vectorp (eval sym)))
				 (abbrev-expansion (downcase he-search-string)
						   (eval sym)))))
                           '(local-abbrev-table))))))
  (while (and he-expand-list
	      (or (not (car he-expand-list))
		  (he-string-member (car he-expand-list) he-tried-table t)))
    (setq he-expand-list (cdr he-expand-list)))
  (if (null he-expand-list)
      (progn
	(if old (he-reset-string))
	())
      (progn
	(he-substitute-string (car he-expand-list) t)
	(setq he-expand-list (cdr he-expand-list))
	t)))

;;;; ibuffer groups

(setq my-ibuffer-filter-groups
      (append my-ibuffer-filter-groups
              '(("CMake"
                 (mode . cmake-mode))
                ("Java"
                 (mode . java-mode))
                ("IDL"
                 (mode . idl-mode))
                ("C++"
                 (mode . c++-mode))
                ("C"
                 (mode . c-mode))
                ("Basic"
                 (mode . visual-basic-mode))
                ("qtuis" (filename . "ui_.*\\.h"))
                ("XML"
                 (mode . sgml-mode))
                ("Man"
                 (mode . Man-mode))
                ("emacs"
                 (mode . emacs-lisp-mode))
                ("shell"
                 (mode . shell-mode))
                ("special"
                 (name . "^\\*.*"))
                ("dired"
                 (mode . dired-mode)))))

(setq ibuffer-saved-filter-groups (list (cons "ws" my-ibuffer-filter-groups)))

;;;; abbrevs

(define-abbrev-table 'c++-mode-abbrev-table
    '(
      ("s" "std::")
      ("vi" "virtual ")
      ("te" "template <")
      ("pi" "private:\n    ")
      ("pu" "public:\n    ")
      ("cs" "const std::string& ")
      ("cq" "const QString& ")
      ))

(define-abbrev-table 'visual-basic-mode-abbrev-table
    '(
      ("endif" "End If")
      ("endselect" "End Select")
      ("esub" "Exit Sub")
      ("efun" "Exit Function")
      ))

;;;; ya snippets

;;; snippets for sh-mode
(yas/define-snippets 'sh-mode
'(
  ("if"
   "if [ $1 ]; then
    $0
fi")
  ("while"
   "while [ $1 ]; do
    $0
done")
  ("case"
   "case $1 in
    $2)
        $0
        ;;
esac")
  ("for"
   "for ${1:f} in $2; do
    $0
done")
  ("fori"
   "for (( ${1:i} = 0; $1 < $2; ++$1)); do
    $0
done")))

;;; snippets for cc-mode
(yas/define-snippets 'cc-mode
'(
  ("struct"
   "struct $1
{
    $0
};")
  ("main"
   "int
main (int argc, char** argv)
{
  $0
  return 0;
}
")
  ("Main"
   "#include <stdio.h>

int
main (int argc, char** argv)
{
  $0
  return 0;
}
")
  ("if"
   "if (${1:condition})
{
  $0
}")
  ("while"
   "while (${1:condition})
{
  $0
}")
  ("for"
   "for (${1:int i = 0}; ${2:i < n}; ${3:++i})
{
  $0
}")
  ("do"
   "do
{
  $0
}
while (${1:condition});" "do { ... } while (...)")
  ("inc" "#include <$1>\n" "#include <...>")
  ("inc.1" "#include \"$1\"\n" "#include \"...\"")
  ("printf" "printf (\"$1\", $2);$0")
  ("fpe" "fprintf (stderr, \"$1\\n\"$2);$0")
  )
'text-mode)

;;; snippets for c++-mode
(yas/define-snippets 'c++-mode
'(
  ("ns"
   "namespace $1
{

$0

} // namespace $1" "namespace ...")
;;   ("st"
;;    "struct ${1:S} {
;;     ${1:$(yas/substr text \"[^: ]*\")} ($2) {
;;         $0
;;     }
;; };")

("cl"
   "class $1
{
public:
  ${1:$(yas/substr text \"[^: ]*\")} ($2);
  virtual ~${1:$(yas/substr text \"[^: ]*\")} ();
};


${1:$(yas/substr text \"[^: ]*\")}::${1:$(yas/substr text \"[^: ]*\")} ($2)
{
  $0
}

${1:$(yas/substr text \"[^: ]*\")}::~${1:$(yas/substr text \"[^: ]*\")} ()
{
}")
("cll"
   "class $1
{
public:
  ${1:$(yas/substr text \"[^: ]*\")} ($2 $3);
  virtual ~${1:$(yas/substr text \"[^: ]*\")} ();

  $2 $3 () const {return _$3;}

private:
  $2 _$3;
};


${1:$(yas/substr text \"[^: ]*\")}::${1:$(yas/substr text \"[^: ]*\")} ($2 $3_):
  _$3 ($3_)
{
  $0
}

${1:$(yas/substr text \"[^: ]*\")}::~${1:$(yas/substr text \"[^: ]*\")} ()
{
}")
  ("forit"
   "for (${1:typename T}::iterator ${2:i} = ${3:v}.begin(); $2 != $3.end(); ++$2)
{
  $0
}")
  ("try"
   "try
{
  $0
}
catch (${1:std::exception& e})
{
}")
  ("readline"
   "std::string
read_line (const std::string& msg)
{
  using namespace std;
  cout << msg << flush;
  string line;
  getline (cin, line);
  return line;
}
")
  ("Main"
   "#include <iostream>

using namespace std;

int
main (int argc, char** argv)
{
  $0
  return 0;
}
")
  ("us" "using namespace ${std};\n$0")
  ("usb" "using boost::${bind};\n$0")
  ("usm" "using boost::${make_shared};\n$0")
  ("GS" "${2:int} $1 () const {return _$1;}
void set_$1 (const $2& ${3:x}) {_$1 = $3;}\n$0")
  ("cou" "cout << $1 << endl;$0")
  ("cer" "cerr << $1 << endl;$0")
  ("sco" "std::cout << $1 << std::endl;$0")
  ("sce" "std::cerr << $1 << std::endl;$0")
  ("deb" "clog_debug$1() << \"$0")
  ("dbg" "clog_dbg() << \"$0")
  ("trac" "clog_trace() << \"$0")
  )
'cc-mode)

(yas/define-snippets 'cmake-mode
'(
  ("project"
   "cmake_minimum_required (VERSION 2.6)
project ($1)

$0")
  )
'cmake-mode)


;;; snippets for visual-basic-mode
(yas/define-snippets 'visual-basic-mode
'(
  ("sub"
   "Sub ${1:Name} ($2)
	$0
End Sub")
  ("func"
   "Function ${1:Name} ($2)
	$0
End Function")
  ("Sub"
   "Sub ${1:Name} ($2)
	On Error Goto ErrorHandler
	$0
	Exit Sub
ErrorHandler:
	FatalError (\"$1\", \"`(file-name-nondirectory
               (file-name-sans-extension (or (buffer-file-name) \"\")))`\")
End Sub")
  ("Func"
   "Function ${1:Name} ($2)
	On Error Goto ErrorHandler
	$0
	Exit Function
ErrorHandler:
	FatalError (\"$1\", \"`(file-name-nondirectory
               (file-name-sans-extension (buffer-file-name)))`\")
End Function")
  ("type"
   "Type ${1:Name}
	$0
End Type")
  ("if"
   "If ${1:condition} Then
	$0
End If")
  ("for"
   "Dim ${1:i} As Integer
For $1 = ${2:0} To $3
	$0
Next $1")
  ("while"
   "While ${1:condition}
	$0
Wend")
  ("select"
   "Select Case ${1:what}
	Case $0
End If")
  ("do"
   "Do
	$0
Loop While $1")
  )
'text-mode)

;;;; custom-set

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(apropos-do-all t)
 '(backup-directory-alist (quote (("." . "~/.backups"))))
 '(bookmark-save-flag 1)
 '(bookmark-version-control nil)
 '(browse-url-browser-function (quote browse-url-firefox))
 '(column-number-mode t)
 '(comint-buffer-maximum-size 10240)
 '(comint-prompt-read-only t)
 '(comment-empty-lines (quote (quote eol)))
 '(comment-style (quote indent))
 '(compilation-ask-about-save nil)
 '(compilation-scroll-output t)
 '(compilation-window-height 15)
 '(confirm-kill-emacs (quote y-or-n-p))
 '(delete-old-versions t)
 '(diff-switches "-up")
 '(dired-find-subdir t)
 '(display-buffer-reuse-frames t)
 '(ediff-split-window-function (quote split-window-horizontally))
 '(enable-recursive-minibuffers t)
 '(fill-column 65)
 '(find-ls-option (quote ("-print0 | xargs -0 ls -ld" . "-ld")))
 '(global-hi-lock-mode t)
 '(global-subword-mode t)
 '(history-delete-duplicates t)
 '(ibuffer-default-sorting-mode (quote alphabetic))
 '(ibuffer-show-empty-filter-groups nil)
 '(icomplete-mode t)
 '(indent-tabs-mode nil)
 '(indicate-empty-lines t)
 '(inferior-lisp-program "sbcl")
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(isearch-allow-scroll t)
 '(iswitchb-buffer-ignore (quote ("^\\*.*-sections\\*$" "^ ")))
 '(iswitchb-mode t)
 '(kept-new-versions 5)
 '(kept-old-versions 1)
 '(lazy-highlight-initial-delay 0)
 '(longlines-show-hard-newlines t)
 '(longlines-wrap-follows-window-size t)
 '(ls-lisp-dirs-first t)
 '(ls-lisp-use-insert-directory-program nil)
 '(ls-lisp-verbosity nil)
 '(menu-bar-mode nil)
 '(mouse-avoidance-mode (quote jump) nil (avoid))
 '(mouse-wheel-progressive-speed nil)
 '(mouse-yank-at-point t)
 '(org-cycle-separator-lines 1)
 '(org-descriptive-links nil)
 '(org-drawers (quote ("PROPERTIES" "CLOCK" "BEG" "LOGBOOK")))
 '(org-export-copy-to-kill-ring nil)
 '(org-hide-leading-stars t)
 '(org-insert-mode-line-in-empty-file t)
 '(org-startup-folded nil)
 '(org-support-shift-select nil)
 '(read-quoted-char-radix 10)
 '(recentf-exclude (quote ("^/tmp/diff.*" "^/tmp/ecat.*" "^/var/tmp/.*" "^/tmp/kde-.*/kmail.*\\.tmp$")))
 '(recentf-max-saved-items 100)
 '(recentf-mode t)
 '(safe-local-variable-values (quote ((Syntax . Common-Lisp))))
 '(same-window-buffer-names (quote ("*mail*" "*inferior-lisp*" "*ielm*" "*scheme*" "*shell*")))
 '(same-window-regexps (quote ("\\*rsh-[^-]*\\*\\(\\|<[0-9]*>\\)" "\\*telnet-.*\\*\\(\\|<[0-9]+>\\)" "^\\*rlogin-.*\\*\\(\\|<[0-9]+>\\)" "\\*info\\*\\(\\|<[0-9]+>\\)" "\\*gud-.*\\*\\(\\|<[0-9]+>\\)" "\\`\\*Customiz.*\\*\\'" "^\\*shell\\*")))
 '(save-abbrevs nil)
 '(scroll-bar-mode (quote right))
 '(scroll-step 20)
 '(semanticdb-default-save-directory "/tmp")
 '(set-mark-command-repeat-pop t)
 '(shell-input-autoexpand nil)
 '(shift-select-mode nil)
 '(special-display-buffer-names (quote ("*compilation*" "*Ibuffer*")))
 '(tab-width 8)
 '(transient-mark-mode t)
 '(truncate-lines t)
 '(truncate-partial-width-windows nil)
 '(undo-limit 9999999)
 '(use-file-dialog nil)
 '(vc-cvs-stay-local nil)
 '(version-control t)
 '(w3m-default-display-inline-images t)
 '(w3m-use-tab nil)
 '(windmove-wrap-around nil)
 '(winner-mode t nil (winner))
 '(x-stretch-cursor nil))

(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(diff-added ((t (:inherit diff-changed :foreground "#00A500"))))
 '(diff-removed ((t (:inherit diff-changed :foreground "darkred"))))
 '(erc-current-nick-face ((t (:weight bold :foreground "yellow" :background "black"))))
 '(erc-notice-face ((t (:foreground "SlateBlue"))))
 '(erc-timestamp-face ((t (:weight bold :foreground "darkgreen"))))
 '(italic ((((supports :slant italic)) (:slant italic :family "Monospace"))))
 '(section-header ((t (:inherit font-lock-comment-face :weight bold))) t))

(load "~/.emacs.post" t)
