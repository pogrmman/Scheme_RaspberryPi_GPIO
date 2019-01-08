#!/usr/bin/env scheme-r7rs
;; This scheme script modifies the output of cyclone -d to include additional
;; libraries needed to link the program, then runs that modified output.
(import (scheme base)
	(scheme write)
	(scheme file)
	(lib args))

;; Usage Hint
(define (usage)
  (display "Compile a Scheme program that requires linking additional")
  (newline)
  (display "C libraries beyond those linked by Cyclone Scheme.")
  (newline)
  (display "Usage: cyclone_link [-f] PGM [-l libs]")
  (newline)
  (newline)
  (display "The program, PGM, is either specified as the first argument")
  (newline)
  (display "or as the argument following a -f flag.")
  (exit))

;; Argument Parsing
(define (flag? arg)
  (eq? (string-ref arg 0) #\-))

(define (parse-prog args parsed)
  (if (null? args)
      parsed
      (let ((next (car args))
	    (lookahead (if (null? (cdr args))
			   #f
			   (cadr args))))
	(cond ((flag? next)
	       (error "-f flag must be followed by a program!")
	       (exit))
	      ((and lookahead (not (flag? lookahead)))
	       (error "-f flag must be followed by only a single program!")
	       (exit))
	      ((and lookahead (flag? lookahead))
	       (parse (cdr args) (cons (list "prog" next) parsed)))
	      (else
	       (cons (list "prog" next) parsed))))))

(define (parse-libs args parsed)
  (if (null? args)
      parsed
      (let ((next (car args)))
	(cond ((flag? next)
	       (parse (cdr args) (cons (list "lib" next) parsed)))
	      (else
	       (parse-libs (cdr args) (cons (list "lib" next) parsed)))))))

(define (parse args parsed)
  (if (null? args)
      parsed
      (let ((next (car args)))
	(cond ((and (flag? next)
		    (eq? (string-length next) 2)
		    (eq? (string-ref next 1) #\l))
	       (parse-libs (cdr args) parsed))
	      ((and (flag? next)
		    (eq? (string-length next) 2)
		    (eq? (string-ref next 1) #\f))
	       (parse-prog (cdr args) parsed))
	      ((not (flag? next))
	       (parse-prog args parsed))
	      (else
	       (error "Invalid option")
	       (exit))))))

;; Convert parsed list into string
(define (get-libs args)
  (let kernel ((args args)
	       (libs '()))
    (if (null? args)
	libs
	(let ((next (car args)))
	  (if (string=? (car next) "lib")
	      (kernel (cdr args) (cons (string-append " -l" (cadr next)) libs))
	      (kernel (cdr args) libs))))))

;; Script
(let ((args (get-args)))
  (if (null? args)
      (usage)
      (let* ((parsed (parse args '()))
	     (prog (assoc "prog" parsed))
	     (libs (get-libs parsed)))
	(if (not prog)
	    (error "Please specify a program!")
	    (begin
	      (system (string-append "cyclone -d " (cadr prog) ">cmds"))
	      (call-with-input-file "cmds"
		(lambda (f)
		  (let* ((cmd-1 (read-line f))
			 (cmd-2 (read-line f)))
		    (system cmd-1)
		    (system (apply string-append (cons cmd-2 libs))))))
	      (system "rm cmds")
	      (exit))))))
