(require 'package)

(add-to-list 'package-archives '(org . http://orgmode.org/elpa/))
(add-to-list 'package-archives '(melpa . http://melpa.org/packages/))
(add-to-list 'package-archives '(melpa-stable . http://stable.melpa.org/packages/))

(setq package-enable-at-startup nil)
(package-initialize)

(require 'evil)
(evil-mode t)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (auctex evil-visual-mark-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; AUCTeX configuration

(setq TeX-auto-save t)
(setq TeX-parse-self t)

;; use pdflatex
(setq TeX-PDF-mode t)

;; use evince for dvi and zathura pdf viewer
;; evince-dvi backend should be installed
(setq TeX-view-program-selection
      '((output-dvi "DVI Viewer")
        (output-pdf "PDF Viewer")))
(setq TeX-view-program-list
      '(("DVI Viewer" "evince %o")
        ("PDF Viewer" "zathura %o")))

;;LaTex config

;(require 'auto-complete-auctex)
(load "auctex.el" nil t t)

(setq TeX-PDF-from-DVI "Dvips") 
; basic configuration
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-PDF-mode t)
(setq-default TeX-master t)
(add-hook 'LaTeX-mode-hook 'auto-fill-mode)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'linum-mode)
