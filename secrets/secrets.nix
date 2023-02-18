let
  # Public ssh key of night.
  night-ssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGV9qaC6vweF1MafVfb9QPP3vG7zz/wTS6B2F9dg4gRg";
  systems = [night-ssh]; # list of all my systems' ssh keys.

  # Public key of my user.
  real-ssh = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOgjaadkRzCNdPBwmN9NWSY3ua6CvCoxwmEa6m9EWwSk nferhat20@gmail.com";
  users = [real-ssh];
in {
  "secret1.age" = [real-ssh night-ssh]; # For my laptop secrets.
  "secret2.age" = users ++ systems;
}
