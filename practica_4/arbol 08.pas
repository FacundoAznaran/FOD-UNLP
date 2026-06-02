+5, +9, +80, +15, -92, -77
                        nodo 2
            nodo 0      |66|            nodo 1
        |22,32,50|                    |77,79,92|

// L2,L0,E0,E3,E2


                        nodo 2
                        |32,66|
            nodo 0       nodo 3           nodo 1
        |5,22|             |50|             |77,79,92|

// L2, L0, E0
                        nodo 2
                        |32,66|
            nodo 0       nodo 3           nodo 1
        |5,9,22|             |50|             |77,79,92|


// L2,L1,E1, E4,E2
                        nodo 2
                        |32,66,80|
            nodo 0       nodo 3           nodo 1        nodo 4
        |5,9,22|          |50|             |77,79|      |92|

+15
// L2, L0, E0, E5, E2, E6, E7
                                         nodo 7
                                        |66|
                        nodo 2                           nodo 6
                        |15,32|                         |80|

        nodo 0        nodo 5        nodo 3           nodo 1        nodo 4
        |5,9|         |22|          |50|             |77,79|      |92|


//L7, L6, L4, L1, E1, E6, E4
                                         nodo 7
                                        |66|
                        nodo 2                                   nodo 6
                        |15,32|                                 |79|

        nodo 0        nodo 5        nodo 3                  nodo 1        nodo 4
        |5,9|         |22|          |50|                    |77|           |80|


// L7, L6, L1, L4, E1, E6, L2, E2, E7, E6
                                         nodo 7
                                        |32|
                        nodo 2                                   nodo 6
                        |15|                                    |66|

        nodo 0        nodo 5                        nodo 3                  nodo 1
        |5,9|         |22|                          |50|                    |79,80|          