(define (problem object_arrangement)
    (:domain object_arrangement)
    (:objects
        red_plate - plate
        red_bowl - bowl
        black_basket - basket
        green_pear yellow_banana - food
        blue_mug red_cup - cup
        blue_screwdriver black_screwdriver - tool
        silver_scissors - tool
        black_tape - tool
        yellow_hexagon orange_cube green_cube - block
        tennis_ball - ball
        wp1s wp2s wp3s wp4s wp5s wp6s wp7s wp8s wp9s wp10s wp11s wp12s wp13s wp14s - location
        wp1f wp2f wp3f wp4f wp5f wp6f wp7f wp8f wp9f wp10f wp11f wp12f wp13f wp14f - location
        out_location - location 
    )
    (:init
        (at red_plate wp1s)
        (at red_bowl wp2s)
        (at black_basket wp3s)
        (at green_pear wp4s)
        (at yellow_banana wp5s)
        (at blue_mug wp6s)
        (at red_cup wp7s)
        (at blue_screwdriver wp8s)
        (at black_screwdriver wp9s)
        (at silver_scissors wp10s)
        (at black_tape wp11s)
        (at yellow_hexagon wp12s)
        (at orange_cube wp13s)
        (at green_cube wp14s)
        (at tennis_ball wp15s)
    )
    (:goal
        (and
            (at red_plate wp1f)
            (at red_bowl wp2f)
            (at black_basket wp3f)
            (at blue_mug wp4f)
            (at red_cup wp5f)
            (on green_pear red_plate)
            (on yellow_banana red_plate)
            (at blue_screwdriver out_location)
            (at black_screwdriver out_location)
            (at silver_scissors out_location)
            (at black_tape out_location)
            (at yellow_hexagon out_location)
            (at orange_cube out_location)
            (at green_cube out_location)
            (at tennis_ball out_location)
        )
    )
)