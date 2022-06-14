# Create an arbitrary local resource
data "template_file" "test" {
  template = "Hello, I am a template. My sample_var value = $${sample_var}"

  vars = {
    sample_var = var.sample_var
  }
}

resource "null_resource" "sleep" {
  triggers = {
    uuid = uuid()
  }

  provisioner "local-exec" {
    command = "echo ${var.map_ref_test["age"]}"
  }
}

resource "null_resource" "print_list" {
  triggers = {
    uuid = uuid()
  }
  count = length(var.docker_ports)

  provisioner "local-exec" {
    command = "echo Docker port ${count.index} internal, ${var.docker_ports[count.index].internal} external ${var.docker_ports[count.index].external} and protocol ${var.docker_ports[count.index].protocol}"
  }
}


output "test_tuple" {
  value       = var.simple_tuple[*]
  description = "simple tuple entries"
}


output "nested_complex" {
  value       = var.docker_ports
  description = "nested_complex"
}
