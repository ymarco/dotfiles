;;; ~/.doom.d/cdlatex-config.el -*- lexical-binding: t; -*-


;;;###autoload
(defun prvt/cdlatex-math-symbol (&optional start-level)
  "Override cdlatex-math-symbol to have optional start-level param"
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

;;;###autoload
(defun prvt/cdlatex-math-symbol-3 ()
  "Same as `cdlatex-math-symbol', but starts from level 3."
  (interactive)
  (cdlatex-math-symbol 3))

;;;###autoload
(defun prvt/cdlatex-tab-movement ()
  "Only emulate the MOVEMENT done by TAB on cdlatex - don't expand abbrevs.
Symplify sub/superscripts as a bonus."
  (interactive)
  (let (cdlatex-command-alist) ;; dont expand any snippets
    (cdlatex-tab)))

;; use cdlatex, but only its math-modify and math-symbol-table
(use-package! cdlatex
  :defer t
  :hook (LaTeX-mode . cdlatex-mode)
  :init
  (message "cdlatex :init")
  (setq cdlatex-math-symbol-prefix ?\;
        prvt/cdlatex-3rd-math-symbol-prefix "s-;"
        cdlatex-math-symbol-alist
        '( ;; adding missing functions to 3rd level symbols
          (?_    ("\\downarrow"  ""           "\\inf"))
          (?^    ("\\uparrow"    ""           "\\sup"))
          (?k    ("\\kappa"      ""           "\\ker"))
          (?m    ("\\mu"         ""           "\\lim"))
          (?d    ("\\delta"      "\\partial"  "\\dim"))
          (?D    ("\\Delta"      "\\nabla"    "\\deg"))
          ;; no idea why Phi isnt on F in first place
          (?F    ("\\Phi"))
          ;; now just conveniance
          (?:    ("\\dots")))
        cdlatex-math-modify-alist
        '( ;; my own stuff
          (?/  "\\oner"        nil          t    nil  nil)
          (?h  "\\half"        nil          t    nil  nil)))

  :config
  ;; disable everithing except math-symbol-prefix and math-modify-prefix
  (advice-add 'cdlatex-math-symbol :override 'prvt/cdlatex-math-symbol) ;; this lets me have a keybind that goes straight to the 3rd level
  (when prvt/use-TeX-fold
    (advice-add 'cdlatex-math-symbol :after 'prvt/TeX-fold-current-line)) ;; auto-fold after inserting math macro with prefix

  (define-key cdlatex-mode-map  "$" nil)
  (define-key cdlatex-mode-map  "(" nil)
  (define-key cdlatex-mode-map  "{" nil)
  (define-key cdlatex-mode-map  "[" nil)
  (define-key cdlatex-mode-map  "|" nil)
  (define-key cdlatex-mode-map  "<" nil)
  (define-key cdlatex-mode-map  "^" nil)
  (define-key cdlatex-mode-map  "_" nil)
  ;; (define-key cdlatex-mode-map  "\t" nil)
  (define-key cdlatex-mode-map  [(control return)] nil)
  (map! :map cdlatex-mode-map
        :n "," 'prvt/cdlatex-tab-movement
        :i "`" 'prvt/cdlatex-math-symbol-3))
