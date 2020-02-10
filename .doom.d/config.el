;;; .doom.d/config.el -*- lexical-binding: t; -*-

(load! "latex-config") ;; this also loads cdlatex
(load! "hebrew-latex-config")
(load! "dvorak-config")
(load! "org-setup")

(setq
 ;; Config, used for templates mostly
 user-full-name "Yoav Marco"
 user-mail-address "yoavm448@gmail.com"
 user-login-name "yoavm448"

 rainbow-delimiters-max-face-count    4   ;; Even more cololful pars
 dired-dwim-target                    t   ;; Dired auto-detects multiple windows
 doom-snippets-enable-short-helpers   t   ;; doom-expand-snippets -> %expand
 doom-modeline-major-mode-icon        t   ;; TODO Do I want this?
 yas-triggers-in-field                t   ;; Nested snippet expansion
 avy-all-windows                      t   ;; Avy can jump through windows
 avy-single-candidate-jump            t   ;; Avy can auto-jump when theres 1 candidate
 evil-split-window-below              t   ;; Don't replace the current window when splitting
 evil-vsplit-window-right             t   ;; Don't replace the current window when splitting
 rainbow-x-colors                     nil ;; e.g don't colorise 'white'
 doom-theme 'doom-spacegrey)              ;; prettiness

;; (setq-default truncate-lines nil)

(add-hook! 'python-mode-hook     (modify-syntax-entry ?_ "w")) ;; underscore is a word in python

(add-hook! 'org-brain-vis-current-title-append-functions #'org-brain-entry-tags-string) ;; show tags in org-brain
(add-hook! 'conf-xdefaults-mode-hook (rainbow-mode 1))

;; KEYS
(map!
 ;; General
 :n   "g SPC" #'evil-avy-goto-word-1
 :eni "C-/"   #'comment-line
 :v   "C-/"   #'comment-or-uncomment-region
 :nie "C-M-l" #'+format/buffer
 ;; Smartparens Navigation
 :nie "M-p"   #'sp-down-sexp ;; enter parenthesis forward
 :nie "M-P"   #'sp-backward-down-sexp ;; enter parenthesis backward
 :nie "M-u"   #'sp-up-sexp ;; exit parenthesis
 :nie "M-U"   #'sp-backward-up-sexp ;; exit parenthesis backward
 :nie "M-n"   (λ!  (sp-up-sexp) (sp-down-sexp)) ;; next parentheses on same level
 :nie "M-N"   (λ! (sp-backward-up-sexp) (sp-backward-down-sexp))) ;; next parentheses on same level


(defconst prvt/raw-git-packages-dir
  (eval-when-compile
    (concat doom-local-dir "straight/repos"))
  "Directory for raw git packages, as cloned by straight.el.")

(defconst prvt/home-dir
  (eval-when-compile (getenv "HOME"))
  "User home directory")

;; TODO make this work just with files - don't search inside the files
(defun prvt/search-package-doc ()
  (interactive)
  (doom-project-find-file prvt/raw-git-packages-dir))

;;;###autoload
(defun prvt/snippets-newline-if-needed (&optional n)
  "Insert a newline if not perceeded by a newline.
with parameter N, insert up to N newlines."
  (interactive)
  (doom-snippets-without-trigger
   (let* ((n (or n 1))
          (max-point (- (point) n))
          (nl-count-minus (save-excursion (skip-chars-backward "\n" max-point))))
     (make-string (+ n nl-count-minus) ?\n))))


;; (+global-word-wrap-mode +1)

(set-eshell-alias! ;; haven't been using these much tbh
 ;; "config" "/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
 "python" "python3 $*"
 "sai" "sudo apt install $*"
 "s" "sudo $*"
 "config" (format "git --git-dir=%s/.dotfiles/ --work-tree=%s $*"
                  prvt/home-dir prvt/home-dir))


;; Doom auto-configures a mode for sxhkd, override it:
(use-package! sxhkd-mode
  :mode "sxhkdrc\\'")

(use-package! xelb
  :commands xcb:connect)
