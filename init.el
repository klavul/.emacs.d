;;; Init
;;;; Emit
;; Why do you need a macro that defines anonymous function so often? What's the deal with Named Builder?
;; (setup  (:p emit :host github :repo "IvanMalison/emit"))
;;; Display
;;;; Modus themes
(setup (:p modus-themes)
  (modus-themes-select 'modus-operandi))

;;;; Fontaine
(setup (:p fontaine)
  (setopt fontaine-presets '((small :default-height 120)
                             (regular :default-height 140)
                             (t :default-family "Iosevka Comfy Duo")))
  (fontaine-mode)
  (fontaine-set-preset 'regular))

;;;; Auto dark
(setup (:p auto-dark)
  (setopt auto-dark-dark-theme 'modus-vivendi
          auto-dark-light-theme 'modus-operandi)
  (auto-dark-mode))
  
;;;; Echo line
(setup (:p mini-echo)
  (mini-echo-mode))
;;;; Outli
;; TODO: prettify, looks ugly..
;; TODO: fix imenu
(setup (:p outli :host github :repo "jdtsmith/outli") (:require outli)
       (:hook-into prog-mode)
       (setopt outli-default-nobar t))

;;; Util
;;;; Process
;; more of that [[file:~/src/e/colonel/dotfiles/emacs.d/README.org::*Non-Forking Shell Command To String][Non-Forking Shell Command To String]]
(defun imalison:call-process-to-string (program &rest args)
  (with-temp-buffer
    (apply 'call-process program nil (current-buffer) nil args)
    (buffer-string)))
(defalias 'c/call-process-to-string #'imalison:call-process-to-string)

;;;; Path
(defun imalison:join-paths (root &rest dirs)
  (let ((result root))
    (cl-loop for dir in dirs do
             (setq result (concat (file-name-as-directory result) dir)))
    result))
(defalias 'c/join-paths #'imalison:join-paths)
  
;;; Web
;;;; Use XDG browser
(when (equal system-type 'gnu/linux)
    (setq browse-url-browser-function 'eww-browse-url))
(setq browse-url-secondary-browser-function 'browse-url-xdg-open)
;;; Reading
;;;; Pdf-tools
(setup (:p pdf-tools)
  (pdf-tools-install)
  (:bind-into pdf-view-mode-map
    "M-g g" pdf-view-goto-page))

(setup (:p saveplace-pdf-view))

;;; Development
;;;; Magit
(setup (:p transient))
(setup (:p magit))

;;;; Guix
;; TODO integrate containers with tramp, etc.

;;; Keyboarding
;; The dream is to take this mostly out of emacs with https://github.com/shegeley/haits

;; (setup (:p symex :host github :repo "drym-org/symex.el" :branch "2.0-integration")
;;   (symex-initialize))

;;;; Meow
(setup (:p meow)
  (require 'meow)
  (defun my-meow-setup ()
    (keymap-unset meow-normal-state-keymap "i")
    (meow-thing-register 'angle
                     '(pair ("<") (">"))
                     '(pair ("<") (">")))
   (setq meow-char-thing-table
         '((?f . round)
           (?d . square)
           (?s . curly)
           (?a . angle)
           (?r . string)
           (?v . paragraph)
           (?c . line)
           (?x . buffer)))
   (meow-motion-overwrite-define-key
    '("n" . meow-next)
    '("a" . meow-prev)
    '("<escape>" . ignore))
   (meow-leader-define-key
    ;; SPC j/k will run the original command in MOTION state.
    '("n" . "H-n")
    '("a" . "H-a")
    ;; Use SPC (0-9) for digit arguments.
    '("1" . meow-digit-argument)
    '("2" . meow-digit-argument)
    '("3" . meow-digit-argument)
    '("4" . meow-digit-argument)
    '("5" . meow-digit-argument)
    '("6" . meow-digit-argument)
    '("7" . meow-digit-argument)
    '("8" . meow-digit-argument)
    '("9" . meow-digit-argument)
    '("0" . meow-digit-argument)
    '("/" . meow-keypad-describe-key)
    '("?" . meow-cheatsheet))
   (meow-define-keys 'normal
 ; expansion
    '("0" . meow-expand-0)
    '("1" . meow-expand-1)
    '("2" . meow-expand-2)
    '("3" . meow-expand-3)
    '("4" . meow-expand-4)
    '("5" . meow-expand-5)
    '("6" . meow-expand-6)
    '("7" . meow-expand-7)
    '("8" . meow-expand-8)
    '("9" . meow-expand-9)
    '("/" . meow-reverse)

 ; movement
    '("s-n" . meow-prev)
    '("n" . meow-next)
    '("s-a" . meow-left)
    '("a" . meow-right)

    '("x" . meow-search)
    '("," . meow-visit)

 ; expansion
    '("s-N" . meow-prev-expand)
    '("N" . meow-next-expand)
    '("S-A" . meow-left-expand)
    '("A" . meow-right-expand)

    '("f" . meow-back-word)
    '("F" . meow-back-symbol)
    '("u" . meow-next-word)
    '("U" . meow-next-symbol)

    '("s" . meow-mark-word)
    '("S" . meow-mark-symbol)
    '("t" . meow-line)
    '("T" . meow-goto-line)
    '("m" . meow-block)
    '("v" . meow-join)
    '("g" . meow-grab)
    '("G" . meow-pop-grab)
    '("h" . meow-swap-grab)
    '("H" . meow-sync-grab)
    '("j" . meow-cancel-selection)
    '("J" . meow-pop-selection)

    '("k" . meow-till)
    '("z" . meow-find)

    '("'" . meow-beginning-of-thing)
    '(";" . meow-end-of-thing)
    '("\"" . meow-inner-of-thing)
    '(":" . meow-bounds-of-thing)

 ; editing
    '("r" . meow-kill)
    '("d" . meow-change)
    '("p" . meow-delete)
    '("q" . meow-save)
    '("y" . meow-yank)
    '("Y" . meow-yank-pop)

    '("l" . meow-insert)
    '("L" . meow-open-above)
    '("c" . meow-append)
    '("C" . meow-open-below)

    '("." . undo-only)
    '(">" . undo-redo)

    '("w" . open-line)
    '("W" . split-line)

    '("[" . indent-rigidly-left-to-tab-stop)
    '("]" . indent-rigidly-right-to-tab-stop)

 ; prefix n
    '("bd" . meow-comment)
    '("bp" . meow-start-kmacro-or-insert-counter)
    '("bc" . meow-start-kmacro)
    '("bl" . meow-end-or-call-kmacro)
 ;; ...etc

 ; prefix ;
    '("id" . save-buffer)
    '("iD" . save-some-buffers)
    '("ir" . meow-query-replace-regexp)
 ;; ... etc

 ; ignore escape
    '("<escape>" . ignore)))
  
  (my-meow-setup)
   
  (meow-global-mode t))
 
;;;; General
;; anondrdleauatrrmhaqrgrdtendrtanedtnrndaretodalurjtte
;;; Language
;;;; Rust
;; (use-package rustic
;;   :custom
;;   (rustic-lsp-client 'eglot)
;;   :hook
;;   (eglot--managed-mode-hook . (lambda () (flymake-mode -1))))
;;;; Lisp
;;;;; Arei
(setup (:p arei :host sourcehut :repo "abcdw/emacs-arei"))

;;;;; Parinfer
(setup (:p parinfer-rust-mode :host github :repo "justinbarclay/parinfer-rust-mode")
  (:hook-into lisp-mode scheme-mode emacs-lisp-mode))

;;; Files
;;;; Save place
(save-place-mode)

;;; Completion
(setup (:p vertico)
  (vertico-mode))

(setup (:p marginalia)
  (marginalia-mode))

(setup (:p orderless)
  (setopt completion-styles '(orderless)
          completion-category-overrides '((file (styles . (partial-completion))))))

(setup (:p corfu)
  (global-corfu-mode)
  (setopt
   corfu-cycle t
   corfu-auto t
   corfu-auto-prefix 2
   corfu-auto-delay 0.0
   corfu-echo-documentation 0.25))

(setup (:p consult))

(setup (:p embark)
  (setopt prefix-help-command #'embark-prefix-help-command))

(setup (:p embark-consult))

(setup (:p cape))

;;; Eshell
;; golly those long-running commands, hide them away from me, or I'd spend all my waking life waiting for them to complete (guix...)
;;; Org
;;;; Pomodoro

;;; WinSanity
;;;; Undo
(winner-mode)
;;;; Activities
(setup (:p activities :local-repo "~/s/e/activities"))
   

;;;; Burly
(setup (:p burly :host github :repo "alphapapa/burly.el")
  (burly-tabs-mode))

;;;; Bufler
(setup (:p bufler :host github :repo "alphapapa/bufler.el"))

;;; Org
;;;; Misc
(setup org (:require org)
  (setopt org-use-property-inheritance t
          org-agenda-files (list "~/org")))

;;;; Habit. Logging
;;;;; Enhanced. org-window-habit
;; i'm scared that it replaces something
;; (setup (:p org-window-habit :host github :repo "colonelpanic8/org-window-habit")
;;  (org-window-habit-mode))

(setup org
  (add-to-list 'org-modules 'org-habit)
  (setopt org-log-into-drawer t))

;;; Localvars
;; Local Variables:
;; mode: emacs-config-mode
;; End:
