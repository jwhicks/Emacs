        ;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	;; Initial setup
	;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	;;   LOGNAME and USER are expected in many Emacs packages
	;;   Check these environment variables.

;; Only use in tty-sessions
(if (not window-system)
     (progn
      (defvar arrow-keys-map (make-sparse-keymap) "Keymap for arrow keys")
      (define-key esc-map "[" arrow-keys-map)
      (define-key arrow-keys-map "A" 'previous-line)
      (define-key arrow-keys-map "B" 'next-line)
      (define-key arrow-keys-map "C" 'forward-char)
      (define-key arrow-keys-map "D" 'backward-char)))

(setq-default truncate-lines t)
(setq-default auto-save-default nil)
(setq-default auto-save-interval 2000)

(define-key global-map "\C-x8" 'kill-rectangle)
(define-key global-map "\C-x9" 'yank-rectangle)

(global-set-key "\C-x8" 'kill-rectangle)
(global-set-key "\C-x9" 'yank-rectangle)
(global-set-key "\M-q"  'query-replace-regexp)

;;setup line and column numbers
(line-number-mode 1)
(column-number-mode 1)

;;setup color scheme
(defconst color-scheme 'dark)
(defconst foreground-color "orange")
(defconst background-color "gray25")
(defconst cursor-color "red3")
(defconst pointer-color "white")

(if (featurep 'xemacs)
    (let ((frame (selected-frame)))
      (set-face-foreground 'default foreground-color)
      (set-face-background 'default background-color)
      (setq frame-background-mode color-scheme)
      color-scheme
      (set-frame-property frame
                          'custom-properties
                          (mapcar (lambda (symbol)
                                    (if (eql symbol 'light)
                                        'dark
                                      symbol))
                                  (frame-property frame
                                                  'custom-properties))))
  (progn 
     (add-to-list 'default-frame-alist '(foreground-color . "orange"))
     (add-to-list 'default-frame-alist '(background-color . "gray25"))
     (add-to-list 'default-frame-alist '(cursor-color . "red3"))
     (add-to-list 'default-frame-alist '(background-mode . dark))
     (set-cursor-color cursor-color)
     (set-mouse-color pointer-color))
)

;;setup font-lock-mode file size
(setq font-lock-maximum-size 2000000);

;; Setup time mode
(autoload 'display-time "time" "Display Time" 1)
(condition-case err
    (display-time)
  (error (message "Unable to load Time package.")))
(setq display-time-24hr-format nil)
(setq display-time-day-and-date 1)

;;setup custom variables
(custom-set-variables
 '(paren-mode (quote blink-paren) nil (paren))
 '(default-input-method "rfc1345")
 '(case-fold-search t)
 '(global-font-lock-mode 1 nil (font-lock))
 '(show-paren-mode t nil (paren))
 '(truncate-lines t)
 '(current-language-environment "UTF-8")
 '(transient-mark-mode t))
(custom-set-faces)

(setq minibuffer-max-depth nil)

(global-set-key [mouse-4] 'scroll-down)
(global-set-key [mouse-5] 'scroll-up)

;; JAVA Stuff Here
(setq auto-mode-alist (cons '("\.java$" . java-mode) auto-mode-alist))
(add-hook 'java-mode-hook 'turn-on-font-lock)
(add-hook 'java-mode-hook 'toggle-transient-mark-mode)

;; JAVA Stuff Here
(setq auto-mode-alist (cons '("\.jad$" . java-mode) auto-mode-alist))
(add-hook 'java-mode-hook 'turn-on-font-lock)
(add-hook 'java-mode-hook 'toggle-transient-mark-mode)

      ;; This removes unsightly ^M characters that would otherwise
      ;; appear in the output of java applications.
      (add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)

;; Python Stuff Here
(setq auto-mode-alist (cons '("\.py$" . python-mode) auto-mode-alist))
(add-hook 'python-mode-hook 'turn-on-font-lock)
(add-hook 'python-mode-hook 'toggle-transient-mark-mode)

;; Php Stuff Here
(setq auto-mode-alist (cons '("\.php$" . php-mode) auto-mode-alist))
(add-hook 'php-mode-hook 'turn-on-font-lock)
(add-hook 'php-mode-hook 'toggle-transient-mark-mode)

;; XML Stuff Here
(setq auto-mode-alist (cons '("\.xml$" . xml-mode) auto-mode-alist))
(add-hook 'xml-mode-hook 'turn-on-font-lock)
(add-hook 'xml-mode-hook 'toggle-transient-mark-mode)

;; C Stuff Here
(setq auto-mode-alist (cons '("\.c$" . c-mode) auto-mode-alist))
(add-hook 'c-mode-hook 'turn-on-font-lock)
(add-hook 'c-mode-hook 'toggle-transient-mark-mode)

;; C++ Stuff Here
(setq auto-mode-alist (cons '("\.cpp$" . c-mode) auto-mode-alist))
(add-hook 'c-mode-hook 'turn-on-font-lock)
(add-hook 'c-mode-hook 'toggle-transient-mark-mode)

;; C# Stuff Here
(setq auto-mode-alist (cons '("\.cs$" . c-mode) auto-mode-alist))
(add-hook 'c-mode-hook 'turn-on-font-lock)
(add-hook 'c-mode-hook 'toggle-transient-mark-mode)

;; CSS Stuff Here
(setq auto-mode-alist (cons '("\.css$" . css-mode) auto-mode-alist))
(add-hook 'css-mode-hook 'turn-on-font-lock)
(add-hook 'css-mode-hook 'toggle-transient-mark-mode)

;; Perl Stuff Here
(setq auto-mode-alist (cons '("\.pl$" . perl-mode) auto-mode-alist))
(add-hook 'perl-mode-hook 'turn-on-font-lock)
(add-hook 'perl-mode-hook 'toggle-transient-mark-mode)

;; Matlab Stuff Here
(setq auto-mode-alist (cons '("\.m$" . matlab-mode) auto-mode-alist))
(add-hook 'matlab-mode-hook 'turn-on-font-lock)
(add-hook 'matlab-mode-hook 'toggle-transient-mark-mode)

(defun my-compile ()
  "Use compile to run python programs"
  (interactive)
  (compile (concat "python " (buffer-name))))
(setq compilation-scroll-output t)

(global-set-key [f5] 'my-compile)

(setq make-backup-files 'nil)

(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(setq default-directory "/home/john/" )