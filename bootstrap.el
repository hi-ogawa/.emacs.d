;; Install elpa dependencies at once

(require 'package)
(package-initialize)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-refresh-contents)

(require 'cl)
(mapcar
  'package-install
  (mapcar 'car
    (with-temp-buffer
      (insert-file-contents "~/.emacs.d/package_list")
      (car (read-from-string (buffer-string))))))
