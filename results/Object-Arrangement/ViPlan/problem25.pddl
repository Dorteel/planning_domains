(define (problem object_arrangement)
    (:domain object_arrangement)
    (:objects
        plate - plate
        pear banana - food
        bowl - container
        wp1s wp2s - location
        wp1f wp2f - location
    )
    (:init
        (at plate wp1s)
        (on pear plate)
        (at bowl wp2s)
        (on banana bowl)
    )
    (:goal
        (and
            (at plate wp1f)
            (at bowl wp2f)
            (on pear plate)
            (on banana bowl)
        )
    )
)