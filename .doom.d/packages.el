;; -*- no-byte-compile: t; -*-
;;; .doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:host github :repo "username/repo"))
;; (package! builtin-package :disable t)

;; (package! cdlatex :pin "b7af5a9884")

(package! sxhkd-mode
  :pin "70b31ef884"
  :recipe (:host github :repo "yoavm448/sxhkd-mode"))

(package! xelb :pin "5970017d9b")
(package! evil-tex
  :recipe (:host github :repo "itai33/evil-tex"))
