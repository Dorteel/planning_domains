(define (problem object_arrangement)
    (:domain object_arrangement)
    (:objects
        red_plate - plate
        banana - food
        black_basket - container
        blue_spoon - cutlery
        screwdriver - tool
        wp1s wp2s wp3s wp4s wp5s wp6s - location
        wp1f wp2f wp3f wp4f - location
        out_location - location 
    )
    (:init
        (at red_plate wp1s)
        (on banana red_plate)
        (at black_basket wp3s)
        (in blue_spoon black_basket)
        (in screwdriver black_basket)
    )
    (:goal
        (and
            (at red_plate wp1f)
            (at black_basket wp2f)
            (at blue_spoon wp3f)
            (on banana red_plate)
            (at screwdriver out_location)
        )
    )
)