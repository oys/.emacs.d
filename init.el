(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(setq gc-cons-threshold 100000000)
(setq inhibit-startup-message t)

(defalias 'yes-or-no-p 'y-or-n-p)

(defconst demo-packages
  '(anzu
    bundler
    color-theme-solarized
    company
    duplicate-thing
    ggtags
    helm
    helm-gtags
    helm-projectile
    helm-swoop
    ;; function-args
    clean-aindent-mode
    cmake-mode
    comment-dwim-2
    dtrt-indent
    emmet-mode
    erlang
    flycheck
    flycheck-irony
    magit
    ws-butler
    iedit
    inf-ruby
    irony
    company-irony
    yasnippet
    robe
    smartparens
    sr-speedbar
    sql-indent
    projectile
    virtualenv
    virtualenvwrapper
    volatile-highlights
    web-mode
    undo-tree
    zygospore))

(defun install-packages ()
  "Install all required packages."
  (interactive)
  (unless package-archive-contents
    (package-refresh-contents))
  (dolist (package demo-packages)
    (unless (package-installed-p package)
      (package-install package))))

(install-packages)

;; this variables must be set before load helm-gtags
;; you can change to any prefix key of your choice
(setq helm-gtags-prefix-key "\C-cg")

(add-to-list 'load-path "~/.emacs.d/custom")

(require 'setup-helm)
(require 'setup-helm-gtags)
;; (require 'setup-ggtags)
(require 'setup-cedet)
(require 'setup-editing)
(require 'setup-irony)
(require 'setup-flycheck)
(require 'setup-web-mode)
(require 'setup-c-env)
(require 'setup-ruby-env)

(windmove-default-keybindings)

;; function-args
;; (require 'function-args)
;; (fa-config-default)
;; (define-key c-mode-map  [(tab)] 'company-complete)
;; (define-key c++-mode-map  [(tab)] 'company-complete)

;; company
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(delete 'company-semantic company-backends)
(delete 'company-clang company-backends)
(define-key c++-mode-map  [(tab)] 'company-irony)
;; (define-key c-mode-map  [(control tab)] 'company-complete)
;; (define-key c++-mode-map  [(control tab)] 'company-complete)

(global-set-key (kbd "RET") 'newline-and-indent)  ; automatically indent when press RET

;; activate whitespace-mode to view all whitespace characters
(global-set-key (kbd "C-c w") 'whitespace-mode)

;; show unncessary whitespace that can mess up your diff
(add-hook 'prog-mode-hook (lambda () (interactive) (setq show-trailing-whitespace 1)))

;; use space to indent by default
(setq-default indent-tabs-mode nil)

;; set appearance of a tab that is represented by 4 spaces
(setq-default tab-width 4)

;; Compilation
(global-set-key (kbd "<f5>") (lambda ()
                               (interactive)
                               (setq-local compilation-read-command nil)
                               (call-interactively 'compile)))

;; setup GDB
(setq
 ;; use gdb-many-windows by default
 gdb-many-windows nil

 ;; Non-nil means display source file containing the main routine at startup
 gdb-show-main nil
 )

;; Package: clean-aindent-mode
(require 'clean-aindent-mode)
(add-hook 'prog-mode-hook 'clean-aindent-mode)

;; Package: dtrt-indent
(require 'dtrt-indent)
(dtrt-indent-mode 1)

;; Package: ws-butler
(require 'ws-butler)
(add-hook 'prog-mode-hook 'ws-butler-mode)

;; Package: yasnippet
(require 'yasnippet)
(yas-global-mode 1)

;; Package: smartparens
(require 'smartparens-config)
(setq sp-base-key-bindings 'paredit)
(setq sp-autoskip-closing-pair 'always)
(setq sp-hybrid-kill-entire-symbol nil)
(sp-use-paredit-bindings)

(show-smartparens-global-mode +1)
(smartparens-global-mode 1)

;; Package: projejctile
(require 'projectile)
(projectile-global-mode)
(setq projectile-enable-caching t)

(require 'helm-projectile)
(helm-projectile-on)
(setq projectile-completion-system 'helm)
(setq projectile-indexing-method 'alien)

;; Package zygospore
(global-set-key (kbd "C-x 1") 'zygospore-toggle-delete-other-windows)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("c567c85efdb584afa78a1e45a6ca475f5b55f642dfcd6277050043a568d1ac6f" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" default)))
 '(default-input-method "korean-hangul")
 '(frame-background-mode (quote dark))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Iosevka Term" :foundry "PfEd" :slant normal :weight normal :height 120 :width normal)))))

;; Set Korean font-family
(set-fontset-font t 'hangul (font-spec :name "NanumGothicCoding"))

;; Show sr-sppedbar window on the left.
(setq sr-speedbar-right-side nil)

;; Load the solarized-dark color theme.
(load-theme 'solarized t)

;; sql-indent
(eval-after-load "sql"
  (load-library "sql-indent"))

;; emmet-mode
(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'html-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook  'emmet-mode)
(add-hook 'web-mode-hook 'emmet-mode)

;; Disable tool-bar, menu-bar, scroll-bar
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(tool-bar-mode -1)

(defun toggle-current-window-dedication ()
  (interactive)
  (let* ((window    (selected-window))
         (dedicated (window-dedicated-p window)))
    (set-window-dedicated-p window (not dedicated))
    (message "Window %sdedicated to %s"
             (if dedicated "no longer " "")
             (buffer-name))))

(global-set-key (kbd "C-c -") 'toggle-current-window-dedication)
(put 'erase-buffer 'disabled nil)

;; Load $HOME/.bashrc file when shell-command execute.
(setq shell-command-switch "-ic")

(defun set-window-width (n)
  "Set the selected window's width."
  (adjust-window-trailing-edge (selected-window) (- n (window-width)) t))

(defun set-80-columns ()
  "Set the selected window to 80 columns."
  (interactive)
  (set-window-width 80))

(global-set-key "\C-x~" 'set-80-columns)
