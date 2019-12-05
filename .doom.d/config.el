;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(setq avy-keys '(?a ?o ?e ?u ?i ?d ?h ?t ?t ?n ?s)) ;; dvorak home row
(setq dired-dwim-target t)
;; (setq helm-display-buffer-height 30)

(load-theme 'doom-spacegrey)

(add-hook! 'prog-mode-hook 'rainbow-delimiters-mode) ;; love colored paranthesis

(map! :ne "C-/" #'comment-or-uncomment-region)

(defun evil-set-hebrew-insert ()
  "set hebrew insert mode in evil"
  (interactive)
  (setq evil-input-method 'hebrew)
  (message "going hebrew"))

(defun evil-set-regular-insert ()
  "set regular insert mode in evil"
  (interactive)
  (setq evil-input-method 'nil)
  (message "going normal"))

(defun change-lang ()
  "switches between hebrew and english"
  (interactive)
  (if (equal evil-input-method 'hebrew)
      (evil-set-regular-insert)
    (evil-set-hebrew-insert)))

;; (defun latex-math-insert ()
;;   "inesrt math block for latex"
;;   (interactive)
;;   (let ((yas-before-expand-snippet-hook #'evil-set-regular-insert)
;;         (yas-after-exit-snippet-hook #'evil-set-hebrew-insert)))
;;   (doom-snippets-expand :name "hebrew-math"))

;; (add-hook! 'latex-mode-hook
;;   (map! :g "M-m" (lambda () (interactive)
;;                    (add-hook 'yas-before-expand-snippet-hook evil-set-hebrew-insert)
;;                    (add-hook 'yas-after-exit-snippet-hook evil-set-hebrew-insert)
;;                    (doom-snippets-expand :name "hebrew-math"))))
(map! :g "M-m" (lambda () (interactive)
                 (add-hook 'yas-before-expand-snippet-hook 'evil-set-hebrew-insert)
                 (add-hook 'yas-after-exit-snippet-hook 'evil-set-hebrew-insert)
                 (doom-snippets-expand :file "/home/yoavm448/.doom.d/snippets/latex-mode/hebrew-math")
                 ;; (doom-snippets-expand :name "hebrew-math" 'latex)
                 ))
;; (doom-snippets-expand :file "/home/yoavm448/.doom.d/snippets/latex-mode/hebrew-math")
