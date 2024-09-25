(define (problem hanoi1)
    (:domain hanoi)
    (:objects
        peg1
        peg2
        peg3
        green_disk
        blue_disk
        red_disk
    )
    (:init
        (clear green_disk)
        (clear peg2)
        (clear peg3)
        (on green_disk blue_disk)
        (on blue_disk red_disk)
        (on red_disk peg1)
        (smaller green_disk blue_disk)
        (smaller green_disk red_disk)
        (smaller blue_disk red_disk)
        (smaller green_disk peg1)
        (smaller green_disk peg2)
        (smaller green_disk peg3)
        (smaller blue_disk peg1)
        (smaller blue_disk peg2)
        (smaller blue_disk peg3)
        (smaller red_disk peg1)
        (smaller red_disk peg2)
        (smaller red_disk peg3)
    )
    (:goal (and 
        (on red_disk peg3) 
        (on blue_disk red_disk) 
        (on green_disk blue_disk)
    ))
)