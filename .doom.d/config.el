;;; .doom.d/config.el -*- lexical-binding: t; -*-

(load! "latex-config") ;; this also loads cdlatex
(load! "hebrew-latex-config")
(load! "dvorak-config")

(setq
 user-full-name "Yoav Marco"
 user-mail-address "yoavm448@gmail.com"
 user-login-name "yoavm448"

 rainbow-delimiters-max-face-count 4
 dired-dwim-target                    t
 bidi-paragraph-direction             nil
 doom-snippets-enable-short-helpers   t
 doom-modeline-major-mode-icon        t
 yas-triggers-in-field                t
 avy-all-windows                      t
 avy-single-candidate-jump            t
 evil-split-window-below              t
 evil-vsplit-window-right             t
 +evil-want-o/O-to-continue-comments  nil
 doom-theme 'doom-spacegrey)


(add-hook! 'python-mode-hook     (modify-syntax-entry ?_ "w")) ;; underscore is a word in python
(add-hook! 'emacs-lisp-mode-hook (modify-syntax-entry ?- "w")) ;; hyphen is a word in elisp

(add-hook! 'prog-mode-hook 'rainbow-delimiters-mode) ;; loving colored parantheses
(add-hook! 'org-brain-vis-current-title-append-functions 'org-brain-entry-tags-string) ;; show tags in org-brain

;; KEYS
(map!
 ;; General
 :n   "g SPC" 'evil-avy-goto-char-2
 :eni "C-/"   'comment-line
 :v   "C-/"   'comment-region
 :nie "C-M-l" '+format/buffer
 ;; Smartparens Navigation
 :nie "M-p"   'sp-down-sexp ;; enter parenthesis forward
 :nie "M-P"   'sp-backward-down-sexp ;; enter parenthesis backward
 :nie "M-u"   'sp-up-sexp ;; exit parenthesis
 :nie "M-U"   'sp-backward-up-sexp ;; exit parenthesis backward
 :nie "M-n"   (λ!  (sp-up-sexp) (sp-down-sexp)) ;; next parentheses on same level
 :nie "M-N"   (λ! (sp-backward-up-sexp) (sp-backward-down-sexp)) ;; next parentheses on same level
 :v   "("     (lambda (&optional arg) (interactive "P") (sp-wrap-with-pair "("));; FIXME do this nicer; get evil to pass the key as argument
 :v   "{"     (lambda (&optional arg) (interactive "P") (sp-wrap-with-pair "{"))
 :v   "["     (lambda (&optional arg) (interactive "P") (sp-wrap-with-pair "[")))


;;;###autoload
(defun prvt/snippets-newline-if-needed (&optional n)
  "Insert a newline if not perceeded by a newline.
with parameter n, insert up to n newlines.
This "
  (interactive)
  (doom-snippets-without-trigger
   (let* ((n (or n 1))
          (max-point (- (point) n))
          (nl-count-minus (save-excursion (skip-chars-backward "\n" max-point))))
     (make-string (+ n nl-count-minus) ?\n))))


(set-eshell-alias! ;; haven't been using these much tbh
 ;; "config" "/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
 "python" "python3"
 "sai" "sudo apt install $1"
 "s" "sudo")
