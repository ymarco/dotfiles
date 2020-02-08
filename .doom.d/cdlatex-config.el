;; ;;; ~/.doom.d/cdlatex-config.el -*- lexical-binding: t; -*-


;; (use-package! cdlatex
;;   :defer t
;;   :hook (LaTeX-mode . cdlatex-mode)
;;   :config
;;   ;; Disabling keys that have overlapping functionality with other parts of Doom

;;   ;; smartparens takes care of inserting closing delimiters
;;   (define-key cdlatex-mode-map  "$" nil)
;;   (define-key cdlatex-mode-map  "(" nil)
;;   (define-key cdlatex-mode-map  "{" nil)
;;   (define-key cdlatex-mode-map  "[" nil)
;;   (define-key cdlatex-mode-map  "|" nil)
;;   (define-key cdlatex-mode-map  "<" nil)
;;   ;; TAB is used for cdlatex's snippets and navigation. But have yasnippet for that.
;;   (when (featurep! :editor snippets)
;;     (define-key cdlatex-mode-map  "\t" nil))

;;   ;; AUCTeX takes care of auto-inserting {} on _^ if you want, with `TeX-electric-sub-and-superscript'
;;   (define-key cdlatex-mode-map  "^" nil)
;;   (define-key cdlatex-mode-map  "_" nil)
;;   ;; AUCTeX already provides this with `LaTeX-insert-item'
;;   (define-key cdlatex-mode-map  [(control return)] nil))
