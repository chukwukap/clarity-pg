;; title: p
;; version:
;; summary:
;; description:

;; traits
;;

;; token definitions
;;

;; constants
;;

;; data vars
;;

;; data maps
;;

;; public functions
;;

;; read only functions
;;

;; * private functions
;;

;; ? what is going on here?
;; ! Remove this code from here
;; todo mark this line as completed. thanks.


(define-map deposits principal uint)

(define-read-only (get-total-deposit (who principal))
	(default-to u0 (map-get? deposits who))
)

(define-public (deposit (amount uint))
	(begin
		try!((stx-transfer? amount tx-sender (as-contract tx-sender)))
		(map-set deposits tx-sender (+ (get-total-deposit tx-sender) amount))
		(ok true)
	)
)

;; Try a test deposit
(print (deposit u500))