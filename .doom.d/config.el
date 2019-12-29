;;; .doom.d/config.el -*- lexical-binding: t; -*-


;; SOME CONFIG
(setq
 avy-keys '(?a ?o ?e ?u ?i ?d ?h ?t ?t ?n ?s) ;; dvorak home row
 dired-dwim-target t
 bidi-paragraph-direction nil)

(set-fontset-font "fontset-default" 'hebrew (font-spec :family "Dejavu Sans"))


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

;; DVORAK LAYOUT
(after! quail
  (add-to-list 'quail-keyboard-layout-alist
               `("dvorak" . ,(concat "                              "
                                     "  1!2@3#4$5%6^7&8*9(0)[{]}`~  "
                                     "  '\",<.>pPyYfFgGcCrRlL/?=+    "
                                     "  aAoOeEuUiIdDhHtTnNsS-_\\|    "
                                     "  ;:qQjJkKxXbBmMwWvVzZ        "
                                     "                              "))))
(quail-set-keyboard-layout "dvorak")

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

(defun hebrew-math-mode ()
  "enters inline math in a hebrew paragraph in latex"
  (interactive)
  (set-evil-regular-insert)
  (reinsert-evil)
  (doom-snippets-expand :file "/home/yoavm448/.doom.d/snippets/latex-mode/hebrew-math"))

(defun hebrew-display-math-mode ()
  "enters math in display mode in latex"
  (interactive)
  (set-evil-regular-insert)
  (reinsert-evil)
  (doom-snippets-expand :file "/home/yoavm448/.doom.d/snippets/latex-mode/hebrew-display-math"))

(defface unimportant-latex-face
  '((t :height 0.7
       :inherit font-lock-comment-face))
  "Face used on less relevant math commands."
  :group 'LaTeX-math)

(font-lock-add-keywords
 'latex-mode
 `((,(rx (and "\\" (or "(" ")"))) 0 'unimportant-latex-face prepend))
 'end)


(font-lock-add-keywords 'latex-mode
                        `((,(rx (and "\\" (or "arccos" "arcsin" "arctan" "arg" "cos" "cosh" "cot" "coth" "csc" "tanh"
                                              "deg" "det" "dim" "exp" "Pr" "proj" "sec" "sin" "sinh" "sup" "tan"
                                              "gcd" "hom" "inf" "inj" "ker" "lg" "lim" "ln" "log" "max" "min")))
                           0 'font-lock-constant-face prepend))
                        'end)

(add-hook! 'TeX-mode-hook :append
  (setq
   bidi-paragraph-direction nil ;; treat hebrew as right-to-left
   preview-transparent-color nil ;; this does nothing afaik
   ;; preview-colors nil ;; this does nothing afaik
   preview-auto-cache-preamble t ;; don't ask me again
   preview-scale 1.7 ;; bigger math
   preview-default-option-list '("displaymath" "floats" "graphics" "textmath" "footnotes")) ;; no section; it ruins the hebrew

  (map!
   :g "M-m" 'hebrew-math-mode ;; enter math mode
   :g "M-r" 'hebrew-display-math-mode ;; enter display math mode
   :g "M-g" 'TeX-fold-paragraph ;; fold math symbols into unicode at current paragraph
   :g "M-S-g" 'TeX-fold-buffer ;; fold math symbols into unicode on whole buffer
   :g "M-g" 'preview-at-point ;; compile math to latex images at point
   :g "M-g" 'preview-buffer) ;; compile math to latex images on whole buffer
  (appendq! TeX-fold-math-spec-list '(
                                      ;; missing symbols
                                      ("≤" ("le"))
                                      ("≥" ("ge"))
                                      ("≠" ("ne"))
                                      ;; conviniance shorts
                                      ("‹" ("left"))
                                      ("›" ("right"))
                                      ("⟦" ("["))
                                      ("⟧" ("]"))
                                      ;; ( "\\(" ("(") )
                                      ;; ( "\\)" (")") )
                                      ;; ("⬪" ("(" ")" "left" "right"))
                                      ;; private macros
                                      ("ℝ" ("RR"))
                                      ("ℕ" ("NN"))
                                      ("ℚ" ("QQ"))
                                      ("ℤ" ("ZZ"))
                                      ("ℂ" ("CC"))
                                      ("𝔽" ("FF")))))
