# Create EC2 Key Pair
module "aws-keypair" {
  source = "modules/aws-infra/aws-keypair"

  keypair_name   = var.keypair_name
  public_keypair = file("data/key-pairs/mc-keypair.pub")
}