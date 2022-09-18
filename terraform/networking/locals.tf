locals {
    subnets_publicas = [
        {
            rango="10.1.1.0" 
            az="a"
        },
        {
            rango="10.1.2.0" 
            az="b"
        } ,
        {
            rango="10.1.3.0"
            az="c"
        }
    ]
    subnets_privadas = [
        {
            rango="10.1.4.0" 
            az="a"
        } ,
        {
            rango="10.1.5.0" 
            az="b"
        },
        {
            rango="10.1.6.0" 
            az="c"
        }
    ]
    subnets_privadas_db = [
        {
            rango="10.1.7.0" 
            az="a"
        } ,
        {
            rango="10.1.8.0" 
            az="b"
        } ,
        {
            rango="10.1.9.0" 
            az="c"
        }
    ]
}