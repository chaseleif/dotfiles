;;; replace ${USERNAME}, ${USEREMAIL}, ${IRCNICK}, ${IRCFULLNAME}

;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "${USERNAME}"
      user-mail-address "${USEREMAIL}")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two: (variable-pitch was "sans")
(setq doom-font (font-spec :family "monospace" :size 14 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "monospace" :size 15))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-1337)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
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
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; eval ->
;; spc - m - e

;; start maximized
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; DISABLE AUTO PARENTHESIS ~!@~!@~!@
(remove-hook 'doom-first-buffer-hook #'smartparens-global-mode)

;; multi-magit
;;(magit-add-section-hook 'magit-status-sections-hook
;;                        'multi-magit-insert-repos-overview
;;                        nil t)
(defun open-multigit ()
  "Open mult-magit"
  (interactive)
  (multi-magit-status))
(global-set-key (kbd "C-x G") 'open-multigit)
(setq magit-refresh-status-buffer t)

;; shell bind
(defun open-eshell ()
  "Open an eshell"
  (interactive)
  (eshell))
(global-set-key (kbd "C-x T") 'open-eshell)

;; music
(defun shuffle-my-music ()
  "Shuffle the current playlist"
  (interactive)
  (message "Shuffling the playlist.")
  (emms-shuffle))
(defun pause/resume-music ()
  "Pause or resume music playback"
  (interactive)
    (emms-pause)
    (if (get 'musicisplaying 'state)
      (progn
        (message "Playback paused.")
        (put 'musicisplaying 'state nil))
      (progn
        (message "Resuming playback.")
        (put 'musicisplaying 'state t))))
(defun play-music ()
  "Play ~/Music"
  (interactive)
  (if (get 'musicisplaying 'state)
      (progn
        (shuffle-my-music)
        (pause/resume-music))
      (progn
        (put 'musicisplaying 'state t)
        (message "Loading Music . . .")
        (emms-add-directory-tree "/media/music")
        (message "Turning repeat on.")
        (emms-toggle-repeat-playlist)
        (shuffle-my-music)
        (message "Playing music.")
        (emms-start))))
(defun next-track ()
  "Skip to the next track"
  (interactive)
  (emms-next))
(defun prev-track ()
  "Go back to the previous track"
  (interactive)
  (emms-previous))
(global-set-key (kbd "C-x M") 'play-music)
(global-set-key (kbd "C-x P") 'pause/resume-music)
(global-set-key (kbd "C-x S") 'shuffle-my-music)
(global-set-key (kbd "C-x N") 'next-track)
(global-set-key (kbd "C-x B") 'prev-track)

;; irc
;; explicitly set history to only have this server
(setq erc-server-history-list '("irc.libera.chat"))
;; on join make a new buffer but don't focus
(setq erc-join-buffer 'bury)
;; clear buffers
(setq erc-max-buffer-size 30000)
(setq erc-truncate-buffer-on-save t)
(defvar erc-insert-post-hook)
(add-hook 'erc-insert-post-hook
          'erc-truncate-buffer)
(setq erc-truncate-buffer-on-save t)
;; send nickserv our pass after they ask for it
(add-hook
 'erc-after-connect
 '(lambda (SERVER NICK)
    (erc-message "PRIVMSG" (concat "NickServ identify " ercpasswd))
    (setq ercpasspwd nil)
    ))
;; prompt for pwd and connect to the irc server
(defun erc-connect ()
  "Connect to Libre Chat"
  (interactive)
  (setq ercpasswd (ignore-errors (read-from-minibuffer "Password: ")))
  (message "Connecting to Libera . . .")
  (erc :server "irc.libera.chat" :port "6667"
    :nick "${IRCNICK}" :full-name "${IRCFULLNAME}")
  )
;; the bind for the above method
(global-set-key (kbd "C-x I") 'erc-connect)
;; set options
(require 'erc-dcc) ;; enable dcc
(use-package erc
  :custom
  ;; paranoia
  (erc-paranoid t)
  (erc-disable-ctcp-replies t)
  ;; timestamps
  (erc-timestamp-only-if-changed-flag nil)
  (erc-timestamp-format "[%a, %e %b, %H:%M] ")
  (erc-insert-timestamp-function 'erc-insert-timestamp-left)
  (erc-hide-timestamps nil)
  ;; disable built-in password prompt and define autojoin list
  (erc-prompt-for-nickserv-password nil)
  (erc-autojoin-channels-alist '(("libera.chat" "#txstcs" "#emacs" "#gentoo" "#archlinux" "#gentoo-chat" "shadowlamb")))
  ;;(erc-autojoin-timing nil)
  (erc-autojoin-delay 90)
  ;; line wrapping
  (erc-fill-function 'erc-fill-variable)
  (erc-fill-prefix "                         ")
  (erc-fill-column 238)
  ;; input prompt
  (erc-prompt "       [${IRCNICK}]$ ")
  (erc-scroll-to-bottom t)
  (erc-input-line-position "-1")
  ;; colors
  (set-face-attribute 'rcirc-my-nick nil :foreground "dark green" :weight 'bold)
  (set-face-attribute 'rcirc-prompt nil :foreground "dark green")
  (set-face-attribute 'rcirc-nick-in-message-full-line nil :foreground "orange" :weight 'normal)
  (set-face-attribute 'rcirc-nick-in-message nil :foreground "orange" :weight 'bold)
  (set-face-attribute 'rcirc-bright-nick nil :foreground "steel blue" :weight 'bold)
  ;; reconnections
  (erc-server-reconnect-attempts 5)
  (erc-server-reconnect-timeout 3)
  :config
  ;; (erc-services-mode 1)
  (erc-update-modules))

;; file browser - ranger
(ranger-override-dired-mode t)
(setq ranger-preview-file t)
(setq ranger-cleanup-on-disable t)

;; http://ergoemacs.org/emacs/elisp_toggle_command.html

;; tabs
;;(setq-default evil-shift-width 1)

(setq tab-width 2)
