(define (problem blocksworld1)
    (:domain blocksworld)
    (:objects
        red_block - block
        blue_block - block
        purple_block - block
        pink_block - block
        robot - robot
    )
    (:init
        (ontable blue_block)
        (ontable red_block)
        (on pink_block purple_block)
        (on purple_block blue_block)
        (clear red_block)
        (clear pink_block)
        (handempty robot)
    )
    (:goal (and 
        (on red_block blue_block)
        (on blue_block purple_block)
        (on purple_block pink_block)
    ))
)