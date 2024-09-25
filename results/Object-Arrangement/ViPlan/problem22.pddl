(define (problem object_arrangement)
    (:domain object_arrangement)
    (:objects
        knife1 knife2 knife3 - knife
        fork1 fork2 fork3 fork4 - fork
        spoon1 spoon2 - spoon
        scissors - object
        screwdriver - tool
        highlighter - object
        cube - object
        wp1s wp2s wp3s wp4s wp5s wp6s wp7s wp8s wp9s wp10s wp11s wp12s wp13s - location
        wp1f wp2f wp3f wp4f wp5f wp6f wp7f wp8f wp9f wp10f wp11f - location
        out_location - location 
    )
    (:init
        (at knife1 wp1s)
        (at knife2 wp2s)
        (at knife3 wp3s)
        (at fork1 wp4s)
        (at fork2 wp5s)
        (at fork3 wp6s)
        (at fork4 wp7s)
        (at spoon1 wp8s)
        (at spoon2 wp9s)
        (at scissors wp10s)
        (at screwdriver wp11s)
        (at highlighter wp12s)
        (at cube wp13s)
    )
    (:goal
        (and
            (at knife1 wp1f)
            (at knife2 wp2f)
            (at knife3 wp3f)
            (at fork1 wp4f)
            (at fork2 wp5f)
            (at fork3 wp6f)
            (at fork4 wp7f)
            (at spoon1 wp8f)
            (at spoon2 wp9f)
            (at scissors out_location)
            (at screwdriver out_location)
            (at highlighter out_location)
            (at cube out_location)
        )
    )
)