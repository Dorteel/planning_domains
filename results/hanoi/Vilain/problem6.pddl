(define (problem hanoi) 
(:domain hanoi) 
(:objects
	peg1
	peg2
	peg3
	green_disk1
	pink_disk1
) 
(:init
    (clear peg1)
    (clear peg2)
    (clear peg3)
    (on green_disk1 peg1)
    (on pink_disk1 peg2)
    (smaller green_disk1 peg1)
    (smaller green_disk1 peg2)
    (smaller green_disk1 peg3)
    (smaller pink_disk1 peg1)
    (smaller pink_disk1 peg2)
    (smaller pink_disk1 peg3)
) 
(:goal (and 
    (on pink_disk1 peg3)
    (on green_disk1 pink_disk1)
)) 
)