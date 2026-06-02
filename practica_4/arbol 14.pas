{14. Dado el siguiente árbol B+ de orden 4, con política de resolución de underflow a derecha, realice
las siguientes operaciones: +80, -400, -50, -11, -77. Por cada operación:}

                        nodo 4
                     |340,400,500|
     /4           |4               |4          \4
   nodo 0        nodo 1          nodo 2       nodo 3
|11,50,77|   |340,350,360|   |402,410,420|   |520,530|

// L4, L0, E0, E4, E4, E6, E7
                        nodo 7
                        |400|

                nodo 4                  nodo  6
                |77,340|                    |500|
     /4           |4                    |6          \6
   nodo 0   nodo 5       nodo 1          nodo 2       nodo 3
|11,50|   |77,80|   |340,350,360|       |402,410,420|   |520,530|


// L7,L6,L2,E2
                        nodo 7
                        |400|

                nodo 4                  nodo  6
                |77,340|                    |500|
     /4           |4                    |6          \6
   nodo 0   nodo 5       nodo 1          nodo 2       nodo 3
|11,50|   |77,80|   |340,350,360|       |410,420|   |520,530|

// L7,L4,L0,E0
                        nodo 7
                        |400|

                nodo 4                  nodo  6
                |77,340|                    |500|
     /4           |4                    |6          \6
   nodo 0   nodo 5       nodo 1          nodo 2       nodo 3
|11|        |77,80|   |340,350,360|       |410,420|   |520,530|


// L7,L4,L0,E5,E0,E4
                        nodo 7
                        |400|

                nodo 4                  nodo  6
                |80,340|                    |500|
     /4           |4                    |6          \6
   nodo 0    nodo 5       nodo 1          nodo 2       nodo 3
|77|          |80|        |340,350,360|       |410,420|   |520,530|


// L7,L4,L0,E5,E0,E4
                        nodo 7
                        |400|

                nodo 4                  nodo  6
                |340|                    |500|
     /4           |4                    |6          \6
   nodo 0            nodo 1          nodo 2       nodo 3
   |80|            |340,350,360|       |410,420|   |520,530|