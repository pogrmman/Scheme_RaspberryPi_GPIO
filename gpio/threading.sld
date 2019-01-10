;; Copyright 2019 Alexander Mohn
;;
;;    This file is part of the Cyclone Scheme WiringPi Bindings.
;;
;;    The Cyclone Scheme WiringPi Bindings are free software: you can 
;;    redistribute and/or modify them under the terms of the GNU General
;;    Public License as published by the Free Software Foundation, either
;;    version 3 of the License, or (at your option) any later version.
;;
;;    The Cyclone Scheme WiringPi Bindings are distributed in the hope 
;;    that they will be useful, but WITHOUT ANY WARRANTY; without even the
;;    implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
;;    See the GNU General Public License for more details.
;;
;;   You should have received a copy of the GNU General Public License
;;   along with the Cyclone Scheme WiringPi Bindings.  
;;   If not, see <https://www.gnu.org/licenses/>.

;; Instead of writing an interface to the wiringPi threading API, it's probably
;; better to just use Cyclone's threading API via SRFI 18.

(define-library (raspberry-pi gpio threading)
  (import (scheme base)
	  (srfi 18))

  (export def-thread start-thread! mutex-lock! mutex-unlock!)

  (begin
    (define-syntax def-thread
      (syntax-rules ()
	((def-thread name body ...)
	 (define name
	   (make-thread (lambda () body ...) 'name)))))))
