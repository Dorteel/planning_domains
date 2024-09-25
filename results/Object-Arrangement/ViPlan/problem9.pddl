(define (problem object_arrangement)
    (:domain object_arrangement)
    (:objects
        red_plate - plate
        green_apple yellow_banana - food
        green_bowl - container
        blue_knife silver_fork - cutlery
        blue_mug - mug
        glass - glass
        wp1s wp2s wp3s wp4s wp5s wp6s wp7s wp8s wp9s - location
        wp1f wp2f wp3f wp4f wp5f wp6f wp7f wp8f wp9f - location
        out_location - location 
    )
    (:init
        (at red_plate wp1s)
        (at green_apple wp2s)
        (at yellow_banana wp3s)
        (at green_bowl wp4s)
        (at blue_knife wp5s)
        (at silver_fork wp6s)
        (at blue_mug wp7s)
        (at glass wp8s)
    )
    (:goal
        (and
            (at red_plate wp1f)
            (at green_bowl wp2f)
            (at blue_knife wp3f)
            (at silver_fork wp4f)
            (at blue_mug wp5f)
            (at glass wp6f)
            (on green_apple red_plate)
            (on yellow_banana green_bowl)
        )
    )
)