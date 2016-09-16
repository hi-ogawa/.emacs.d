;; Install elpa dependencies at once

(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

(require 'cl)
(mapcar 'package-install
  (with-temp-buffer
    (insert-file-contents "~/.emacs.d/package_list")
    (read-from-string (buffer-string))))
