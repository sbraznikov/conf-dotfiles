(require 'twittering-mode)
(setq twittering-icon-mode nil)
(setq twittering-timer-interval 300)
(setq twittering-url-show-status nil)
(add-hook 'twittering-edit-mode-hook (lambda () (ispell-minor-mode) (flyspell-mode)))

(eval-after-load "twittering-mode"
  '(progn
     (twittering-icon-mode)))

