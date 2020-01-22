;;; ~/.doom.d/hebrew-latex-config.el -*- lexical-binding: t; -*-


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
  "Enters display math mode in latex. add newlines beforehand if needed."
  (interactive)
  (prvt/set-regular-input-method)
  (doom-snippets-expand :file "/home/yoavm448/.doom.d/snippets/latex-mode/hebrew-display-math"))

;;;###autoload
(defun prvt/hebrew-align-math-mode ()
  "Enters display math mode in latex."
  (interactive)
  (prvt/set-regular-input-method)
  (doom-snippets-expand :file "/home/yoavm448/.doom.d/snippets/latex-mode/hebrew-align-math"))

;;;###autoload
(defun prvt/backwards-till-math ()
  "Go backwards until reaching a math env"
  (interactive)
  (while (not (or (texmathp) (eq (point) (point-min))))
    ;; only searching for \$ beause all math commands start with a \ (well not tex $$ but I don't use them.)
    (search-backward "\\")))

;;;###autoload
(defun prvt/forward-exit-math ()
  "Go forward until exiting a math env"
  (interactive)
  (while (and (texmathp) (not (equal (point) (point-max))))
    (forward-char))
  ;; in vim, go a step back
  ;; (backward-char)
  )

;; also use a reasonable font for Hebrew
(set-fontset-font "fontset-default" 'hebrew (font-spec :family "DejaVu Sans"))

(defun prvt/hebrew ()
  (interactive)
  "Set Hebrew stuff"
  (setq bidi-paragraph-direction nil  ;; do treat hebrew as right-to-left
        yas-indent-line nil  ;; yas doesnt know how to indent in Hebrew LaTex, disable it
        display-line-numbers nil  ;; line numbers on both sides annoy me, too much wasted screen estate
        default-input-method "hebrew" ;; dont ask me what language every time
        preview-default-option-list '("displaymath" "floats" "graphics" ;; NO SECTION; compiled sections ruin the hebrew *not in xetex, but I still don't like them*
                                      "textmath" "footnotes")))

;; FIXME when this becomes a module, remove this:
(add-hook! 'TeX-mode-hook #'prvt/hebrew)

(after! tex
  ;; math snippets to switch from hebrew to english to hebrew
  (map! :map LaTeX-mode-map
        :envi "M-m" #'prvt/hebrew-math-mode
        :envi "M-r" #'prvt/hebrew-display-math-mode
        :envi "M-R" #'prvt/hebrew-align-math-mode))
