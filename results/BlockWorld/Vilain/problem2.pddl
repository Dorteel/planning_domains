(define (problem blocksworld) 
(:domain blocksworld) 
(:objects
	red_block - block
	blue_block - block
	purple_block - block
	pink_block - block
	robot - robot
) 
(:init
    (ontable red_block)
    (ontable blue_block)
    (ontable purple_block)
    (ontable pink_block)
    (handempty robot)
    (clear red_block)
    (clear blue_block)
    (clear purple_block)
    (clear pink_block)
) 
(:goal (and 
    (on pink_block purple_block)
    (on purple_block blue_block)
    (on blue_block red_block)
)) 
)