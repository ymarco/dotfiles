;;; ~/.doom.d/org-setup.el -*- lexical-binding: t; -*-
;; These are nicer defaults to latex through org. It also configures minted for
;; src code syntex highlighting.
(after! org
  ;; Minted config for much better syntax highlightig to src blocks.
  (setq org-latex-listings 'minted)
  (add-to-list 'org-latex-packages-alist
               (list
                ;; Without outputdir, compilation with minted fails, for some reason.
                (format "outputdir=%s" +org-export-directory)
                "minted"))
  ;; minted calls the pygmentize process and thus needs shell escaping
  (setq org-latex-pdf-process
        '("%latex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "%latex -shell-escape -interaction nonstopmode -output-directory %o %f"
          "%latex -shell-escape -interaction nonstopmode -output-directory %o %f"))

  ;; Margins
  (add-to-list 'org-latex-packages-alist '("a4paper,margin=1in" "geometry"))
  ;; Add 'colorlinks' option to hyperrref, its much prettier
  (setq org-latex-hyperref-template
        "\\hypersetup{
 pdfauthor={%a},
 pdftitle={%t},
 pdfkeywords={%k},
 pdfsubject={%d},
 pdfcreator={%c},
 pdflang={%L},
 colorlinks}"))
;; TODO: somehow add a \setlength{\parindent}{0pt} to all latex exports
