(require 'jabber)

(setq jabber-roster-show-bindings nil)
(setq jabber-roster-show-title nil)
(setq jabber-show-offline-contacts nil)
(setq jabber-avatar-verbose t)
(setq jabber-history-enabled t)
(setq jabber-auto-reconnect t)
(setq jabber-groupchat-buffer-format "*-jg-%n-*")
(setq jabber-roster-buffer "*-jroster-*")
(setq jabber-roster-line-format " %c %-25n %u %-8s  %S")
(setq jabber-chat-buffer-format "*-jc-%n-*")
(setq jabber-muc-private-buffer-format "*-jmuc-priv-%g-%n-*")
(setq jabber-rare-time-format "%e %b %Y %H:00")
(setq jabber-chat-buffer-show-avatar nil)
(setq jabber-vcard-avatars-retrieve nil)
(setq jabber-vcard-avatars-publish nil)
(setq jabber-nickname "sbraznikov")
(setq fsm-debug nil)

(add-hook 'jabber-chat-mode-hook 'goto-address)

(define-jabber-alert echo "Show a message in the echo area"
  (lambda (msg)
    (unless (minibuffer-prompt)
      (message "%s" msg))))

(defun ja()
  (interactive)
  (jabber-connect-all)
  (jabber-switch-to-roster-buffer))

(defun jr()
  (interactive)
  (jabber-display-roster))

(defun ju()
  (interactive)
  (jabber-chat-with))

;; ;; Make jabber.el notify through growl when I get a new message
;; (setq jabber-message-alert-same-buffer nil)
;; (defun pg-jabber-growl-notify (from buf text proposed-alert)
;;   "(jabber.el hook) Notify of new Jabber chat messages via Growl"
;;   ;; (when (or jabber-message-alert-same-buffer
;;   ;;           (not (memq (selected-window) (get-buffer-window-list buf))))
;;     (if (jabber-muc-sender-p from)
;;         (growl (format "(PM) %s"
;;                        (jabber-jid-displayname (jabber-jid-user from)))
;;                (format "%s: %s" (jabber-jid-resource from) text)
;;                (format "jabber-from-%s" (jabber-jid-resource from)))
;;       (growl (format "%s" (jabber-jid-displayname from))
;;              text "jabber-from-unknown")))
;; (add-hook 'jabber-alert-message-hooks 'pg-jabber-growl-notify)

;; Same as above, for groupchats
(defun pg-jabber-muc-growl-notify (nick group buf text proposed-alert)
  "(jabber.el hook) Notify of new Jabber MUC messages via Growl"
  (when (or jabber-message-alert-same-buffer
            (not (memq (selected-window) (get-buffer-window-list buf))))
    (if nick
        (when (or jabber-muc-alert-self
                  (not (string=
                        nick (cdr (assoc group *jabber-active-groupchats*)))))
          (growl (format "%s" (jabber-jid-displayname group))
                 (format "%s: %s" nick text)
                 (format "jabber-chat-%s" (jabber-jid-displayname group))))
      (growl (format "%s" (jabber-jid-displayname group))
             text "jabber-chat-unknown"))))
(add-hook 'jabber-alert-muc-hooks 'pg-jabber-muc-growl-notify)
