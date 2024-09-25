(define (problem object_arrangement)
    (:domain object_arrangement)
    (:objects
        knife1 - cutlery
        knife2 - cutlery
        fork1 - cutlery
        fork2 - cutlery
        fork3 - cutlery
        spoon1 - cutlery
        spoon2 - cutlery
        pear - food
        cup - container
        wp1s wp2s wp3s wp4s wp5s wp6s wp7s wp8s wp9s wp10s wp11s wp12s wp13s wp14s wp15s wp16s wp17s wp18s wp19s wp20s wp21s wp22s wp23s wp24s wp25s - location
        wp1f wp2f wp3f wp4f wp5f wp6f wp7f wp8f wp9f wp10f wp11f wp12f wp13f wp14f wp15f wp16f wp17f wp18f wp19f wp20f wp21f wp22f wp23f wp24f wp25f - location
        out_location - location 
    )
    (:init
        (at knife1 wp1s)
        (at knife2 wp2s)
        (at fork1 wp3s)
        (at fork2 wp4s)
        (at fork3 wp5s)
        (at spoon1 wp6s)
        (at spoon2 wp7s)
        (at pear wp8s)
        (at cup wp9s)
        (at scissors wp10s)
        (at screwdriver wp11s)
        (at tape wp12s)
        (at highlighter wp13s)
        (at green_cube wp14s)
        (at yellow_cube wp15s)
        (at orange_cube wp16s)
        (at black_cube wp17s)
        (at tennis_ball wp18s)
    )
    (:goal
        (and
            (at knife1 wp1f)
            (at knife2 wp2f)
            (at fork1 wp3f)
            (at fork2 wp4f)
            (at fork3 wp5f)
            (at spoon1 wp6f)
            (at spoon2 wp7f)
            (at cup wp8f)
            (on pear cup)
            (at scissors out_location)
            (at screwdriver out_location)
            (at tape out_location)
            (at highlighter out_location)
            (at green_cube out_location)
            (at yellow_cube out_location)
            (at orange_cube out_location)
            (at black_cube out_location)
            (at tennis_ball out_location)
        )
    )
)