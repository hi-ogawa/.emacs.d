(defun my-string-match (regex str n)
  "https://www.emacswiki.org/emacs/ElispCookbook#toc34"
  (interactive)
  (save-match-data
    (progn (string-match regex str)
           (match-string n str))))

(defun my-dirname (path)
  "elisp version of dirname(1)"
  (interactive)
  (my-string-match "\\([^/]*\\)/?$" path 1))

(defun my-open-shell-shortcut (buffername)
  "open emacs shell with default buffername"
  (interactive
    (list
      (read-string
        "buffer name: "
        (concat "*shell*-" (my-dirname (expand-file-name default-directory)))
        nil nil)))
  (shell buffername))

;; http://emacswiki.org/emacs/DeletingWhitespace#toc3
(define-minor-mode my-delete-trailing-whitespace-mode
  "delete trailing whitespaces in each line upon save a file"
  :global t
  (cond
   (my-delete-trailing-whitespace-mode
    (add-hook 'before-save-hook 'delete-trailing-whitespace))
   (t
    (remove-hook 'before-save-hook 'delete-trailing-whitespace))))

(defun my-open-from-dired ()
  "open a file above the cursor in dired-mode"
  (interactive)
  (save-window-excursion
    (shell-command (concat "xdg-open \"" (dired-filename-at-point) "\""))))

;; thanks to http://stackoverflow.com/questions/2472273/how-do-i-run-a-sudo-command-in-emacs
(defun my-sudo-shell-command (command)
  (interactive "MShell command (root): ")
  (shell-command
    (concat "echo " (read-passwd "Password: ") " | sudo -S " command)))

(defun my-mark-thing-at-point (thing)
  (letrec
    ((bnd (bounds-of-thing-at-point thing))
     (start (car bnd))
     (end (cdr bnd)))
    (set-mark start)
    (goto-char end)))

(defun my-mark-symbol-at-point ()
  (interactive)
  (my-mark-thing-at-point 'symbol))

(defun my-google-symbol-at-point ()
  (interactive)
  (shell-command
    (concat
      "xdg-open https://www.google.co.jp/search?q="
      (thing-at-point 'symbol))))

(require 'package)
(require 'cl)
(require 'dash)
(defun my-save-package-list ()
  "save the list of current packages to `package_list` for bootstrap.el"
  (interactive)
  (with-temp-file "~/.emacs.d/package_list"
    (insert
      (pp-to-string
        (-sort
          (lambda (p q) (string< (car p) (car q)))
          package-alist)))))

(advice-add 'package-install :after (lambda (pkg) (my-save-package-list)))
(advice-add 'package-delete :after (lambda (pkg) (my-save-package-list)))


(provide 'my)
