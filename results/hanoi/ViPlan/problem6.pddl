(define (problem hanoi2)
    (:domain hanoi)
    (:objects
        peg1
        peg2
        peg3
        green_disk
        red_disk
    )
    (:init
        (clear green_disk)
        (clear red_disk)
        (clear peg3)
        (on green_disk peg1)
        (on red_disk peg2)
        (smaller green_disk peg1)
        (smaller red_disk peg1)
        (smaller green_disk peg2)
        (smaller red_disk peg2)
        (smaller green_disk peg3)
        (smaller red_disk peg3)
        (smaller green_disk red_disk)
    )
    (:goal (and (on green_disk red_disk) (on red_disk peg3)))
)