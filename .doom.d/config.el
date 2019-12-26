;;; .doom.d/config.el -*- lexical-binding: t; -*-

(setq avy-keys '(?a ?o ?e ?u ?i ?d ?h ?t ?t ?n ?s)) ;; dvorak home row
(setq dired-dwim-target t)
;; (setq helm-display-buffer-height 30)
;; (setq ivy-height 11)

;; THEME
(setq doom-theme 'doom-spacegrey)

(add-hook! 'prog-mode-hook 'rainbow-delimiters-mode) ;; love colored paranthesis

;; KEYS
(map! :n "g SPC" 'avy-goto-char-timer
      :veni "C-/" 'comment-line
      :nie "C-M-l" '+format/buffer)

;; DEBUG STUFF
(defun message-start ()
  (interactive)
  (message "start!"))

(defun message-end ()
  (interactive)
  (message "end!"))

;; HEBREW LATEX STUFF

(defun reinsert-evil ()
  "exits insert mode and then returns to it, usually used to update evil-input-method"
  (interactive)
  (when (equal evil-state 'insert)
    (evil-append 0)
    (evil-insert-state)))

(defun set-evil-hebrew-insert ()
  "set hebrew insert mode in evil"
  (interactive)
  (setq evil-input-method 'hebrew)
  (reinsert-evil)
  (message "going hebrew"))

(defun set-evil-regular-insert ()
  "set regular insert mode in evil"
  (interactive)
  (setq evil-input-method 'nil)
  (reinsert-evil)
  (message "going normal"))

(defun change-lang ()
  "switches between hebrew and english"
  (interactive)
  (if (equal evil-input-method 'hebrew)
      (evil-set-regular-insert)
    (evil-set-hebrew-insert)))

(map! :g "M-m" (lambda () (interactive)
                 (set-evil-regular-insert)
                 (reinsert-evil)
                 (doom-snippets-expand :file "/home/yoavm448/.doom.d/snippets/latex-mode/hebrew-math")))
