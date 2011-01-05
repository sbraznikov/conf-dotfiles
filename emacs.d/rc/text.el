(setq tab-stop-list '(8 12 16 20 24 28 32 36 40 44 48 52 56 60
						64 68 72 76 80 84 88 92 96 100 104 108 112
						116 120))

(defun my-text-mode-settings ()
  (auto-fill-mode t))

(add-hook 'text-mode-hook 'my-text-mode-settings)