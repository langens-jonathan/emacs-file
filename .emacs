(package-initialize) 

(setq inhibit-startup-message t)

(require 'package)
(add-to-list 'package-archives
            '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
	     '("marmalade". "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
	     '("gnu" . "http://elpa.gnu.org/packages/") t)
(package-initialize)

(defun my-enable-minor-modes (&optional programming)
   "Enables the following minor modes."
   (interactive "")
   (scroll-bar-mode 0)
   (tool-bar-mode 0)
;   (flyspell-mode (not programming))
   (visual-line-mode t)
   (column-number-mode t)
   (linum-mode t))

(defun my-enable-minor-prog-modes ()
  "enables minor modes for programming"
  (my-enable-minor-modes 1))

(add-hook 'prog-mode-hook 'my-enable-minor-prog-modes)
(add-hook 'org-mode-hook 'my-enable-minor-modes)
(add-hook 'text-mode-hook 'my-enable-minor-modes)
(add-hook 'xml-mode 'my-enable-minor-modes)
(add-hook 'ttl-mode 'my-enable-minor-modes)
(add-hook 'sparql-mode 'my-enable-minor-modes)

;; fancy buffer switching
;; ido-mode
(require 'ido)
(ido-mode 1)
(ido-everywhere 1)
(setq ido-enable-flex-matching t)
(add-hook 'ido-setup-hook 
          (lambda () 
            (define-key ido-completion-map [tab] 'ido-complete)))

(add-hook 'ido-setup-hook 
    (lambda () 
      (define-key ido-completion-map "\r" 'ido-exit-minibuffer)))

(defun ido-smart-select-text ()
    "Select the current completed item.  Do NOT descend into directories."
    (interactive)
    (when (and (or (not ido-require-match)
                   (if (memq ido-require-match
                             '(confirm confirm-after-completion))
                       (if (or (eq ido-cur-item 'dir)
                               (eq last-command this-command))
                           t
                         (setq ido-show-confirm-message t)
                         nil))
                   (ido-existing-item-p))
               (not ido-incomplete-regexp))
      (when ido-current-directory
        (setq ido-exit 'takeprompt)
        (unless (and ido-text (= 0 (length ido-text)))
          (let ((match (ido-name (car ido-matches))))
            (throw 'ido
                   (setq ido-selected
                         (if match
                             (replace-regexp-in-string "/\\'" "" match)
                           ido-text)
                         ido-text ido-selected
                         ido-final-text ido-text)))))
      (exit-minibuffer)))
  
  (eval-after-load "ido"
    '(define-key ido-common-completion-map "\C-m" 'ido-smart-select-text))

;; Goto-line short-cut key                                                                                                   
(global-set-key (kbd "C-c l") 'goto-line)

;; (require 'web-mode)
;; (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.[gj]sp\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.hbs\\'" . web-mode))


;; (set-face-attribute 'web-mode-html-tag-face nil :foreground "steel blue")
;; (set-face-attribute 'web-mode-html-attr-name-face nil :foreground "light blue")

(defun hide-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "red3" "ForestGreen" "yellow3" "blue" "magenta3" "DeepSkyBlue" "gray50"])
 '(coffee-tab-width 2)
 '(custom-enabled-themes (quote (darktooth)))
 '(custom-safe-themes
   (quote
    ("66132890ee1f884b4f8e901f0c61c5ed078809626a547dbefbb201f900d03fd8" "868f73b5cf78e72ca2402e1d48675e49cc9a9619c5544af7bf216515d22b58e7" "c2afb2893fe111469c07f846c6d1d67e8f5bcce612cb90e874ecb52d94833a4a" "a25c42c5e2a6a7a3b0331cad124c83406a71bc7e099b60c31dc28a1ff84e8c04" "ac2b1fed9c0f0190045359327e963ddad250e131fbf332e80d371b2e1dbc1dc4" "7b4d9b8a6ada8e24ac9eecd057093b0572d7008dbd912328231d0cada776065a" "19ba41b6dc0b5dd34e1b8628ad7ae47deb19f968fe8c31853d64ea8c4df252b8" "be4025b1954e4ac2a6d584ccfa7141334ddd78423399447b96b6fa582f206194" "f64c9f8b4241b680b186f4620afb9c82fa2a76cf4498a7431f90db59bb1892eb" "fe1682ca8f7a255cf295e76b0361438a21bb657d8846a05d9904872aa2fb86f2" "246a51f19b632c27d7071877ea99805d4f8131b0ff7acb8a607d4fd1c101e163" "d09467d742f713443c7699a546c0300db1a75fed347e09e3f178ab2f3aa2c617" "98a619757483dc6614c266107ab6b19d315f93267e535ec89b7af3d62fb83cad" "357d5abe6f693f2875bb3113f5c031b7031f21717e8078f90d9d9bc3a14bcbd8" "40664277ccd962bc373bff67affb4efa7c9bf3dabd81787e6e08fe080ba9645f" default)))
 '(ember-keymap-prefix "c")
 '(fci-rule-color "#3f1a1a")
 '(fringe-mode 6 nil (fringe))
 '(linum-format " %7d ")
 '(main-line-color1 "#191919")
 '(main-line-color2 "#111111")
 '(pos-tip-background-color "#36473A")
 '(pos-tip-foreground-color "#FFFFC8")
 '(powerline-color1 "#191919")
 '(powerline-color2 "#111111"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; ido-mode
(require 'ido)
(ido-mode 1)
(ido-everywhere 1)
(setq ido-enable-flex-matching t)

;; smex
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; ember-mode
;(add-to-list  'auto-mode-alist '("\\.coffee\\'" . ember-mode))
;(add-to-list  'auto-mode-alist '("\\.coffee\\'" . coffee-mode))

(global-set-key (kbd "C-c s") 'magit-status)

;; maximize emacs on startup
(add-to-list 'default-frame-alist '(fullscreen . maximized))
