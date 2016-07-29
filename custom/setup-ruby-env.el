(require 'bundler)

(add-hook 'ruby-mode-hook 'robe-mode)
(eval-after-load 'company
  '(push 'company-robe company-backends))
(define-key ruby-mode-map  [(tab)] 'company-robe)

(provide 'setup-ruby-env)
