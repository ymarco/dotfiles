;;; .doom.d/config.el -*- lexical-binding: t; -*-

(load "~/.doom.d/latex-config")
(load "~/.doom.d/dvorak-config")

(setq
 ;; General
 rainbow-delimiters-max-face-count 4
 dired-dwim-target t
 bidi-paragraph-direction nil
 doom-snippets-enable-short-helpers t
 doom-modeline-major-mode-icon t
 yas-triggers-in-field t
 avy-all-windows t
 avy-single-candidate-jump t
 ;; THEME
 doom-theme 'doom-spacegrey)

;; underscore is a word is python
(add-hook! 'python-mode-hook (modify-syntax-entry ?_ "w"))
(add-hook! 'emacs-lisp-mode-hook (modify-syntax-entry ?- "w"))

(add-hook! 'prog-mode-hook 'rainbow-delimiters-mode) ;; loving colored parantheses

;; KEYS
(map!
 ;; General
 :n "g SPC" 'evil-avy-goto-char-2
 :eni "C-/" 'comment-line
 :v "C-/" 'comment-region
 :nie "C-M-l" '+format/buffer

 ;; Smartparens Navigation
 :nie "M-d" 'sp-down-sexp ;; enter parenthesis forward
 :nie "M-D" 'sp-backward-down-sexp ;; enter parenthesis backward
 :nie "M-u" 'sp-up-sexp ;; exit parenthesis
 :nie "M-U" 'sp-backward-up-sexp ;; exit parenthesis backward
 :nie "M-n" (λ!  (sp-up-sexp) (sp-down-sexp)) ;; next parentheses on same level
 :nie "M-N" (λ! (sp-backward-up-sexp) (sp-backward-down-sexp)) ;; next parentheses on same level

 :v "("  (lambda (&optional arg) (interactive "P") (sp-wrap-with-pair "("));; FIXME do this nicer; get evil to pass the key as argument
 :v "{"  (lambda (&optional arg) (interactive "P") (sp-wrap-with-pair "{"))
 :v "["  (lambda (&optional arg) (interactive "P") (sp-wrap-with-pair "[")))

(defun prvt/snippets-newline-if-needed (&optional n)
  "insert a newline if not perceeded by a newline.
with parameter n, insert up to n newlines.
This "
  (interactive)
  (doom-snippets-without-trigger
   (let* ((n (or n 1))
          (max-point (- (point) n))
          (nl-count-minus (save-excursion (skip-chars-backward "\n" max-point))))
     (make-string (+ n nl-count-minus) ?\n))))


(set-eshell-alias!
 "config" "/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
 "python" "python3"
 "sai" "sudo apt install"
 "s" "sudo"
 )
