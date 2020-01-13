;;; ~/.doom.d/latex-config.el -*- lexical-binding: t; -*-

(load "~/.doom.d/cdlatex-config.el")

(defvar prvt/use-TeX-fold t
  "use TeX fold in TeX-mode.
when set to non-nil, this adds a few hooks/advices to fold stuff.")
(defvar prvt/LaTeX-hebrew t
  "whether to define Hebrew stuff or not")

(setq
 TeX-electric-sub-and-superscript nil ;; dont auto-insert braces on _^
 TeX-save-query nil ;; just save, dont ask me
 preview-auto-cache-preamble t ;; just cache, dont ask me
 LaTeX-math-abbrev-prefix (kbd "M-s")
 preview-default-option-list '("displaymath" "floats" "graphics" ;; NO SECTION; compiled sections ruin the hebrew *not in xetex, but I still don't like them
                               "textmath" "footnotes"))


(when prvt/LaTeX-hebrew
  ;; dont ask me what language every time
  (setq default-input-method "hebrew")
  ;; also use a reasonable font for Hebrew
  (set-fontset-font "fontset-default" 'hebrew (font-spec :family "Dejavu Sans")))

(when prvt/use-TeX-fold
  (setq TeX-fold-math-spec-list '(;; missing symbols
                                  ("≤" ("le"))
                                  ("≥" ("ge"))
                                  ("≠" ("ne"))
                                  ;; conviniance shorts
                                  ("‹" ("left"))
                                  ("›" ("right"))
                                  ;; private macros
                                  ("ℝ" ("RR"))
                                  ("ℕ" ("NN"))
                                  ("ℚ" ("QQ"))
                                  ("ℤ" ("ZZ"))
                                  ("ℂ" ("CC"))
                                  ("𝔽" ("FF")))
        ;; TeX-fold-macro-spec-list '(;; General conviniance
        ;; ("√{1}" ("sqrt"))
        ;; Private macros
        ;; ("({1})" ("pa"))
        ;; ("[{1}]" ("bra"))
        ;; ("{{1}}" ("bre"))
        ;; ("[{1})" ("bpa"))
        ;; ("({1}]" ("pba"))
        ;; ("|{1}|" ("abs"))
        ));)

(setq font-latex-match-math-command-keywords
      '(;; standard functions
        "arccos" "arcsin" "arctan" "arg" "cos" "cosh" "cot" "coth" "csc" "tanh"
        "deg" "det" "dim" "exp" "Pr" "proj" "sec" "sin" "sinh" "sup" "tan"
        "gcd" "hom" "inf" "inj" "ker" "lg" "lim" "ln" "log" "max" "min"
        ;; things I have no fold for
        "frac" "binom"
        ;; private macros with no fold
        "oner" "half" "pa" "bra" "bre" "pba" "bpa" "abs" ))

;;;###autoload
(defun prvt/set-hebrew-input-method ()
  (interactive)
  (activate-input-method "hebrew"))
;;;###autoload
(defun prvt/set-regular-input-method ()
  (interactive)
  (deactivate-input-method))
;;;###autoload
(defun prvt/hebrew-math-mode ()
  "Enters inline math in a Hebrew paragraph in latex"
  (interactive)
  (prvt/set-regular-input-method)
  (doom-snippets-expand :file "/home/yoavm448/.doom.d/snippets/latex-mode/hebrew-math"))
;;;###autoload
(defun prvt/hebrew-display-math-mode ()
  "Enters display math mode in latex. adds newlines beforehand if needed."
  (interactive)
  (prvt/set-regular-input-method)
  (doom-snippets-expand :file "/home/yoavm448/.doom.d/snippets/latex-mode/hebrew-display-math"))
;;;###autoload
(defun prvt/hebrew-align-math-mode ()
  "Enters display math mode in latex. adds newlines beforehand if needed."
  (interactive)
  (prvt/set-regular-input-method)
  (doom-snippets-expand :file "/home/yoavm448/.doom.d/snippets/latex-mode/hebrew-align-math"))

