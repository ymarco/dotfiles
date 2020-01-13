;;; ~/.doom.d/cdlatex-config.el -*- lexical-binding: t; -*-


;;;###autoload
(defun prvt/cdlatex-math-symbol (&optional start-level)
  "override cdlatex-math-symbol to have optional start-level param"
  (interactive)
  (let* ((start-level (or start-level 1))
         (cell (cdlatex-read-char-with-help
                cdlatex-math-symbol-alist-comb
                start-level cdlatex-math-symbol-no-of-levels
                "Math symbol level %d of %d: "
                "AVAILABLE MATH SYMBOLS.  [%c]=next level "
                cdlatex-math-symbol-prefix
                (get 'cdlatex-math-symbol-alist-comb 'cdlatex-bindings)))
         (char (car cell))
         (level (cdr cell))
         (entry (assoc char cdlatex-math-symbol-alist-comb))
         (symbol (nth level entry)))

    (if (or (not symbol)
            (not (stringp symbol))
            (equal symbol ""))
        (error "No such math symbol %c on level %d" char level))

    (if (or (not (texmathp))
            (cdlatex-number-of-backslashes-is-odd))
        (cdlatex-dollar))

    (insert symbol)
    (when (string-match "\\?" symbol)
      (cdlatex-position-cursor))))


(defun prvt/cdlatex-math-symbol-3 ()
  (interactive)
  (cdlatex-math-symbol 3))
;; use cdlatex, but only its math-modify and math-symbol-table
(use-package! cdlatex
  :hook (LaTeX-mode . cdlatex-mode)
  ;; :after latex
  :init
  (message "cdlatex :init")
  (setq cdlatex-math-symbol-prefix ?\;
        prvt/cdlatex-3rd-math-symbol-prefix "C-;"
        ;; workaround for not being able to change the keymap reliably
        cdlatex-paired-parens ""
        cdlatex-simplify-sub-super-scripts nil
        cdlatex-math-symbol-alist ;; adding missing funcs to 3rd level symbols
        '((?_  ("\\downarrow"    ""            "\\inf"))
          (?^  ("\\uparrow"      ""            "\\sup"))
          (?k  ("\\kappa"        ""            "\\ker"))
          (?m  ("\\mu"           ""            "\\lim"))
          (?d  ("\\delta"        "\\partial"   "\\dim"))
          (?D  ("\\Delta"        "\\nabla"     "\\deg"))))
  :config
  ;; disable everithing except math-symbol-prefix and math-modify-prefix
  (define-key cdlatex-mode-map  "$" nil)
  (define-key cdlatex-mode-map  "(" nil)
  (define-key cdlatex-mode-map  "{" nil)
  (define-key cdlatex-mode-map  "[" nil)
  (define-key cdlatex-mode-map  "|" nil)
  (define-key cdlatex-mode-map  "<" nil)
  (define-key cdlatex-mode-map  "^" nil)
  (define-key cdlatex-mode-map  "_" nil)

  (define-key cdlatex-mode-map  "\t" nil)
  (define-key cdlatex-mode-map  [(control return)] nil)
  (advice-add 'cdlatex-math-symbol :override 'prvt/cdlatex-math-symbol) ;; auto-fold after inserting math macro with prefix
  ;; (setq cdlatex-mode-map (make-sparse-keymap)) ;; zero out the keymap
  ;; now just add the math-symbol key and
  ;; (map! :map cdlatex-mode-map
  ;;       :i (cdlatex-get-kbd-vector ?\;) 'cdlatex-math-symbol
  ;;       :i (cdlatex-get-kbd-vector cdlatex-math-modify-prefix) 'cdlatex-math-modify
  ;;       :i (cdlatex-get-kbd-vector ?:) 'cdlatex-math-symbol)
  ;; (define-key cdlatex-mode-map
  ;; (cdlatex-get-kbd-vector cdlatex-math-symbol-prefix)
  ;; 'prvt/cdlatex-math-symbol-3)
  (define-key cdlatex-mode-map
    (cdlatex-get-kbd-vector prvt/cdlatex-3rd-math-symbol-prefix)
    'prvt/cdlatex-math-symbol-3)
    ;; (define-key cdlatex-mode-map
    ;; (cdlatex-get-kbd-vector cdlatex-math-modify-prefix)
    ;; 'cdlatex-math-modify
    )
