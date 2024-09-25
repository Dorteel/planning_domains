(define (problem object_arrangement)
    (:domain object_arrangement)
    (:objects
        red_plate - plate
        green_pear yellow_banana - food
        black_basket green_bowl - container
        blue_knife silver_fork silver_spoon - cutlery
        blue_mug black_mug - mug
        wp1s wp2s wp3s wp4s wp5s wp6s wp7s wp8s wp9s wp10s wp11s wp12s - location
        wp1f wp2f wp3f wp4f wp5f wp6f wp7f wp8f wp9f wp10f wp11f wp12f - location
        out_location - location 
    )
    (:init
        (at red_plate wp1s)
        (at green_pear wp2s)
        (at yellow_banana wp3s)
        (at black_basket wp4s)
        (at green_bowl wp5s)
        (at blue_knife wp6s)
        (at silver_fork wp7s)
        (at silver_spoon wp8s)
        (at blue_mug wp9s)
        (at black_mug wp10s)
    )
    (:goal
        (and
            (at red_plate wp1f)
            (at black_basket wp2f)
            (at green_bowl wp3f)
            (at blue_knife wp4f)
            (at silver_fork wp5f)
            (at silver_spoon wp6f)
            (at blue_mug wp7f)
            (at black_mug wp8f)
            (on green_pear red_plate)
            (on yellow_banana black_basket)
        )
    )
)