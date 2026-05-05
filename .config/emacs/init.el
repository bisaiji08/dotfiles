;;; init.el --- Refactored Configuration

(eval-and-compile
  (when (or load-file-name byte-compile-current-file)
    (setq user-emacs-directory
          (expand-file-name
           (file-name-directory (or load-file-name byte-compile-current-file))))))

;;; --- Package Manager (leaf) ---
(eval-and-compile
  (customize-set-variable
   'package-archives '(("gnu"   . "https://elpa.gnu.org/packages/")
                       ("melpa" . "https://melpa.org/packages/")
                       ("org"   . "https://orgmode.org/elpa/")))
  (package-initialize)
  (unless (package-installed-p 'leaf)
    (package-refresh-contents)
    (package-install 'leaf))

  (leaf leaf-keywords
    :ensure t
    :init
    (leaf hydra :ensure t)
    (leaf blackout :ensure t)
    :config
    (leaf-keywords-init)))

(leaf leaf
  :config
  (leaf leaf-convert :ensure t)
  (leaf leaf-tree
    :ensure t
    :custom ((imenu-list-size . 30)
             (imenu-list-position . 'left))))

;;; --- Built-in Settings ---
(leaf cus-edit
  :doc "tools for customizing Emacs"
  :custom `((custom-file . ,(locate-user-emacs-file "custom.el"))))

(leaf *startup
  :config
  (setq inhibit-startup-screen nil)        ; Welcome画面を非表示
  (setq initial-scratch-message nil))    ; scratchバッファを空に

(leaf select
  :tag "builtin"
  :custom ((select-enable-clipboard . t)
           (select-enable-primary . t)
           (save-interprogram-paste-before-kill . t)
           (mouse-drag-copy-region . t)))

(leaf display-line-numbers
  :tag "builtin"
  :global-minor-mode global-display-line-numbers-mode)

(leaf paren
  :tag "builtin"
  :global-minor-mode show-paren-mode)

;;; --- Evil & Undo (Vim-mode) ---
(leaf undo-fu :ensure t)

(leaf evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-vimpulse-expand-on-vi-commands t)
  ;; undo-fuをここで指定 (Redoエラー対策)
  (setq evil-undo-system 'undo-fu)
  :config
  (evil-mode 1)
  ;; 起動時のバッファを強制的にNormalモードへ
  (with-current-buffer (window-buffer)
    (evil-normal-state)))

(leaf evil-collection
  :ensure t
  :after evil
  :config
  (evil-collection-init))

(leaf *evil-escape
  :after evil
  :config
  (define-key evil-normal-state-map [escape] 'keyboard-quit)
  (define-key evil-visual-state-map [escape] 'keyboard-quit)
  (define-key minibuffer-local-map [escape] 'abort-recursive-edit)
  (define-key global-map [escape] 'keyboard-quit))

(leaf evil-leader
  :ensure t
  :after evil
  :global-minor-mode global-evil-leader-mode
  :config
  (evil-leader/set-leader "C-q")
  (evil-leader/set-key
    "f" 'find-file
    "b" 'switch-to-buffer
    "k" 'kill-buffer
    "t" 'vterm
    "g" 'magit
    "a" 'org-agenda    ; 予定・タスク一覧
    "c" 'org-capture)) ; クイックメモ

;;; --- Appearance (WezTerm-like) ---
(leaf frame
  :tag "builtin"
  :config
  (defun my/apply-frame-transparency (frame)
    (set-frame-parameter frame 'alpha '(85 . 85)) ; 全体透過
    (set-frame-parameter frame 'ns-appearance 'dark)
    (set-frame-parameter frame 'ns-transparent-titlebar t))

  (my/apply-frame-transparency nil)
  (add-to-list 'after-make-frame-functions 'my/apply-frame-transparency)
  (add-to-list 'default-frame-alist '(alpha . (85 . 85)))
  (add-to-list 'default-frame-alist '(ns-appearance . dark))
  (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t)))

(leaf *flat-ui
  :config
  ;; タイトルバーを非表示にするが、透明な帯を残してドラッグ可能に
  (add-to-list 'default-frame-alist '(undecorated . nil))
  (setq frame-title-format "")
  (when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
  (when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
  (when (fboundp 'menu-bar-mode) (menu-bar-mode -1)))

(leaf doom-themes
  :ensure t
  :config
  (load-theme 'doom-oceanic-next t)
  (doom-themes-neotree-config)
  (doom-themes-org-config))

(leaf centaur-tabs
  :ensure t
  :blackout t
  :config
  (centaur-tabs-mode 1)
  :custom
  ((centaur-tabs-style . "bar")
   (centaur-tabs-height . 32)
   (centaur-tabs-set-icons . t)
   (centaur-tabs-set-modified-marker . t)
   (centaur-tabs-hide-hash . t))
  :bind
  (:evil-normal-state-map
   ("g t" . centaur-tabs-forward)
   ("g T" . centaur-tabs-backward)))

(leaf macrostep
  :ensure t
  :bind (("C-c e" . macrostep-expand)))

(leaf *font-setting
  :config
  (defun my/set-font ()
    ;; 優先順位順にフォントをリストアップ
    (let* ((font-list '("JetBrainsMono Nerd Font" 
                        "Hack Nerd Font" 
                        "CaskaydiaCove Nerd Font" 
                        "Menlo"
                        "Consolas"   ; Windows用
                        "Monospace")) ; Linux汎用
           (usable-font (cl-find-if (lambda (f) (member f (font-family-list))) font-list)))
      (when usable-font
        ;; 高さ (height) は適宜調整してください
        (set-face-attribute 'default nil :family usable-font :height 120))))
  
  ;; 起動時と新しくフレーム（ウィンドウ）を作った時に適用
  (my/set-font)
  (add-to-list 'after-make-frame-functions (lambda (f) (with-selected-frame f (my/set-font)))))

(leaf vterm
  :ensure t
  :config
  (setq vterm-shell (executable-find "zsh"))
  
  (add-hook 'vterm-mode-hook
            (lambda ()
              (evil-emacs-state)
              (display-line-numbers-mode -1))))

(leaf magit
  :ensure t
  :after evil-leader)

(leaf org
  :doc "Org-mode: The heart of Emacs OS"
  :tag "builtin"
  :bind
  ;; グローバルなショートカット（どのバッファからでも呼び出せるように）
  (:global-map
   ("C-c l" . org-store-link)
   ("C-c a" . org-agenda)
   ("C-c c" . org-capture))
  :config
  ;; メモファイルの置き場所（~/org ディレクトリを作成しておいてください）
  (setq org-directory "~/org")
  (setq org-default-notes-file (concat org-directory "/notes.org"))
  
  ;; 見た目をモダンにする設定
  (setq org-startup-indented t)           ; 階層ごとにインデント
  (setq org-hide-leading-stars t)         ; 見出しの余計な * を隠す
  (setq org-src-fontify-natively t)       ; コードブロック内をハイライト
  
  ;; 状態（TODOキーワード）の定義
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "WAIT(w)" "|" "DONE(d)" "CANCEL(c)"))))

(provide 'init)
