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
		;; Transfer STX from sender to contract
		(try! (stx-transfer? amount tx-sender (as-contract tx-sender)))
		;; Update the map with the new balance
		(map-set deposits tx-sender (+ (get-total-deposit tx-sender) amount))
		(ok true)
	)
)

(define-public (withdraw (amount uint))
	(let
		(
			(current-balance (get-total-deposit tx-sender))
		)
		(asserts! (>= current-balance amount) (err u401)) ;; Ensure sufficient funds
		(try! (as-contract (stx-transfer? amount tx-sender tx-sender)))
		(map-set deposits tx-sender (- current-balance amount))
		(ok true)
	)
)

;; Try a test deposit
(print (deposit u500))
(print (withdraw u100))