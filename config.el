;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Chen Kuan-hsun"
      user-mail-address "ken4306@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!
(setq! doom-font (font-spec :family "Fira Code" :size 15 :weight 'regular))
(setq! doom-unicode-font (font-spec :family "Fira Code"))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;; :ui
;; fullscreen
;;(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; Change theme to solarize-dark
(load-theme 'doom-solarized-dark t)

;;; :editor evil
;; Focus new window after splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t)

;; vanilla emacs keybinding in insert state
;; (map! (:after evil
;;        :i "C-k" nil
;;        :i "C-d" 'delete-char))
(setq! evil-disable-insert-state-bindings t)

;;; :ui modeline
;; Tweak doom-modeline
(setq! doom-modeline-major-mode-icon t
       doom-modeline-hud t
       doom-modeline-bar-width 10
       doom-modeline-hud-min-height 6)

;;; :ui window-select
;; Tweak window-select
(setq! aw-dispatch-when-more-than 1)
(map! (:after evil :map evil-window-map
       "w" 'ace-window
       "d" 'ace-delete-window
       "D" 'ace-delete-other-windows)
      (:after winum :leader
       "1" 'winum-select-window-1
       "2" 'winum-select-window-2
       "3" 'winum-select-window-3
       "4" 'winum-select-window-4
       "5" 'winum-select-window-5
       "6" 'winum-select-window-6
       "7" 'winum-select-window-7
       "8" 'winum-select-window-8
       "9" 'winum-select-window-9
       "0" 'winum-select-window-0-or-10
       ))

(map! (:map global-map
      "M-SPC" 'doom/leader))

;;; :emacs dired
;; tweak dired
(map! (:after dired :map dired-mode-map
       :n "l" 'dired-find-file
       :n "h" 'dired-up-directory
       ))

;;; :editor projectile
;; projectile ignore file
(setq projectile-indexing-method 'alien)

;; use .ignore and .fdignore to ignore file and find project root
;; those two file is used by fd-find
(after! projectile
  (add-to-list 'projectile-project-root-files-bottom-up ".ignore" ".fdignore"))

;; use .gitignore to determine project-vcs
;; NOTE: useless because fdfind need .git folder
;; (defun projectile-gitignore-as-git (orig-fun &optional project-root)
;;   (or project-root (setq project-root (projectile-acquire-root)))
;;   (cond
;;    ((projectile-file-exists-p (expand-file-name ".gitignore" project-root)) 'git)
;;    (t (apply orig-fun project-root nil))))
;; (advice-add 'projectile-project-vcs :around #'projectile-gitignore-as-git)

;;; :term vterm
(defun vterm-send-meta-up ()
  (interactive)
  (vterm-send-key "<up>" nil t))

(defun vterm-send-meta-down ()
  (interactive)
  (vterm-send-key "<down>" nil t))

;; forward Esc to vterm
(map! :map vterm-mode-map
      :e "<escape>" #'vterm-send-escape
      :e "M-<up>" #'vterm-send-meta-up
      :e "M-<down>" #'vterm-send-meta-down)

;; bind normal-state with copy-mode
(add-hook! 'vterm-mode-hook
           #'evil-emacs-state
           (add-hook! 'evil-emacs-state-entry-hook :local (vterm-copy-mode 0))
           (add-hook! 'evil-emacs-state-exit-hook :local (vterm-copy-mode 1)))

;;; :tools lookup
;; add google translate to lookup online provider list
(add-to-list
 '+lookup-provider-url-alist
 '("Google Translate" "https://translate.google.com.tw/?sl=en&tl=zh-TW&text=%s"))

;;; lang cc
;; set indent style to cc-mode
(add-hook! 'c-mode-common-hook (c-set-style "doom"))

;;; :misc secret
;; load secret info
;; (load! ".secret.el")

;; Associate calender with org file
(setq org-gcal-fetch-file-alist
      '(("ken4306@gmail.com" . "~/schedule.org")
        ("zh-tw.taiwan#holiday@group.v.calendar.google.com" . "~/schedule.org")))

(defun my-open-calendar ()
  (interactive)
  (cfw:open-calendar-buffer
   :contents-sources
   (list
    (cfw:org-create-source (face-foreground 'default))  ; org-agenda source
    (cfw:org-create-file-source "cal" "~/schedule.org" "IndianRed")  ; other org source
    ;;(cfw:ical-create-source "gcal" "https://..../basic.ics" "IndianRed") ; google calendar ICS
   )))

(setq +calendar-open-function #'my-open-calendar)



;;; :misc function
;; Misc functions and bindings
(defun misc/print-fun ()
  (interactive)
  (print (+ 1 1)))
(map! :n "C-S-p" 'print-fun)

;;; :ami
;; Insert md5 checksum for mds signing
(defun ami/insert-md5 ()
  (interactive)
  (let (md5-str)
    (save-excursion
      (goto-char (point-min))
      (forward-line 1)
      (setq md5-str
            (md5 (current-buffer) (point) (point-max))))
    (insert md5-str)))

;; Do not add newline at EOF
(setq require-final-newline nil)
(setq mode-require-final-newline nil)