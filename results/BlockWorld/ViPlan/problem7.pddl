(define (problem blocksworld1)
    (:domain blocksworld)
    (:objects
        green_block - block
        yellow_block - block
        red_block - block
        pink_block - block
        purple_block - block
        orange_block - block
        robot - robot
    )
    (:init
        (ontable green_block)
        (ontable purple_block)
        (ontable orange_block)
        (on yellow_block pink_block)
        (on pink_block green_block)
        (on red_block purple_block)
        (clear yellow_block)
        (clear red_block)
        (clear orange_block)
        (handempty robot)
    )
    (:goal (and 
        (on yellow_block pink_block)
        (on pink_block green_block)
        (on green_block red_block)
        (on red_block purple_block)
        (on purple_block orange_block)
    ))
)