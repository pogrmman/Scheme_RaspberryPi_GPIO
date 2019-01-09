;; Copyright 2019 Alexander Mohn
;; This library is released under the GNU General Public License v3.
;; See the LICENSE file in the accompanying directory for more details.

;; This library gives the correct command line arguments to scripts run under
;; scheme-r7rs for Cyclone scheme. It allows the script to ignore those arguments
;; given to icyc and to not show the tempfile name
(define-library (lib args)
  (import (scheme base)
	  (scheme process-context))
  (export get-args)
  (begin
    (define (get-args)
      (remove-last (cddr (command-line-arguments))))
    (define (remove-last lst)
      (reverse
       (cdr (reverse lst))))))
