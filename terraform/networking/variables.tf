
variable "region" {
  description = "the region"
  type        = string
  default     = ""
}

variable "subnets_publicas" {
  description = "the region"
  type        = map(object({
    rango = string
    az = string
  }))

  default     = {
    "spa" =    {
            rango="10.1.1.0/24" 
            az="a"
        },
    "spb" =      {
            rango="10.1.2.0/24" 
            az="b"
        } ,
    "spc" =      {
            rango="10.1.3.0/24"
            az="c"
        }
  }
}

variable "subnets_privadas" {
  description = "the region"
  type        = map(object({
    rango = string
    az = string
  }))
  default     = {
    "spva" =     {
            rango="10.1.4.0/24" 
            az="a"
        } ,
    "spvb" =     {
            rango="10.1.5.0/24" 
            az="b"
        },
    "spvc" =     {
            rango="10.1.6.0/24" 
            az="c"
        }
  }
}

variable "subnets_privadas_db" {
  description = "the region"
  type        = map(object({
    rango = string
    az = string
  }))
  default     = {
        "sdba" = {
            rango="10.1.7.0/24" 
            az="a"
        } ,
        "sdbb" = {
            rango="10.1.8.0/24" 
            az="b"
        } ,
       "sdbc" = {
            rango="10.1.9.0/24" 
            az="c"
        }
  }
}
