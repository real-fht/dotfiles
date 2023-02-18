{config, ...}:
# General security, stability and some performance settings for the system.
# They aren't very like effective but they atleast but a base for the system
# to not crumble apart.
{
  # Enable the builtin firewall that relies on iptables(or nftables) to filter
  # incoming/outgoing TCP or UCP connexions.
  networking.firewall = {
    enable = true;
    allowPing = false; # don't allow ping messages to enter the system.
    logReversePathDrops = true; # for packets that fail the reverse path check
    allowedTCPPorts = [80 443];
  };

  # Put the tmpFS on RAM so it's snappy and volative on reboot.
  # Makes temporary file management fast on ssd systems.
  boot.tmpOnTmpfs = true;
  # CLean the /tmp directory if the tmpfs isn't on RAM.
  boot.cleanTmpDir = !config.boot.tmpOnTmpfs;

  boot.kernel.sysctl = {
    # The Magic SysRq key is a key combo that allows users connected to the
    # system console of a Linux kernel to perform some low-level commands.
    # Disable it, since we don't need it, and is a potential security concern.
    "kernel.sysrq" = 0;

    ## TCP hardening
    # Prevent bogus ICMP errors from filling up logs.
    "net.ipv4.icmp_ignore_bogus_error_responses" = 1;
    # Reverse path filtering causes the kernel to do source validation of
    # packets received from all interfaces. This can mitigate IP spoofing.
    "net.ipv4.conf.default.rp_filter" = 1;
    "net.ipv4.conf.all.rp_filter" = 1;
    # Do not accept IP source route packets (we're not a router)
    "net.ipv4.conf.all.accept_source_route" = 0;
    "net.ipv6.conf.all.accept_source_route" = 0;
    # Don't send ICMP redirects (again, we're on a router)
    "net.ipv4.conf.all.send_redirects" = 0;
    "net.ipv4.conf.default.send_redirects" = 0;
    # Refuse ICMP redirects (MITM mitigations)
    "net.ipv4.conf.all.accept_redirects" = 0;
    "net.ipv4.conf.default.accept_redirects" = 0;
    "net.ipv4.conf.all.secure_redirects" = 0;
    "net.ipv4.conf.default.secure_redirects" = 0;
    "net.ipv6.conf.all.accept_redirects" = 0;
    "net.ipv6.conf.default.accept_redirects" = 0;
    # Protects against SYN flood attacks
    "net.ipv4.tcp_syncookies" = 1;
    # Incomplete protection again TIME-WAIT assassination
    "net.ipv4.tcp_rfc1337" = 1;

    ## TCP optimization
    # TCP Fast Open is a TCP extension that reduces network latency by packing
    # data in the sender’s initial TCP SYN. Setting 3 = enable TCP Fast Open for
    # both incoming and outgoing connections:
    "net.ipv4.tcp_fastopen" = 3;
    # Bufferbloat mitigations + slight improvement in throughput & latency
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.core.default_qdisc" = "cake";
  };

  # Initial password for root and my user account.
  # MAKE SURE TO CHANGE AFTER REBOOT.
  user.initialPassword = "nixos";
  users.users.root.initialPassword = "nixos";

  # Enable doas as my preferred authentication program.
  # Not only it's way more minimal that sudo (which is people's main argument) it is
  # atleast for me for faster.
  security.doas = {
    enable = true;
    extraRules = let
      noPassCmd = groups: cmd: {
        groups = ["wheel"];
        noPass = true;
        keepEnv = true;
      };
    in [
      {
        # Basic setup to allow authentication if you're in the traditional wheel group.
        # keepEnv is not obligatory, but the main reason I use this is to keep configuration settings
        # for programs I launch with doas.
        groups = ["wheel"];
        keepEnv = true;
        persist = true;
      }
      # general nixos actions.
      (noPassCmd ["wheel"] "nixos-rebuild")
      (noPassCmd ["wheel"] "nixos-container")
      # System management.
      (noPassCmd ["wheel"] "systemctl")
    ];
  };
  # Aaaand disable sudo now!
  security.sudo.enable = false;

  # So we don't have to do this later...
  security.acme.acceptTerms = true;
}
