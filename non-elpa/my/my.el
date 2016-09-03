(defun my-open-shell-shortcut (buffername)
  "open emacs shell with default buffername"
  (interactive
    (list (read-string "buffer name: " "*shell*-" nil "*shell*-")))
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
    (shell-command (concat "xdg-open \"" (dired-get-filename) "\""))))

;; thanks to http://stackoverflow.com/questions/2472273/how-do-i-run-a-sudo-command-in-emacs
(defun my-sudo-shell-command (command)
  (interactive "MShell command (root): ")
  (shell-command
    (concat "echo " (read-passwd "Password: ") " | sudo -S " command)))

(provide 'my)
