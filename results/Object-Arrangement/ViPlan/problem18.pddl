(define (problem object_arrangement)
    (:domain object_arrangement)
    (:objects
        fork1 fork2 fork3 fork4 - cutlery
        knife1 knife2 knife3 - cutlery
        spoon1 spoon2 spoon3 - cutlery
        wp1s wp2s wp3s wp4s wp5s wp6s wp7s wp8s wp9s wp10s - location
        wp1f wp2f wp3f wp4f wp5f wp6f wp7f wp8f wp9f wp10f - location
    )
    (:init
        (at fork1 wp1s)
        (at fork2 wp2s)
        (at fork3 wp3s)
        (at fork4 wp4s)
        (at knife1 wp5s)
        (at knife2 wp6s)
        (at knife3 wp7s)
        (at spoon1 wp8s)
        (at spoon2 wp9s)
        (at spoon3 wp10s)
    )
    (:goal
        (and
            (at fork1 wp1f)
            (at fork2 wp2f)
            (at fork3 wp3f)
            (at fork4 wp4f)
            (at knife1 wp5f)
            (at knife2 wp6f)
            (at knife3 wp7f)
            (at spoon1 wp8f)
            (at spoon2 wp9f)
            (at spoon3 wp10f)
        )
    )
)