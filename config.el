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
(setq! doom-unicode-font (font-spec :family "Source Code Pro for Powerline"))

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

;; fullscreen
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; vanilla emacs keybinding in insert state
;; (map! (:after evil
;;        :i "C-k" nil
;;        :i "C-d" 'delete-char))
(setq! evil-disable-insert-state-bindings t)
;; focus new window after splitting
(setq evil-split-window-below t
      evil-vsplit-window-right t)

;; tweak doom-modeline
(setq! doom-modeline-major-mode-icon t
       doom-modeline-hud t
       doom-modeline-bar-width 10
       doom-modeline-hud-min-height 6)

;; tweak window-select
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

;; tweak dired
(map! (:after dired :map dired-mode-map
       :n "l" 'dired-find-file
       :n "h" 'dired-up-directory
       ))

;; projectile ignore file
(setq projectile-indexing-method 'native)

;; vterm improved
(setq vterm-use-vterm-prompt-detection-method t)

(defun vti/send-C-k ()
    (interactive)
    (vterm-goto-char (point))
    (call-interactively #'vterm-send-C-k))

(map! :map vterm-mode-map
      :i "C-a" 'vterm-send-C-a
      :n "0" 'vterm-beginning-of-line
      :n "C-k" 'vti/send-C-k
      :n "C-p" 'vterm-send-C-p
      :n "C-n" 'vterm-send-C-n
      :n "G" 'vterm-reset-cursor-point)
;; TODO if switch to insert-state at invalid position, reset cursor point
