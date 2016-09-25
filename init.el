;; Environment
;;  (version) =>
;;    GNU Emacs 24.5.1 (x86_64-pc-linux-gnu, GTK+ Version 3.18.9)
;;    of 2016-04-18 on lgw01-04, modified by Debian

;;;;;;;;;;;;;;
;; build-in ;;
;;;;;;;;;;;;;;

;; theme style
(load-theme 'manoj-dark)

;; less gui component
(menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)

;; no auto save
(auto-save-mode -1)
(setq make-backup-files nil)

;; misc
(setq column-number-mode t)
(show-paren-mode 1)
(electric-pair-mode 1)
(setq electric-pair-pairs '((34 . 34)))
(setq-default indent-tabs-mode nil)
(set-default 'truncate-lines t)

;; copy & paste
(cond (window-system (setq x-select-enable-clipboard t)))

;; Common User Access mode
(cua-mode t)
(setq cua-enable-cua-keys nil)

;; deal with dumb emacs shell
(setenv "PAGER" "cat")

;; less "jumpy" scroll
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil)            ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't)                  ;; scroll window under mouse
(setq scroll-step 1)                                ;; keyboard scroll one line at a time

;; suppress warning when huge outputs on shell
(require 'warnings)
(add-to-list 'warning-suppress-types '(undo discard-info))

(server-start)

;; https://www.emacswiki.org/emacs/GlobalTextScaleMode
(require 'face-remap)
(setq text-scale-mode-step 1.1)
(define-global-minor-mode global-text-scale-mode text-scale-mode
  (lambda ()
    (text-scale-mode t)
    (text-scale-set -1)))
(global-text-scale-mode t)


;;;;;;;;;;
;; elpa ;;
;;;;;;;;;;

;; package.el
(require 'package)
(package-initialize)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; elscreen
(elscreen-start)
(global-set-key (kbd "<C-tab>")         'elscreen-next)
(global-set-key (kbd "<C-iso-lefttab>") 'elscreen-previous) ;; "<S-C-tab>" might be right for some key layout
(add-hook 'dired-mode-hook
          (lambda ()
            (local-set-key "\C-z\C-o" (lambda () (interactive) (elscreen-find-file (dired-get-filename))))))

;; helm
(require 'helm-config)
(helm-mode 1)
(global-set-key (kbd "M-x") 'helm-M-x)
(add-hook 'shell-mode-hook
	  (lambda ()
            (local-set-key (kbd "M-r") 'helm-comint-input-ring)))

(require 'helm-swoop)
(global-set-key (kbd "C-; C-s") 'helm-swoop)

;; projectile
(projectile-global-mode)
(setq projectile-completion-system 'helm)
(setq projectile-enable-caching t)

;; dired-hacks-utils, dired-subtree, dired-filter
(require 'dired-hacks-utils)
(require 'dired-subtree)
(require 'dired-filter)
(define-key dired-mode-map (kbd "i") 'dired-subtree-toggle)

;; transpose-frame
(require 'transpose-frame)
(global-set-key (kbd "C-; C-r") 'rotate-frame-clockwise)

;; edit-with-emacs: https://github.com/stsquad/emacs_chrome
(require 'edit-server)
(edit-server-start)
(setq edit-server-new-frame t)
(define-key edit-server-edit-mode-map (kbd "C-x C-s")
   (lambda () (interactive) (message "nop.")))
(add-hook 'edit-server-edit-mode-hook
  (lambda () (delete-other-windows)))

;; yaml-mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))

;; web-mode: http://web-mode.org/
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(setq web-mode-code-indent-offset 2)

(require 'coffee-mode)

(require 'magit)
(global-set-key (kbd "C-; g") 'magit-status)

(require 'dockerfile-mode)
(require 'docker-tramp)

(require 'xcscope)
(cscope-setup)

(require 'slim-mode)

;;;;;;;;;;;;;;
;; non-elpa ;;
;;;;;;;;;;;;;;

;; my own custom library
(add-to-list 'load-path (expand-file-name "~/.emacs.d/non-elpa/my"))
(require 'my)
(global-set-key (kbd "C-; C-t") 'my-open-shell-shortcut)
(my-delete-trailing-whitespace-mode t)
(add-hook 'dired-mode-hook
  (lambda ()
    (local-set-key (kbd "C-c C-o") 'my-open-from-dired)))
(global-set-key (kbd "C-; M-!") 'my-sudo-shell-command)
(global-set-key (kbd "C-; RET") 'my-mark-symbol-at-point)
(global-set-key (kbd "C-; C-e") 'my-google-symbol-at-point)


;;;;;;;;;;;;
;; others ;;
;;;;;;;;;;;;

(global-set-key (kbd "C-c t")        'toggle-truncate-lines)
(global-set-key (kbd "C-<")          'comment-region)
(global-set-key (kbd "C->")          'uncomment-region)
(global-set-key (kbd "M-N")          'cua-scroll-up)
(global-set-key (kbd "M-P")          'cua-scroll-down)

(global-set-key (kbd "M-m") (lambda () (interactive) (call-interactively 'man)))
(global-set-key (kbd "C-; C-l") (lambda () (interactive) (shell-command "gnome-terminal")))
(global-set-key (kbd "C-; C-b") 'browse-url)
(global-set-key (kbd "C-; C-o") 'pop-to-mark-command)

(add-hook 'dired-mode-hook
  (lambda ()
    (dired-hide-details-mode)
    (local-set-key (kbd "-") 'dired-up-directory)))

;; ruby
(setq ruby-insert-encoding-magic-comment nil)
