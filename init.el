;;; Init
;;;; Emit
;; Why do you need a macro that defines anonymous function so often? What's the deal with Named Builder?
;; (setup  (:p emit :host github :repo "IvanMalison/emit"))
;;; Typography
;;;; Nano theme
;; Modus are nice, but semantic information is more important for me than just accessibility.
;; TODO: context!!
(setup (:p nano-theme) (:require nano-theme)
       ;; TODO: nano support fontaine/defaults 
       (set-face-attribute 'nano-mono t :family "Iosevka Comfy")
       (set-face-attribute 'nano-sans t :family "Iosevka Comfy Duo")
       (set-face-attribute 'nano-serif t :family "Iosevka Comfy Motion Duo")
       (set-face-attribute 'nano-italic t :family "Iosevka Comfy Motion")
       (nano-mode))

(setup (:p auto-dark)
  (setopt auto-dark-dark-theme 'nano-dark
          auto-dark-light-theme 'nano-light)
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

;;;; Modal/Structural editing
;; The dream is to take this mostly out of emacs with https://github.com/shegeley/haits

;; (setup (:p symex :host github :repo "drym-org/symex.el" :branch "2.0-integration")
;;   (symex-initialize))

(setup (:p meow))

(setup (:p parinfer-rust-mode :host github :repo "justinbarclay/parinfer-rust-mode")
  (:hook-into lisp-mode scheme-mode emacs-lisp-mode))
;;; Language
;;;; Rust
;; (use-package rustic
;;   :custom
;;   (rustic-lsp-client 'eglot)
;;   :hook
;;   (eglot--managed-mode-hook . (lambda () (flymake-mode -1))))
;;; Files
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
;;;; Save place
(save-place-mode)
  
;;;; Undo
(winner-mode)

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
