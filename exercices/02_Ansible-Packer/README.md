# TP02 - Ansible and Packer


TLDR :
```bash
# 1. Create an online VM to execute packer and ansible playbooks


# 2. Create playbook

# 3. Build the AMI

# 4. Deploy an EC2 instance based on the custom AMI


```


## Create a working VM with packer and Ansible (instance `ToolsCICD`)

### Terraform code
```hcl
resource "aws_instance" "ToolsCICD" {
  ami           = "ami-035966e8adab4aaad" # Ubuntu Server 18.04 LTS (HVM), SSD Volume Type
  instance_type = "t2.micro"

  associate_public_ip_address = true # We ask for a public IP

  subnet_id = aws_subnet.sub_pub.id # The public subnet Id 
  user_data = file(var.ec2_startup_script)

  key_name          = aws_key_pair.rufol.key_name
  source_dest_check = false # Default true, but because we use this instance as a NAT we have to disable it

  tags = {
    Name = "ToolsCICD"
  }

  vpc_security_group_ids = [aws_security_group.SSH.id]
}
```

### We connect to the remote instance using ssh

> We will also check if the ansible command is available

```bash
Apply complete! Resources: 1 added, 0 changed, 1 destroyed.

Outputs:

RemoteServer-instance = ec2-34-241-15-171.eu-west-1.compute.amazonaws.com
ToolsCICD-instance = ec2-52-209-38-69.eu-west-1.compute.amazonaws.com
λ C:\WORK\EFREI-M1-DevOps\exercices\02_Ansible-Packer\infra-as-code> ssh ubuntu@ec2-52-209-38-69.eu-west-1.compute.amazonaws.com
The authenticity of host 'ec2-52-209-38-69.eu-west-1.compute.amazonaws.com (52.209.38.69)' can't be established.
ECDSA key fingerprint is SHA256:U9Fl7F/gvHCmCQHh4G3CxtVJhDfHbk64/MUyreV8EP4.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'ec2-52-209-38-69.eu-west-1.compute.amazonaws.com,52.209.38.69' (ECDSA) to the list of known hosts.
Welcome to Ubuntu 18.04.3 LTS (GNU/Linux 4.15.0-1057-aws x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  System information as of Sat Feb 29 21:43:18 UTC 2020

  System load:  0.79              Processes:           97
  Usage of /:   17.2% of 7.69GB   Users logged in:     0
  Memory usage: 23%               IP address for eth0: 172.16.1.170
  Swap usage:   0%

55 packages can be updated.
32 updates are security updates.



The programs included with the Ubuntu system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
applicable law.

To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.

ubuntu@ip-172-16-1-170:~$ ansible
usage: ansible [-h] [--version] [-v] [-b] [--become-method BECOME_METHOD]
               [--become-user BECOME_USER] [-K] [-i INVENTORY] [--list-hosts]
               [-l SUBSET] [-P POLL_INTERVAL] [-B SECONDS] [-o] [-t TREE] [-k]
               [--private-key PRIVATE_KEY_FILE] [-u REMOTE_USER]
               [-c CONNECTION] [-T TIMEOUT]
               [--ssh-common-args SSH_COMMON_ARGS]
               [--sftp-extra-args SFTP_EXTRA_ARGS]
               [--scp-extra-args SCP_EXTRA_ARGS]
               [--ssh-extra-args SSH_EXTRA_ARGS] [-C] [--syntax-check] [-D]
               [-e EXTRA_VARS] [--vault-id VAULT_IDS]
               [--ask-vault-pass | --vault-password-file VAULT_PASSWORD_FILES]
               [-f FORKS] [-M MODULE_PATH] [--playbook-dir BASEDIR]
               [-a MODULE_ARGS] [-m MODULE_NAME]
               pattern
ansible: error: too few arguments
ubuntu@ip-172-16-1-170:~$ 
```


> The folowing description and screenshots will be based on an other teammate

![Check if ansible is installed](https://imgur.com/dYkg2pV.png)

By using Mobaxterm, we win a bit of time

![Mobaxterm easy copy function](https://imgur.com/N3MBA4P.png)

Let’s get the IP of the other machine

![Other instance's ip address](https://imgur.com/gljlxkv.png)

And now let’s ping it !

![Oups, chmod issue](https://imgur.com/15A2GDc.png)

A problem with the key ! I forgot to chmod 400, let's do it and start again

![Fix the chmod issue](https://imgur.com/q8L72Wa.png)

![Asible ping test successful](https://imgur.com/v7lClWQ.png)

We’re creating our playbook1.yml and start it

![playbook1.yml content](https://imgur.com/XGC448A.png)

And it works !

![Ansible playbook](https://imgur.com/BupNRUe.png)

We now need to create a playbook to start an apache server, let’s do it by browsing the ansible doc: 

![ansible doc](https://imgur.com/rimnicm.png)

![ansible doc2](https://imgur.com/0bQR8M5.png)

It seems like we already have enough to install Apache ! Let’s add it to our playbook ! Little error to start, do NOT use tabs !

![tab   bbs](https://imgur.com/CqJdW5e.png)


And it seems like we forgot to add the version name now !

![add version name](https://imgur.com/nrI6wJK.png)

By incrementing the playbook, we get this:

![playbook](https://imgur.com/rjcJcTp.png)

But it still lacks sudo ! After a bit of reading doc, we see that we need an escalation of right, and it can be done by adding become: yes and it works like a charm !

![ansible root](https://imgur.com/rVnfvNw.png)

By incrementing our playbook, we make it work by starting our apache after cloning the github repository.

![increment playbook](https://imgur.com/6eHstY3.png)

Now to see if your website is on, lets update the security group !

![sg](https://imgur.com/KTKNW0U.png)

Finished with Apache and Ansible ! Let’s build our AMI with Packer !

