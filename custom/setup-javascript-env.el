(require 'tern)

(add-to-list 'company-backends 'company-tern)
(add-hook 'js-mode-hook (lambda()
                          (tern-mode t)
                          (yas-minor-mode t)))

(provide 'setup-javascript-env)
