;;; ~/.doom.d/hebrew-latex-config.el -*- lexical-binding: t; -*-
;; TODO make some of this a minor mode, somehow

(defun prvt/set-hebrew-input-method ()
  (activate-input-method "hebrew"))

(defun prvt/set-regular-input-method ()
  (deactivate-input-method))


;;;###autoload
(defun prvt/backwards-till-math ()
  "Go backwards until reaching a math env"
  (interactive)
  (while (not (or (texmathp)
                  (= (point) (point-min))))
    ;; only searching for \ beause all math commands start with a \ (well not tex $$ but I don't use them.)
    (search-backward "\\")))


;;;###autoload
(defun prvt/backwards-till-math-regular ()
  "Call `prvt/backwards-till-math', and go back to normal (English) input method."
  (prvt/backwards-till-math)
  (prvt/set-hebrew-input-method))

;;;###autoload
(defun prvt/forward-exit-math ()
  "Go forward until exiting a math env"
  (interactive)
  (while (and (texmathp)
              (/= (point) (point-max)))
    (forward-char)))

;;;###autoload
(defun prvt/forward-exit-math-hebrew ()
  "Call `prvt/forward-exit-math', and go back to Hebrew input method."
  (interactive)
  (prvt/forward-exit-math)
  (prvt/set-hebrew-input-method))


;;;###autoload
(defun prvt/hebrew-math ()
  "Enter inline math in a Hebrew paragraph in latex.
If already in math mode, exit it and go back to Hebrew."
  (interactive)
  (prvt/set-regular-input-method)
  (if (texmathp)
      (prvt/forward-exit-math-hebrew)
    (doom-snippets-expand :file "/home/yoavm448/.doom.d/snippets/latex-mode/hebrew-math")))

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


;; also use a reasonable font for Hebrew
(set-fontset-font "fontset-default" 'hebrew (font-spec :family "DejaVu Sans"))


(defun prvt/hebrew-set-stuff ()
  "Set Hebrew stuff, used in a hook.
Some of that gets overridden, so we override it back on a hook."
  (interactive)
  (message "prvt/hebrew-mode")
  (setq bidi-paragraph-direction nil  ;; do treat hebrew as right-to-left
        yas-indent-line nil  ;; yas doesnt know how to indent in Hebrew LaTex, disable it
        display-line-numbers nil))  ;; line numbers on both sides annoy me, too much wasted screen estate

(use-package! tex
  :defer t
  :hook (LaTeX-mode . prvt/hebrew-set-stuff)
  :init
  (setq default-input-method "hebrew" ;; dont ask me what language every time
        preview-default-option-list '("displaymath" "floats" "graphics" ;; NO SECTION; compiled sections ruin the hebrew *not in xetex, but I still don't like them*
                                      "textmath" "footnotes"))
  :config
  ;; commands to switch from Hebrew to English to Hebrew in math mode
  (map! :map LaTeX-mode-map
        :envi "M-m" #'prvt/hebrew-math
        :envi "M-M" #'prvt/backwards-till-math-regular
        :envi "M-r" #'prvt/hebrew-display-math-mode
        :envi "M-R" #'prvt/hebrew-align-math-mode))
