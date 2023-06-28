locals {
  lab_a_records = {
    esx01   = ["192.168.2.2"]
    vsphere = ["192.168.2.4"]
  }
}

resource "dns_a_record_set" "lab" {
  for_each  = local.lab_a_records

  zone      = "lab.techandtools.net."
  name      = each.key
  addresses = each.value
  ttl       = 3600
}