# Configure these variables



variable "sample_var" {
  description = "A sample var to pass to the template."
  default     = "hello"
}


variable "boolian_var" {
  description = "If I can sleep"
  type        = bool
  default     = true
}


variable "list_any_flow_scalar" {
  type    = list(any)
  default = ["blue-horizon", "mgm-grand", "madison-square-garden"]
}

variable "list_any_block_scalar" {
  type    = list(any)
  default = ["blue-horizon", "mgm-grand", "madison-square-garden"]
}




variable "map_ref_test" {
  type    = map(number)
  default = { name = 990, age = 52 }
}

variable "map_simple_string" {
  type    = map(string)
  default = { "lit" = "Mabel", age = "alage" }
}


variable "docker_ports" {
  type = list(object({
    internal = number
    external = number
    protocol = string
  }))
  default = [
    {
      internal = 8300
      external = 8300
      protocol = "tcp"
    },
    {
      internal = 8301
      external = 8301
      protocol = "ldp"
    }
  ]
}

variable "simple_tuple" {
  type    = tuple([string, string, number, bool])
  default = ["hello", "hi", 34.5, false]
}


variable "nested_set" {
  type    = set(list(number))
  default = [[5, 6], [5, 6], [3, ], ]
}