(defface unimportant-latex-face
  '((t :height 0.8
       :inherit font-lock-comment-face))
  "Face used to make obstructive commands (such as \\( \\[) less visible."
  :group 'LaTeX-math)

(font-lock-add-keywords
 'latex-mode
 `((,(rx (and "\\" (any "()[]"))) 0 'unimportant-latex-face prepend))
 'end)


(custom-set-faces! '(rainbow-delimiters-depth-1-face :foreground nil :inherit rainbow-delimiters-depth-6-face)) ;; on default, 1-D braces look ordinary in latex math
(custom-set-faces! '(preview-reference-face :inherit solaire-default-face)) ;; fixes latex preview background color in solaire
(custom-set-faces! '(preview-face :inherit org-block)) ;; just configured for the theme
(custom-set-faces! '(TeX-fold-folded-face :inherit font-lock-builtin-face)) ;; just configured for the theme

;;;###autoload
(defun prvt/TeX-fold-current-line (&rest ignored)
  "folds current line, mostly used as a hook to fold math."
  (interactive)
  (TeX-fold-region (line-beginning-position) (line-end-position)))

;;;###autoload
(defun prvt/LaTeX-insert-item-below ()
  "Tries to be like insert-item-below in org.
inserts \\item in regular environments, \\ in math"
  (interactive)
  (cond
   ((texmathp)
    (when (not (bolp))
      (end-of-line)
      (insert " \\\\")
      (when prvt/use-TeX-fold
        (prvt/TeX-fold-current-line))
      (+default/newline)))
   ((not (equal (LaTeX-current-environment) "document"))
    (LaTeX-insert-item)
    (prvt/TeX-fold-current-line))
   (t
    (error "not configured for document insertions")))
  (when (bound-and-true-p evil-local-mode)
    (evil-insert 1)))

(add-hook! 'TeX-mode-hook :append
           ;; (hl-todo-mode) ;; FIXME
           ;; (LaTeX-math-mode)
           (setq preview-scale 1.8 ;; bigger compiled math
                 display-line-numbers nil)
           (when prvt/LaTeX-hebrew
             (setq bidi-paragraph-direction nil ;; do treat hebrew as right-to-left
                   yas-indent-line nil))) ;; yas doesnt know how to indent in Hebrew LaTex, disable it


(after! tex
  (when prvt/use-TeX-fold
    (advice-add 'LaTeX-math-insert :after 'prvt/TeX-fold-current-line)) ;; auto-fold after inserting math macro with prefix
  (map!
   :map LaTeX-mode-map
   :ei [C-return] 'prvt/LaTeX-insert-item-below
   ;; backspace alias
   :i "M-h" (lambda! (insert "\\"))
   ;; ^{} _{} aliases
   :iv "C-_" (lambda! (doom-snippets-expand :name "subscript-braces"))
   :iv "C-^" (lambda! (doom-snippets-expand :name "superscript-braces"))
   ;; math snippets to switch from hebrew to english to hebrew
   (:when prvt/LaTeX-hebrew
     :envi "M-m" #'prvt/hebrew-math-mode
     :envi "M-r" #'prvt/hebrew-display-math-mode
     :envi "M-R" #'prvt/hebrew-align-math-mode)


   ;; normal stuff here
   (:localleader
     :desc "View" "v" #'TeX-view
     (:when prvt/use-TeX-fold
       :desc "Fold paragraph"     "f" #'TeX-fold-paragraph
       :desc "unFold paragraph"   "C-f" #'TeX-fold-clearout-paragraph
       :desc "Fold buffer"        "F" #'TeX-fold-buffer
       :desc "unFold buffer"      "C-F" #'TeX-fold-clearout-buffer)
     :desc "Preview at point"   "p" #'preview-at-point
     :desc "Preview buffer"     "P" #'preview-buffer
     :desc "Unpreview buffer"   "C-P" #'preview-clearout-buffer

     ;; override C-c C-c to compile with xetex
     :desc "compile with xetex" "c" (lambda! () (let ((TeX-engine 'xetex))
                                                  (TeX-command "LaTeX" 'TeX-master-file))))))
