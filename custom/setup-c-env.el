(require 'company)

(define-key c-mode-map  [(tab)] 'company-irony)

;; company-c-headers
(add-to-list 'company-backends 'company-c-headers)

;; hs-minor-mode for folding source code
(add-hook 'c-mode-common-hook 'hs-minor-mode)

(defun my-c-mode-hook()
  (setq c-default-style "linux")
  (setq indent-tabs-mode nil)
  (c-set-offset 'substatement-open 0))

(add-hook 'c-mode-common-hook 'my-c-mode-hook)

(provide 'setup-c-env)
