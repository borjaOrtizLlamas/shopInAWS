resource "aws_route53_zone" "dns-private" {
  name = "${var.SUFIX}.tfm.com"

  vpc {
    vpc_id = "${aws_vpc.unir_shop_vpc_dev.id}"
  }
}


resource "aws_route53_record" "mongo-record" {
  zone_id = "${aws_route53_zone.dns-private.zone_id}"
  name    = "mongo.${var.SUFIX}.tfm.com"
  type    = "A"
  ttl     = "300"
  records = ["${aws_eip.mongoEIP.private_ip}"]
}

resource "aws_route53_record" "kibana-record" {
  zone_id = "${aws_route53_zone.dns-private.zone_id}"
  name    = "kibana.${var.SUFIX}.tfm.com"
  type    = "A"
  ttl     = "300"
  depends_on = ["aws_eip.mongoEIP"]

  records = ["${aws_eip.mongoEIP.private_ip}"]
}