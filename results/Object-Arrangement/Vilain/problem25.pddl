(define (problem Object-Arrangement) 
(:domain Object-Arrangement) 
(:objects
) 
(:init
    (at plate wp1s)
    (at pear wp2s)
    (at plate2 wp3s)
    (at banana wp4s)
) 
(:goal (and 
    (at plate wp1f)
    (at pear wp2f)
    (at plate2 wp3f)
    (at banana out_location)
)) 
)