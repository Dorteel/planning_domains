(define (problem Object-Arrangement) 
(:domain Object-Arrangement) 
(:objects
) 
(:init
    (at screw_driver wp1s)
    (at basket wp2s)
    (at spoon wp3s)
    (at plate wp4s)
    (at banana wp5s)
) 
(:goal (and 
    (at basket wp1f)
    (at spoon wp2f)
    (at plate wp3f)
    (on banana plate)
    (at screw_driver out_location)
)) 
)