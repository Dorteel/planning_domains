(define (problem object_arrangement)
    (:domain object_arrangement)
    (:objects
        red_plate - plate
        green_pear - food
        black_basket - container
        silver_fork - cutlery
        blue_knife - cutlery
        screwdriver - tool
        remote_control - tool
        wp1s wp2s wp3s wp4s wp5s wp6s wp7s wp8s - location
        wp1f wp2f wp3f wp4f wp5f wp6f - location
        out_location - location 
    )
    (:init
        (at red_plate wp1s)
        (at green_pear wp2s)
        (at black_basket wp3s)
        (at silver_fork wp4s)
        (at blue_knife wp5s)
        (at screwdriver wp6s)
        (at remote_control wp7s)
    )
    (:goal
        (and
            (at red_plate wp1f)
            (at black_basket wp2f)
            (at silver_fork wp3f)
            (at blue_knife wp4f)
            (on green_pear red_plate)
            (at screwdriver out_location)
            (at remote_control out_location)
        )
    )
)