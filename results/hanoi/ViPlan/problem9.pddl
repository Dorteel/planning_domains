(define (problem hanoi1)
    (:domain hanoi)
    (:objects
        peg1
        peg2
        peg3
        disk1  ; largest
        disk2
        disk3
        disk4
        disk5
        disk6
        disk7
        disk8
        disk9  ; smallest
    )
    (:init
        (clear disk9)
        (clear peg2)
        (clear peg3)
        (on disk9 disk8)
        (on disk8 disk7)
        (on disk7 disk6)
        (on disk6 disk5)
        (on disk5 disk4)
        (on disk4 disk3)
        (on disk3 disk2)
        (on disk2 disk1)
        (on disk1 peg1)
        (smaller disk9 disk8)
        (smaller disk9 disk7)
        (smaller disk9 disk6)
        (smaller disk9 disk5)
        (smaller disk9 disk4)
        (smaller disk9 disk3)
        (smaller disk9 disk2)
        (smaller disk9 disk1)
        (smaller disk8 disk7)
        (smaller disk8 disk6)
        (smaller disk8 disk5)
        (smaller disk8 disk4)
        (smaller disk8 disk3)
        (smaller disk8 disk2)
        (smaller disk8 disk1)
        (smaller disk7 disk6)
        (smaller disk7 disk5)
        (smaller disk7 disk4)
        (smaller disk7 disk3)
        (smaller disk7 disk2)
        (smaller disk7 disk1)
        (smaller disk6 disk5)
        (smaller disk6 disk4)
        (smaller disk6 disk3)
        (smaller disk6 disk2)
        (smaller disk6 disk1)
        (smaller disk5 disk4)
        (smaller disk5 disk3)
        (smaller disk5 disk2)
        (smaller disk5 disk1)
        (smaller disk4 disk3)
        (smaller disk4 disk2)
        (smaller disk4 disk1)
        (smaller disk3 disk2)
        (smaller disk3 disk1)
        (smaller disk2 disk1)
    )
    (:goal (and 
        (on disk1 peg3)
        (on disk2 disk1)
        (on disk3 disk2)
        (on disk4 disk3)
        (on disk5 disk4)
        (on disk6 disk5)
        (on disk7 disk6)
        (on disk8 disk7)
        (on disk9 disk8)
    ))
)