;;; molpro-mode.el 

;; Version 2.0pre1
;; $Date: 2002/04/27 01:59:08 $
;; $Revision: 1.5 $

;; This is a major mode supporting the editing of molpro input files.
;; 
;; It does font-locking, provides a menu to interactively run molpro, defines
;; some useful abbreviations, and also helps with the formatting.

;; Changes:
;; * April 2002, Jochen K\x{FFFD}pper:
;;   - Implemented font-locking.
;;   - Bind '\t' to indent-relative-maybe
;;   - Define more abbreviations.

(require 'font-lock)

(defvar molpro-mode-syntax-table nil
  "Syntax table used while in Molpro mode.")

(defvar molpro-mode-abbrev-table nil
  "Abbrev table used while in Molpro mode.")
(define-abbrev-table 'molpro-mode-abbrev-table ())
(define-abbrev molpro-mode-abbrev-table  ";b"  "basis" nil)
(define-abbrev molpro-mode-abbrev-table  ";d"  "dummy" nil)
(define-abbrev molpro-mode-abbrev-table  ";fi" "file" nil)
(define-abbrev molpro-mode-abbrev-table  ";fr" "frequencies" nil)
(define-abbrev molpro-mode-abbrev-table  ";g"  "geometry={}" nil)
(define-abbrev molpro-mode-abbrev-table  ";o"  "opt" nil)
(define-abbrev molpro-mode-abbrev-table  ";s"  "show," nil)
(define-abbrev molpro-mode-abbrev-table  ";t"  "text," nil)

(if molpro-mode-syntax-table
    ()
  (setq molpro-mode-syntax-table (make-syntax-table))
  (modify-syntax-entry ?\' "\""  molpro-mode-syntax-table)
  (modify-syntax-entry ?\! "<"  molpro-mode-syntax-table)
  (modify-syntax-entry ?\n ">" molpro-mode-syntax-table))

(defvar molpro-mode-map nil
  "Keymap for Molpro mode.")

(defvar molpro-mode-make-map nil
  "Keymap for Molpro-develop mode.")

(if molpro-mode-map
    ()
  (setq molpro-mode-map (make-sparse-keymap))
  (if (string-match "XEmacs" emacs-version)
      (set-keymap-name molpro-mode-map 'molpro-mode-map))
  (define-key molpro-mode-map ";" 'molpro-abbrev-start)
  (define-key molpro-mode-map "\t" 'indent-relative-maybe)
  (define-key molpro-mode-map "\C-c\C-c" 'molpro-run)
  (define-key molpro-mode-map "\C-c\C-b" 'molpro-run-background)
  (define-key molpro-mode-map "\C-c\C-q" 'molpro-run-batch)
  (define-key molpro-mode-map "\C-c\C-k" 'molpro-kill-for-buffer)
  (define-key molpro-mode-map "\C-c\C-l" 'molpro-show-output-buffer)
  (define-key molpro-mode-map "\C-c\C-r" 'molpro-mode-reload)
  )

(if molpro-mode-make-map
    ()
  (setq molpro-mode-make-map (make-sparse-keymap))
  (if (string-match "XEmacs" emacs-version)
      (set-keymap-name molpro-mode-make-map 'molpro-mode-make-map))
  (define-key molpro-mode-make-map ";" 'molpro-abbrev-start)
  (define-key molpro-mode-make-map "\t" 'indent-relative-maybe)
  (define-key molpro-mode-make-map "\C-c\C-c" 'molpro-make-run)
  (define-key molpro-mode-make-map "\C-c\C-b" 'molpro-make-run-background)
  (define-key molpro-mode-make-map "\C-c\C-q" 'molpro-make-run-batch)
  (define-key molpro-mode-make-map "\C-c\C-k" 'molpro-kill-for-buffer)
  (define-key molpro-mode-make-map "\C-c\C-l" 'molpro-show-output-buffer)
  (define-key molpro-mode-make-map "\C-c\C-r" 'molpro-mode-reload)
  )

(defvar molpro-font-lock-keywords
  (let ((keyword (mapconcat 'identity
                            '("\\*\\*\\*" 
                              "---"
                              "active" "inactive"
                              "angstrom" "degree"
                              "average" "isotope"
                              "do" "enddo" "if"
                              "file" "occ" 
			      "closed" "pspace" 
			      "state" "weight"
                              "mass" "molden" 
			      "endif" "proc" 
			      "endproc" "data" 
			      "save" "noorient" 
			      "nosymm" "else" 
			      "elsif" "then"
 			      "orbital" "ciguess"
                              ) "\\|"))
        ;; basis sets
        (basis (mapconcat 'identity
                          '("cc-pVDZ" "cc-pVTZ" "cc-pVQZ" "6-31g" 
			    "6-31g*" "6-31g**" "6-31g+" "6-31g++"
                            "aug-cc-pVDZ" "aug-cc-pVTZ" "aug-cc-pVQZ"
                            ) "\\|"))
        ;; calculation methods
        (method (mapconcat 'identity
                           '("HF" "RHF" "UHF"
                             "MP2" "MP4"
                             "CCSD" "RCCSD" "CCSD(T)" "RCCSD(T)" "MULTI"
			     "hf" "rhf" "uhf" "diab"
                             "mp2" "mp4" "multi" "cpmcscf" "nacm" "samc"
                             "ccsd" "RCCSD" "CCSD(T)" "RCCSD(T)" "MULTI"
                             ) "\\|"))
        ;; functions
        (function (mapconcat 'identity
                             '("add" "dummy" "energy"
                               "frequencies" 
                               "forces" 
                               "opt" "optg"
				"print" "put" 
			      "show" "text"
                               ) "\\|"))
        ;; variables
        (variable (mapconcat 'identity
                             '("angles" "energy" "gradient"
                               "basis" "geometry" 
                               "gprint" "gthresh"
                               "optconv"
                               "optstep" "optenergy" "optgrad"
                               "spin"
                               ) "\\|"))
	)
    (list
     ;; basis sets (types)
     (cons (concat "=[ \t]*\\(" basis "\\)") '(1 font-lock-type-face))
     ;; functions (functions)
     (cons (concat "\\(" function "\\)[ ,\n\t]") '(1 font-lock-function-name-face))
     ;; methods (variables)
     (cons (concat "\\(" method "\\)[ \n\t]") '(1 font-lock-variable-name-face))
     ;; variables (variables)
     (cons (concat "\\(" variable "\\)[=,\. \n\t]") '(1 font-lock-variable-name-face))
     ;; keywords (keywords)
     (cons (concat "\\b\\(" keyword "\\)[,;\= \n\t([]") 1)
     ;; options
     (cons (concat "\\bshow\\(\\[.*\\]\\)") 1)
     '("\\([tT][eE][xX][tT],\\|\\*\\*\\*,\\) \\(.*\\)" 2 font-lock-comment-face t)
     ;; comments (yes, besides the default.  We want to override everything else in them:)
     '("\\(!.*\\)" 1  font-lock-comment-face t)
     ))
  "Keywords and expressions to highlight in Molpro mode.")
(put 'molpro-mode 'font-lock-defaults '((molpro-font-lock-keywords) t t))


(setq molpro-processname "Molpro")

(defun molpro-mode-reload ()
  (interactive)
  (defvar molpro-mode-map nil)
  (defvar molpro-mode-make-map nil)
  (defvar molpro-font-lock-keyword nil)
  (load-library "molpro")
  (molpro-mode)
)

(defun molpro-check-saved ()
  (setq require-final-line t)
  (save-buffer)
)

(defun molpro-run-background ()
  (interactive)
  (molpro-check-saved)
  (let ((procname (concat "*Running " (buffer-name))))
    (if (molpro-kill procname)
	(message "Job aborted")
      (if (setq molpro-running (start-process procname procname "molpro" (buffer-name)))
	  (progn
	    (message "Molpro job started; use C-cC-l to see output")
	    (set-process-sentinel molpro-running 'molpro-running-sentinel)
	    )
  (message "Error in spawning Molpro job")))))

;;(setq molpro-nqs-queue "long")
(defvar molpro-nqs-queue nil "NQS queue for Molpro jobs")
(defun molpro-run-nqs ()
  (interactive)
  (molpro-check-saved)
  (if molpro-nqs-queue ()
    (setq molpro-nqs-queue (read-from-minibuffer "NQS queue: ")))
  (let ((proc (start-process "Nqs" "*Nqs log" "qsub" "-eo" "-q" molpro-nqs-queue "-r" (buffer-name))))
    (if proc
      (progn
	(process-send-string proc (concat "cd " (default-directory) "\n"))
	(process-send-string proc (concat "molpro " (buffer-name) "\n"))
	(process-send-eof proc)
	)
      (message "Error in submitting batch job"))))

(defun molpro-run-batch ()
  (interactive)
  (molpro-check-saved)
  (if molpro-batch-script ()
    (setq molpro-batch-script (read-from-minibuffer "Batch command: ")))
  (let ((proc (start-process "Batch" "*Batch log" molpro-batch-script "-eo" "-q" molpro-nqs-queue "-r" (buffer-name))))
    (if proc
      (progn
	(process-send-string proc (concat "cd " (default-directory) "\n"))
	(process-send-string proc (concat "molpro " (buffer-name) "\n"))
	(process-send-eof proc)
	)
      (message "Error in submitting batch job"))))

(defun molpro-run ()
  "Run molpro"
  (interactive)
  (let ((molpro-output-buffer (concat "*Molpro output from " (buffer-name)))
	(molpro-input-buffer (buffer-name)))
    (if (molpro-kill)
	(message "Job aborted")
      (if (get-buffer molpro-output-buffer)
	  (save-excursion
	    (set-buffer molpro-output-buffer)
	    (setq buffer-read-only nil)
	    (erase-buffer)
	    )
	)
      (setq proc (start-process molpro-processname molpro-output-buffer "molpro"))
      
      (set-buffer molpro-input-buffer)
      (setq molpro-running proc)
      (set-process-sentinel proc 'molpro-running-sentinel)
      (process-send-string proc (buffer-substring (point-min) (point-max)))
      (process-send-eof proc)
      (molpro-show-output-buffer)
      )
    )
  )

(defun molpro-running-sentinel (proc msg)
;;  (princ
;;   (format "Process: %s had the event %s" proc msg ))
;;  (princ
;;   (format "Process: %s has status %s and exit status %s" proc (process-status proc) (process-exit-status proc)))

  ;;(message (concat "sentinel: " "status:" (symbol-name (process-status proc)) ":"  (process-exit-status proc)))
  (if (equal (symbol-name (process-status proc)) "exit")
      (progn
	(setq molpro-running nil)
	(if (equal (process-exit-status proc) 0)
	    (message "Molpro run finished")
	  (princ (format "Error in Molpro run, rc=%d\n" (process-exit-status proc)))))
    (message "Warning: unexpected entry to Molpro sentinel routine")
      )
)

(defun molpro-kill-for-buffer ()
  "Kill any running Molpro process for the current buffer."
  (interactive)
  (molpro-kill)
  (molpro-kill (concat "*Running " (buffer-name)))
)

(defun molpro-kill (&optional procname)
  "Kill current molpro process. Returns nil if process gone, t otherwise"
  (if procname () (setq procname molpro-processname))
  (if (get-process procname)
      (progn
	(let
	    ((killit (read-from-minibuffer "Do you want to kill active process? " )))
	  (if (equal (downcase (substring killit 0 1)) "y") 
	      (progn
		(delete-process procname)
		(message (concat "Killed process " procname))) t)))
    nil))

(defun molpro-output-file-name (input)
  (if (string-match "\\..*$" input)
      (replace-match ".out" t t input)
    (concat input ".out")))

(defun molpro-show-output-buffer ()
  "Show Molpro output buffer"
  (interactive)
  ;;(delete-other-windows)
  (catch 'nooutput
    (progn
      ;; open the output file in view mode
      (setq molpro-output-buffer (concat "*Molpro output from " (buffer-name)))
      (let ((ob (get-buffer molpro-output-buffer)) (of (molpro-output-file-name (buffer-name))))
	(cond
	 ((buffer-live-p ob) (view-buffer ob))
	 ((file-exists-p of) (view-file of))
	 (t (progn (message "no output buffer or file") (throw 'nooutput nil))))
	)
  (if (string-match "XEmacs" emacs-version)
      (set-extent-property (make-extent (point-max) (point-min)) 'face 'molpro-output-face))
  (setq truncate-lines t)
  (if viper-current-state (viper-change-state-to-emacs))
  (setq mode-name "Molpro-output")
  ))
  )

(setq compile-command "make")
(defun molpro-make ()
  "Run make in the current directory"
  (interactive)
  (setq compilation-finish-function nil)
    (compile compile-command))

(defun molpro-make-run ()
  "Run make in the current directory, and run Molpro on the current buffer if successful"
  (interactive)
  (molpro-make-and-run 'molpro-run)
)

(defun molpro-make-run-background ()
  "Run make in the current directory, and run Molpro on the current buffer's file if successful"
  (interactive)
  (molpro-make-and-run 'molpro-run-background)
)

(defun molpro-make-run-batch ()
  "Run make in the current directory, and batch submit Molpro on the current buffer's file if successful"
  (interactive)
  (molpro-make-and-run 'molpro-run-batch)
)

(defun molpro-make-and-run (runner)
  (setq molpro-input (buffer-name))
  (setq molpro-runner runner)
  (setq compilation-finish-function 
	'(lambda (buf msg)
	   (if (equal (substring msg 0 8) "finished")
	       (progn
		 (set-buffer molpro-input)
		 (compilation-minor-mode 0)
		 (delete-other-windows)
		 (funcall molpro-runner)))))
  (compile compile-command))

(defun molpro-mode ()
  "Major mode for editing Molpro input
Special commands:
\\{molpro-mode-map}
Turning on Molpro mode calls the value of the variable `molpro-mode-hook',
if that value is non-nil.

Type ;? or ;\\[help-command] to display a list of built-in\
 abbrevs for Molpro keywords.
"
  (interactive)
  (kill-all-local-variables)
  (make-local-variable 'comment-start)
  (make-local-variable 'comment-end)
  (make-local-variable 'font-lock-defaults)
  (if (file-exists-p "base/develop/Makefile")
      (use-local-map molpro-mode-make-map)
    (use-local-map molpro-mode-map))
  (setq comment-start "!"
        comment-end ""
        mode-name "Molpro"
        major-mode 'molpro-mode
        local-abbrev-table molpro-mode-abbrev-table
	font-lock-defaults '(molpro-font-lock-keywords))
  (set-syntax-table molpro-mode-syntax-table)

  (defvar molpro-running nil
    "List of Molpro processes now running.")
  (or (assq 'molpro-running minor-mode-alist)
      (setq minor-mode-alist (cons '(molpro-running " Molpro-run")
                                   minor-mode-alist)))
  
  (make-face 'molpro-input-face)
  (copy-face 'default 'molpro-input-face)
  ;; (set-face-background 'molpro-input-face "limegreen")
  
  (make-face 'molpro-output-face)
  (copy-face 'molpro-input-face 'molpro-output-face)
  ;; (set-face-background 'molpro-output-face "pink")
  (if (string-match "XEmacs" emacs-version)
      (progn
        (make-face-smaller 'molpro-output-face)
        (set-extent-property (make-extent (point-max) (point-min)) 'face 'molpro-input-face)
        ;; menus
        (set-buffer-menubar (copy-sequence current-menubar))
        (if (file-exists-p "base/develop/Makefile")
	    (add-submenu nil molpro-xemacs-develop-menu)
	  (add-submenu nil molpro-xemacs-menu))))
  
  (run-hooks 'molpro-mode-hook))

;; menus

(if (string-match "XEmacs" emacs-version)
    (progn 
      (defvar molpro-xemacs-menu
	'("Molpro"
	  ["Run interactive"       molpro-run t]
	  ["Run background"       molpro-run-background t]
	  ["Run batch"       molpro-run-batch t]
	  ["Display output"       molpro-show-output-buffer t]
	  ["Kill"       molpro-kill-for-buffer t]
	  "-----"
	  ["Reload mode"      molpro-mode-reload t])
	"XEmacs menu for Molpro mode.")
      (defvar molpro-xemacs-develop-menu
	'("Molpro"
	  ["Run interactive"       molpro-run t]
	  ["Run background"       molpro-run-background t]
	  ["Run batch"       molpro-run-batch t]
	  ["Display output"       molpro-show-output-buffer t]
	  ["Kill"       molpro-kill-for-buffer t]
	  "-----"
	  ["Make"       molpro-make t]
	  ["Make & run interactive"       molpro-make-run t]
	  ["Make & run background"       molpro-make-run-background t]
	  ["Make & run batch"       molpro-make-run-batch t]
	  "-----"
	  ["Reload mode"      molpro-mode-reload t])
	"XEmacs menu for Molpro mode.")))

(defun molpro-abbrev-start ()
  "Typing ;\\[help-command] or ;? lists all the Fortran abbrevs. 
Any other key combination is executed normally."
  (interactive)
  ;; XEmacs change
  (let (e c)
    (insert last-command-char)
    (setq e (next-command-event)
	  c (event-to-character e))
    ;; insert char if not equal to `?'
    (if (or (= c ??) (eq c help-char))
	(molpro-abbrev-help)
      (setq unread-command-events (list e)))))

(defun molpro-abbrev-help ()
  "List the currently defined abbrevs in Fortran mode."
  (interactive)
  (message "Listing abbrev table...")
  (display-buffer (molpro-prepare-abbrev-list-buffer))
  (message "Listing abbrev table...done"))

(defun molpro-prepare-abbrev-list-buffer ()
  (save-excursion
    (set-buffer (get-buffer-create "*Abbrevs*"))
    (erase-buffer)
    (insert-abbrev-table-description 'molpro-mode-abbrev-table t)
    (goto-char (point-min))
    (set-buffer-modified-p nil)
    (edit-abbrevs-mode))
  (get-buffer-create "*Abbrevs*"))

(provide 'molpro)

;;; molpro-mode.el ends here

;; Local Variables:
;; fill-column: 79
;; End: