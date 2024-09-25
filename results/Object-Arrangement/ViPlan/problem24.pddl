(define (problem object_arrangement)
    (:domain object_arrangement)
    (:objects
        pear - food
        banana - food
        cup - container
        wp1s wp2s wp3s - location
        wp1f wp2f wp3f - location
    )
    (:init
        (at pear wp1s)
        (at cup wp2s)
        (in banana cup)
    )
    (:goal
        (and
            (at pear wp1f)
            (at cup wp2f)
            (in banana cup)
        )
    )
)