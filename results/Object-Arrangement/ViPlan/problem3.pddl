(define (problem object_arrangement)
    (:domain object_arrangement)
    (:objects
        fork - cutlery
        knife - cutlery
        bowl - bowl
        banana pear - fruit
        mug glass - container
        wp1s wp2s wp3s wp4s wp5s wp6s wp7s - location
        wp1f wp2f wp3f wp4f wp5f wp6f - location
        out_location - location 
    )
    (:init
        (at fork wp1s)
        (at knife wp2s)
        (at bowl wp3s)
        (at banana wp4s)
        (at pear wp5s)
        (at mug wp6s)
        (at glass wp7s)
    )
    (:goal
        (and
            (at fork wp1f)
            (at knife wp2f)
            (at bowl wp3f)
            (at mug wp4f)
            (at glass wp5f)
            (on banana bowl)
            (on pear bowl)
        )
    )
)