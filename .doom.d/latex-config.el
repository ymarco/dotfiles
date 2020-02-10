;;; ~/.doom.d/latex-config.el -*- lexical-binding: t; -*-

(load! "cdlatex-config")

(defvar prvt/use-TeX-fold t
  "Use TeX fold in TeX-mode.
When set to non-nil, this adds a few hooks/advices to fold stuff.")

(setq
 TeX-electric-sub-and-superscript nil ;; dont auto-insert braces on _^
 TeX-save-query nil ;; just save, dont ask me
 preview-auto-cache-preamble t ;; just cache, dont ask me
 font-latex-fontify-script nil) ;; don't raise/lower super/subscripts



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
                                  ("𝔽" ("FF")))))

(load! "fontification")
(appendq! font-latex-match-math-command-keywords ;; just adding my own macros as keywords
          '(("oner")
            ("half")
            ("pa")
            ("bra")
            ("bre")
            ("pba")
            ("bpa")
            ("abs")))

;; Making \( \) less visible
(defface unimportant-latex-face
  '((t
     :inherit font-lock-comment-face))
  "Face used to make \\(\\), \\[\\] less visible."
  :group 'LaTeX-math)
(font-lock-add-keywords
 'latex-mode
 `((,(rx (and "\\" (any "()[]"))) 0 'unimportant-latex-face prepend))
 'end)


(custom-set-faces! '(rainbow-delimiters-depth-1-face
                     :foreground nil
                     :inherit rainbow-delimiters-depth-6-face)) ;; on default, 1-depth braces don't stand out in latex math
(custom-set-faces! '(preview-reference-face
                     :inherit solaire-default-face))            ;; fixes latex preview background color in solaire
(custom-set-faces! '(preview-face
                     :inherit org-block))                       ;; just configured for the theme
(custom-set-faces! '(TeX-fold-folded-face
                     :inherit font-lock-builtin-face))          ;; just configured for the theme


(add-hook! 'TeX-mode-hook :append
           ;; (hl-todo-mode) ;; FIXME
           (setq preview-scale 1.8 ;; bigger compiled math cause it's beautiful
                 company-idle-delay nil)) ;; auto-complete is annoying here

(defadvice! prvt/TeX-fold-line-a (&rest _)
  "Auto-fold LaTeX macros after functions that typically insert them."
  :after #'cdlatex-math-symbol
  (progn
    (TeX-fold-region (line-beginning-position) (line-end-position))))

(after! tex
  ;; auto-fold after inserting math macro with prefix
  (map!
   :map LaTeX-mode-map
   :ei [C-return] #'LaTeX-insert-item
   ;; backspace alias, the best thing ever
   :i "M-h" (lambda! (insert "\\"))
   ;; ^ alias: TODO keep this?
   :i "M--" (lambda! (insert "^"))
   ;; ^{} _{} aliases
   :iv "C-_" (lambda! (doom-snippets-expand :name "subscript-braces"))
   :iv "C-^" (lambda! (doom-snippets-expand :name "superscript-braces"))

   ;; normal stuff here
   :localleader
   :desc "View" "v" #'TeX-view
   :desc "Preview at point"   "p"   #'preview-at-point
   :desc "Preview buffer"     "P"   #'preview-buffer
   :desc "Unpreview buffer"   "C-p" #'preview-clearout-buffer
   (:when prvt/use-TeX-fold
     :desc "Fold paragraph"     "f"   #'TeX-fold-paragraph
     :desc "Unfold paragraph"   "C-f" #'TeX-fold-clearout-paragraph
     :desc "Fold buffer"        "F"   #'TeX-fold-buffer
     :desc "Unfold buffer"      "C-F" #'TeX-fold-clearout-buffer)))
