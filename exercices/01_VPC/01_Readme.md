# Ex1

```bash

terraform plan

terraform apply

ssh -J ubuntu@{public-ip-of-nat-gwt-here} ubuntu@{private-ip-of-test-instance-here}

ubuntu@private-instance: ~$ ping {private-ip-of-nat-gwt}

ubuntu@private-instance: exit

terraform destroy

```

