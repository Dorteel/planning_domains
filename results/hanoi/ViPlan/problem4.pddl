(define (problem hanoi1)
    (:domain hanoi)
    (:objects
        peg1
        peg2
        peg3
        orange_disk
        red_disk
        blue_disk
        pink_disk
    )
    (:init
        (clear pink_disk)
        (clear peg2)
        (clear peg3)
        (on pink_disk blue_disk)
        (on blue_disk red_disk)
        (on red_disk orange_disk)
        (on orange_disk peg1)
        (smaller pink_disk blue_disk)
        (smaller pink_disk red_disk)
        (smaller pink_disk orange_disk)
        (smaller blue_disk red_disk)
        (smaller blue_disk orange_disk)
        (smaller red_disk orange_disk)
        (smaller pink_disk peg1)
        (smaller pink_disk peg2)
        (smaller pink_disk peg3)
        (smaller blue_disk peg1)
        (smaller blue_disk peg2)
        (smaller blue_disk peg3)
        (smaller red_disk peg1)
        (smaller red_disk peg2)
        (smaller red_disk peg3)
        (smaller orange_disk peg1)
        (smaller orange_disk peg2)
        (smaller orange_disk peg3)
    )
    (:goal (and 
        (on orange_disk peg3) 
        (on red_disk orange_disk) 
        (on blue_disk red_disk) 
        (on pink_disk blue_disk)
    ))
)