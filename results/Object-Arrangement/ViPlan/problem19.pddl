(define (problem object_arrangement)
    (:domain object_arrangement)
    (:objects
        red_plate - plate
        red_bowl - bowl
        pear - food
        fork1 fork2 fork3 fork4 - cutlery
        knife1 knife2 - cutlery
        spoon1 spoon2 spoon3 - cutlery
        red_mug - mug
        screwdriver - tool
        scissors - tool
        tennis_ball - object
        tape - object
        cube1 cube2 - object
        highlighter - object
        eraser - object
        wp1s wp2s wp3s wp4s wp5s wp6s wp7s wp8s wp9s wp10s wp11s wp12s wp13s wp14s wp15s wp16s wp17s wp18s wp19s wp20s wp21s wp22s wp23s wp24s wp25s wp26s wp27s wp28s wp29s wp30s - location
        wp1f wp2f wp3f wp4f wp5f wp6f wp7f wp8f wp9f wp10f wp11f wp12f wp13f wp14f wp15f wp16f wp17f wp18f wp19f wp20f wp21f wp22f wp23f wp24f wp25f wp26f wp27f wp28f wp29f wp30f - location
        out_location - location 
    )
    (:init
        (at red_plate wp1s)
        (at red_bowl wp2s)
        (at pear wp3s)
        (at fork1 wp4s)
        (at fork2 wp5s)
        (at fork3 wp6s)
        (at fork4 wp7s)
        (at knife1 wp8s)
        (at knife2 wp9s)
        (at spoon1 wp10s)
        (at spoon2 wp11s)
        (at spoon3 wp12s)
        (at red_mug wp13s)
        (at screwdriver wp14s)
        (at scissors wp15s)
        (at tennis_ball wp16s)
        (at tape wp17s)
        (at cube1 wp18s)
        (at cube2 wp19s)
        (at highlighter wp20s)
        (at eraser wp21s)
    )
    (:goal
        (and
            (at red_plate wp1f)
            (at red_bowl wp2f)
            (at fork1 wp3f)
            (at fork2 wp4f)
            (at fork3 wp5f)
            (at fork4 wp6f)
            (at knife1 wp7f)
            (at knife2 wp8f)
            (at spoon1 wp9f)
            (at spoon2 wp10f)
            (at spoon3 wp11f)
            (at red_mug wp12f)
            (on pear red_plate)
            (at screwdriver out_location)
            (at scissors out_location)
            (at tennis_ball out_location)
            (at tape out_location)
            (at cube1 out_location)
            (at cube2 out_location)
            (at highlighter out_location)
            (at eraser out_location)
        )
    )
)