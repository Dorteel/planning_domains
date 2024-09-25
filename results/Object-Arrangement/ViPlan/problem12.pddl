(define (problem object_arrangement)
    (:domain object_arrangement)
    (:objects
        red_plate - plate
        green_pear - food
        black_basket - container
        blue_handle_spoon - cutlery
        silver_fork - cutlery
        blue_handle_knife - cutlery
        black_remote - object
        red_black_screwdriver - tool
        red_black_scissors - tool
        wp1s wp2s wp3s wp4s wp5s wp6s wp7s wp8s wp9s wp10s - location
        wp1f wp2f wp3f wp4f wp5f wp6f wp7f wp8f wp9f wp10f - location
        out_location - location 
    )
    (:init
        (at red_plate wp1s)
        (at green_pear wp2s)
        (at black_basket wp3s)
        (at blue_handle_spoon wp4s)
        (at silver_fork wp5s)
        (at blue_handle_knife wp6s)
        (at black_remote wp7s)
        (at red_black_screwdriver wp8s)
        (at red_black_scissors wp9s)
    )
    (:goal
        (and
            (at red_plate wp1f)
            (at black_basket wp2f)
            (at blue_handle_spoon wp3f)
            (at silver_fork wp4f)
            (at blue_handle_knife wp5f)
            (on green_pear red_plate)
            (at black_remote out_location)
            (at red_black_screwdriver out_location)
            (at red_black_scissors out_location)
        )
    )
)