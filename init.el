;;; Init
;;;; Emit
;; Why do you need a macro that defines anonymous function so often? What's the deal with Named Builder?
;; (setup  (:p emit :host github :repo "IvanMalison/emit"))
;;; Typography
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
  
;;;; Outli
;; TODO: prettify, looks ugly..
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
     (meow-normal-define-key
      '("0" . meow-expand-0)
      '("9" . meow-expand-9)
      '("8" . meow-expand-8)
      '("7" . meow-expand-7)
      '("6" . meow-expand-6)
      '("5" . meow-expand-5)
      '("4" . meow-expand-4)
      '("3" . meow-expand-3)
      '("2" . meow-expand-2)
      '("1" . meow-expand-1)
      '("-" . negative-argument)
      '("i" . meow-reverse)
      '("'" . meow-inner-of-thing)
      '(";" . meow-bounds-of-thing)
      '("[" . meow-beginning-of-thing)
      '("]" . meow-end-of-thing)
      '("p" . meow-append)
      '("P" . meow-open-below)
      '("b" . meow-back-word)
      '("B" . meow-back-symbol)
      '("c" . meow-change)
      '("d" . meow-delete)
      '("D" . meow-backward-delete)
      '("e" . meow-next-word)
      '("E" . meow-next-symbol)
      '("f" . meow-find)
      '("g" . meow-cancel-selection)
      '("G" . meow-grab)
      '("." . meow-left)
      '(">" . meow-left-expand)
      '("i" . meow-insert)
      '("I" . meow-open-above)
      '("n" . meow-next)
      '("N" . meow-next-expand)
      '("a" . meow-prev)
      '("A" . meow-prev-expand)
      '("l" . meow-right)
      '("L" . meow-right-expand)
      '("m" . meow-join)
      '("h" . meow-search)
      '("o" . meow-block)
      '("O" . meow-to-block)
      '("j" . meow-yank)
      '("q" . meow-quit)
      '("Q" . meow-goto-line)
      '("r" . meow-replace)
      '("R" . meow-swap-grab)
      '("s" . meow-kill)
      '("t" . meow-till)
      '("u" . meow-undo)
      '("U" . meow-undo-in-selection)
      '("v" . meow-visit)
      '("w" . meow-mark-word)
      '("W" . meow-mark-symbol)
      '("x" . meow-line)
      '("X" . meow-goto-line)
      '("y" . meow-save)
      '("Y" . meow-sync-grab)
      '("z" . meow-pop-selection)
      '("/" . repeat)
      '("<escape>" . ignore)))
  (my-meow-setup)

  (meow-global-mode t))
 

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
