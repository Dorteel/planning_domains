(define (problem blocksworld1)
    (:domain blocksworld)
    (:objects
        yellow_block - block
        pink_block - block
        purple_block - block
        red_block - block
        orange_block - block
        robot - robot
    )
    (:init
        (ontable yellow_block)
        (ontable red_block)
        (on pink_block yellow_block)
        (on purple_block pink_block)
        (on orange_block red_block)
        (handempty robot)
        (clear purple_block)
        (clear orange_block)
    )
    (:goal (and 
        (on pink_block purple_block)
        (on yellow_block orange_block)
    ))
)