;;; ~/.doom.d/hebrew-latex-config.el -*- lexical-binding: t; -*-
;; TODO make some of this a minor mode, somehow


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
  (hebrew-set-hebrew-input-method))

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
  (hebrew-set-hebrew-input-method))


;;;###autoload
(defun prvt/hebrew-math ()
  "Enter inline math in a Hebrew paragraph in latex.
If already in math mode, exit it and go back to Hebrew."
  (interactive)
  (hebrew-set-regular-input-method)
  (if (texmathp)
      (prvt/forward-exit-math-hebrew)
    (doom-snippets-expand :file "/home/yoavm448/.doom.d/snippets/latex-mode/hebrew-math")))

;;;###autoload
(defun prvt/hebrew-display-math-mode ()
  "Enters display math mode in latex. add newlines beforehand if needed."
  (interactive)
  (hebrew-set-regular-input-method)
  (doom-snippets-expand :file "/home/yoavm448/.doom.d/snippets/latex-mode/hebrew-display-math"))

;;;###autoload
(defun prvt/hebrew-align-math-mode ()
  "Enters display math mode in latex."
  (interactive)
  (hebrew-set-regular-input-method)
  (doom-snippets-expand :file "/home/yoavm448/.doom.d/snippets/latex-mode/hebrew-align-math"))


(defun prvt/hebrew-set-stuff ()
  "Set Hebrew stuff, used in a hook.
Some of that gets overridden, so we override it back on a hook."
  (interactive)
  ;; yas doesnt know how to indent in Hebrew LaTex,
  ;; disable it
  (setq yas-indent-line nil))


(use-package hebrew-mode
  :hook (LaTeX-mode . hebrew-mode))

(use-package! tex
  :defer t
  :init
  ;; Remove section; compiled sections ruin the hebrew. (not in xetex, but I
  ;; still don't like them.)
  (setq preview-default-option-list '("displaymath" "floats" "graphics"
                                      "textmath" "footnotes"))
  :config
  ;; commands to switch from Hebrew to English to Hebrew in math mode
  (map! :map LaTeX-mode-map
        :envi "M-m" #'prvt/hebrew-math
        :envi "M-M" #'prvt/backwards-till-math-regular
        :envi "M-r" #'prvt/hebrew-display-math-mode
        :envi "M-R" #'prvt/hebrew-align-math-mode

        ;; have <SPC m c> compile with xetex. That way, previews are
        ;; generated with pdlatex and compiles with xetex.
        :localleader
        :desc "compile with xetex" "c"
        (lambda! () (cl-destructuring-bind (TeX-engine) ('xetex)
                      (TeX-command "LaTeX" 'TeX-master-file)))))
