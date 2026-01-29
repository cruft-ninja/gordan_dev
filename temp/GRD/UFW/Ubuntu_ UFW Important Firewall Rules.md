# Ubuntu: UFW Important Firewall Rules for Secure SSH and Database Access

UFW is a front-end for iptables that applies firewall policy directly on an Ubuntu server, close to the services that accept traffic.

On real systems, exposure is shaped by more than open ports. A service binds to an address, that address maps to an interface, and that interface may sit behind cloud security groups, VPNs, or container networks. UFW enforces policy inside that path, which is why rules that look correct can still fail once traffic hits the server.

The aim is to align those layers. You start by identifying what is listening and where, then apply UFW rules that match the server’s role and expected access. SSH, web services, and databases each behave differently, and the firewall only holds when those differences are made explicit.

## Before You Change UFW Rules: Check What Ports Are Listening

Before touching UFW, you need to know what the server is actually listening on. What matters is the current state, as the kernel sees it, because firewall rules only act on traffic headed toward existing listeners.

Start with `ss -tulpn`. On older systems, `netstat -tulpn` shows the same view. This output tells you which services are bound, on which ports, and, more importantly, on which addresses. UFW evaluates traffic after this binding decision, not before it.

When reviewing the output, the binding address is the key signal. It determines whether a service is reachable only from the host, from a private network, or from any interface that can route traffic to the server. Many exposure issues come from assuming a port is “internal” when it is bound far more broadly.

Before making changes, take a snapshot. Capture the active listeners, the current ufw status, and the cloud security group rules attached to the instance. These three views together describe how traffic can reach the server, and they give you a stable reference if access changes.

### Binding Risk Table

| Binding | Meaning | Risk |
| :--- | :--- | :--- |
| `127.0.0.1` | Localhost only | Low |
| `10.x.x.x` / `192.168.x.x` | Private network or VPC | Medium |
| `0.0.0.0` | All IPv4 interfaces | High |
| `::` | All IPv6 interfaces | High |

A service bound to localhost does not need a firewall rule. A private binding depends on who can reach that network. A bind to `0.0.0.0` or `::` means the service is exposed on every reachable interface, whether that was intentional or not.

This distinction feeds directly into SSH hardening. Before you enable UFW or tighten rules, you need to know exactly how SSH is bound and which paths can reach it, otherwise the firewall becomes the source of the outage instead of the control.

## How to Prevent SSH Lockouts When Enabling UFW

You prevent SSH lockouts by allowing SSH before UFW is enabled, then turning the firewall on only after you have a confirmed path back in.

UFW enforces rules immediately. If incoming traffic is denied by default and SSH is not already allowed, the server does exactly what it is told and drops management access without hesitation. This is not a corner case. It is the most common failure mode.

The order is what keeps this from happening:

1.  Set defaults to deny incoming and allow outgoing traffic
2.  Add an SSH allow rule
3.  Enable UFW

At the SSH rule step, you have a choice to make. Using the OpenSSH application profile keeps the rule tied to the service itself. A direct port rule works as well, but it is easier to lose the intent later, especially on servers that change ports or get hardened over time.

Once you can reconnect reliably, start narrowing exposure. Restrict SSH to a known IP range, a subnet, or a bastion host, and add rate limiting to reduce credential spraying without changing normal admin behavior. Keep a second SSH session open while making changes so you can verify a new connection before closing the one keeping you in.

This sequence underpins most UFW hardening work. If SSH access is fragile, every other firewall change becomes a gamble instead of a control.

### How to Allow SSH Only Over a VPN or Tunnel Interface (WireGuard, Tailscale, ZeroTier)

You do this by allowing SSH on the tunnel interface and explicitly denying it on the public interface.

First, identify the interfaces in use:

```bash
ip addr
```

Look for the tunnel interface. Common names are `wg0` for WireGuard, or a virtual interface created by Tailscale or ZeroTier. Also note the public interface, often `eth0` or `ens*`.

Then add the UFW rules:

```bash
sudo ufw allow in on wg0 to any port 22
sudo ufw deny in on eth0 to any port 22
```

This allows SSH only where traffic enters through the tunnel and blocks it everywhere else.

Before enabling or reloading UFW:

*   Keep an active SSH session open
*   Confirm the tunnel is up and routing traffic correctly

After applying the rules, test a new SSH connection over the VPN before closing your existing session.

Two common mistakes to check if this fails:
1.  The rule references the wrong interface name, so traffic never matches.
2.  IPv6 is still enabled, and SSH is reachable over `::` on the public interface.

If SSH is reachable but nothing appears in UFW logs, the traffic is likely bypassing UFW entirely, usually due to Docker or cloud security group behavior.

## IPv6 UFW Safety Check: Make Sure IPv6 Firewalling Is Enabled

Before assuming a rule is effective, confirm that UFW is enforcing IPv6 at all. On many Ubuntu servers, IPv6 is enabled at the kernel and interface level, even when no one remembers turning it on.

Check `/etc/default/ufw` and look for `IPV6=yes`. If it is set to `no`, UFW will happily enforce IPv4 rules while IPv6 traffic bypasses them entirely. From the outside, the server looks locked down. In reality, the same services may still be reachable over IPv6.

This matters because binding behavior does not change just because you ignore IPv6. A service bound to `::` or dual stack will accept traffic over IPv6 unless it is explicitly filtered. That includes SSH, admin interfaces, and database ports you thought were private.

This is where people usually screw up IPv6 behavior in Linux firewalls. IPv4 looks correct. UFW status looks correct. The exposure is still there, just on a parallel path that was never inspected.

## How to Configure UFW for a Web Server (HTTP/HTTPS)

On a web server, UFW should allow traffic only to the layer that actually serves the web. Everything else stays closed by default.

Start by deciding what is public on this host. If Nginx or Apache is the public entry point, the firewall rules only need to reflect that fact.

A minimal, explicit setup looks like this:

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 80
sudo ufw allow 443
```

This is enough for a single-interface server where the web service is meant to be public everywhere.

If the server has more than one interface, opening ports globally is usually wrong. In that case, allow web traffic only on the public interface:

```bash
sudo ufw allow in on eth0 to any port 80
sudo ufw allow in on eth0 to any port 443
```

The interface name matters. Use the one traffic actually arrives on.

Where people get into trouble is with reverse proxy setups. The proxy is public. The backend is not. UFW should only allow access to the proxy layer. Backend services should bind to `127.0.0.1` or a private interface and should not have firewall rules at all.

If you expect a site to be reachable and it is not, check three things in order:
1.  The service is listening on the expected address.
2.  The cloud security group allows 80 and 443 to reach the instance.
3.  UFW rules are scoped to the correct interface.

If a service is reachable when it should not be, the usual cause is a broad bind to `0.0.0.0` or `::`, not a missing firewall rule.

## How to Restrict PostgreSQL and MySQL Ports (App Servers Only)

PostgreSQL and MySQL ports should not be public. If a database is reachable from the internet, something upstream already failed.

On app servers, the question is not which port to open. It is who is allowed to talk to the database at all. That answer is usually short.

Valid sources for database access tend to fall into three buckets:
*   An application subnet, where multiple app instances need consistent access.
*   A single host, when the dependency is narrow and tightly scoped.
*   A VPN CIDR or bastion, used only for administration or break-glass access.

Anything outside those paths is noise. Scanners, misrouted traffic, or a service binding wider than intended.

The firewall rule follows naturally from that model. You allow the database port, but only from the specific source that maps to the dependency. There is no “temporary” public access phase. If connectivity testing requires opening the port broadly, the architecture is already off.

The common failure here is not forgetting to add a rule. It is forgetting that databases often bind to all addresses by default. A service listening on `::` can be reachable over IPv6 even when IPv4 rules look correct, which is how “internal only” databases end up exposed without anyone noticing.

Once these rules are in place, they tend to stay stable. App servers do not accumulate random database consumers, and any new source asking for access is usually a design change worth reviewing, not a firewall tweak.

## How to Lock Down Admin Ports and Internal Services

You lock down admin ports by making them unreachable from the public internet, full stop.

Unlike web or SSH, these services are not entry points. They are control surfaces. If they answer on a public interface, they get probed quickly and often automatically, because attackers already know which ports and APIs to look for.

Think about these services as a class, not individually:

| Service type | Typical exposure mistake | Real risk |
| :--- | :--- | :--- |
| Cockpit, Grafana | Left open after install | Auth bypass, data leakage |
| Redis, Elasticsearch | Bound to all interfaces | Remote command or data abuse |
| CI/CD agents | Open for convenience | Lateral movement into builds |

The rule pattern is intentionally boring. Allow access only from a VPN, a bastion host, or an internal interface that never routes to the internet. If a service does not need to be reachable outside that path, there is no exception phase and no temporary rule.

These ports get targeted because they offer leverage. They expose state, credentials, or execution paths that let an attacker move laterally instead of breaking in from scratch. Scanners do not care what your environment looks like. They just wait for something to answer.

This is where UFW logging earns its keep. Once admin services are restricted correctly, any blocked traffic to those ports is usually meaningful. It tells you something is misrouted, misconfigured, or actively probing, and that signal is rare enough to pay attention to.

After this step, these rules tend to stay quiet. If they do not, the problem is usually elsewhere in the network, not in the firewall itself.

## Why Your Container Ports May Be Open Even When UFW Blocks Them

If a container port is reachable even though UFW says it is blocked, Docker is usually the reason. Not because it is broken, but because it gets there first.

Docker inserts its own rules into netfilter when containers start. Those rules can sit ahead of UFW’s chains. Traffic hits Docker’s logic, gets forwarded to the container, and never trips the deny you thought would stop it. From UFW’s point of view, nothing unusual happened.

The easiest way to reason about it is packet order, not tooling:

1.  Internet
2.  `netfilter` (Docker chains)
3.  `netfilter` (UFW chains)
4.  Service or container

Once you internalize that order, the behavior stops feeling mysterious. `ufw status` can look clean. The deny rules are real. The container is still reachable because the decision already happened upstream.

In practice, this leads to a few consistent surprises:
*   UFW rules appear correct, but container ports answer anyway.
*   Publishing a port with Docker widens exposure more than expected.
*   The firewall becomes observational instead of authoritative.

The fix is not adding more UFW rules. It is controlling Docker’s exposure explicitly:
*   Use the `DOCKER-USER` chain to apply allow and deny logic before traffic reaches containers.
*   Use `ufw-docker` only if you understand how it rewires rule order and are willing to own that complexity.
*   Bind published ports to `127.0.0.1` when containers are meant to sit behind a reverse proxy or local service.

Once you treat Docker as its own ingress layer, things line up again. UFW still matters, but it is no longer the first line of defense, and pretending otherwise is where people get burned.

## UFW Rule Order and Precedence

UFW matches the first rule that applies. Anything below that never runs.

Start by looking at the actual evaluation order:

```bash
sudo ufw status numbered
```

This shows rules in the order they are processed. If an allow sits below a broader deny, it will never be hit, even if the rule itself is correct.

When changing rules, operate by number, not by rewriting text:

```bash
sudo ufw delete 3
```

Deleting by rule ID avoids typos and accidental mismatches, which matter more as rulesets grow.

If a rule must take priority, insert it at the top:

```bash
sudo ufw insert 1 allow from <ip> to any port <port>
```

This is how you handle exceptions without reshuffling the entire policy.

Sometimes the ruleset is past saving. This is common on inherited servers with dozens of overlapping rules and no clear intent.

```bash
sudo ufw reset
```

This removes all rules and disables UFW. **Only do this if you can immediately reallow SSH and re-enable UFW.** Keep an active SSH session open, and out-of-band access if possible. Reset is a recovery move, not a cleanup shortcut.

## Troubleshooting UFW

### Why Your Ubuntu Firewall Rules Aren’t Working

When traffic does not behave as expected, it is often blocked outside the host.

Cloud security groups control what reaches the instance. UFW controls what the host accepts. Either can block traffic, and neither reflects the other.

Debug in layers. Check the security group first. Then UFW. Then service bindings. This order aligns with how packets actually move and matches most firewall troubleshooting steps in practice.

### How to Restrict Outbound Traffic (SMTP, Updates, and Data Exfil)

Outbound restrictions matter when a server should not initiate arbitrary connections. Database hosts, internal services, and anything handling sensitive data fall into this category.

Start by flipping the outbound model. By default, UFW allows all outgoing traffic. To restrict it, you have to say that explicitly.

Set the default outbound policy to deny:

```bash
sudo ufw default deny outgoing
```

From there, you selectively add back what the server actually needs.

**Block outbound SMTP to prevent abuse:**
This is the most common first control. It stops compromised hosts from sending spam.

```bash
sudo ufw deny out 25
sudo ufw deny out 465
sudo ufw deny out 587
```

If the server should never send mail, this can stand alone. If it uses a relay, allow only that destination IP instead of reopening the ports globally.

**Allow required outbound dependencies:**
Most servers need a small, predictable set of outbound access:

DNS:
```bash
sudo ufw allow out 53
```

Package repositories:
```bash
sudo ufw allow out 80
sudo ufw allow out 443
```

Backups or monitoring: Allow only the specific destination IP or subnet, not the whole internet.

**Restrict outbound traffic from database servers:**
On database hosts, outbound access is often unnecessary beyond updates and backups. Denying everything else limits data exfiltration if the service is compromised.

This is where testing matters. DNS resolution, package updates, and backup jobs are usually the first things to fail when outbound rules are too tight. Watch those explicitly instead of waiting for alerts.

### How to Audit UFW Rules (Find Stale or Dangerous Rules)

Start with a list you can reason about:

```bash
sudo ufw status numbered
```

Then compare it directly to what is actually listening:

```bash
ss -tulpn
```

Any rule that does not map to a running service is a candidate for removal. Any rule broader than the service binding deserves scrutiny.

Group the remaining rules by service class and add a short comment for ownership or purpose. This is the difference between auditing and guessing.

### Managing UFW Across Multiple Servers: Prevent Drift With Ansible or IaC

If two servers in the same role have different UFW output, drift already exists.

Once that happens, manual CLI changes stop scaling. This is where configuration management earns its keep. Ansible’s `community.general.ufw` module maps cleanly to UFW semantics. Terraform or baked images work as long as the rules are defined once and applied everywhere.

Standardize a small set of patterns. SSH access. Web exposure. Database access. Logging defaults. Audit cadence. When those are fixed, individual rule changes stop being surprises.

### How to Read a UFW Log Entry (SRC, DST, DPT Explained)

A UFW log entry is just one dropped or allowed packet written out in text. You do not need to understand all of it to get value out of it.

A typical line looks roughly like this:

`SRC=203.0.113.5 DST=10.0.0.12 DPT=22 PROTO=TCP`

Read it left to right.

*   `SRC` is the source address. This is who sent the traffic.
*   `DST` is the destination address. This is the IP address of your server that was hit.
*   `DPT` is the destination port. This tells you which service was targeted.
*   `PROTO` shows whether the traffic was TCP or UDP.

If you see a log entry showing a dropped SSH connection from a public IP, that means UFW saw the packet and blocked it. If SSH is supposed to be private, this is expected behavior, and the log is confirming that the rule works.

If SSH is supposed to be reachable and you see dropped log entries for it, then UFW is blocking traffic you intended to allow. In that case, the rule set is wrong or ordered incorrectly.

If traffic reaches a service but you never see any related entries in the UFW log, it usually means the packet never passed through UFW at all. The most common reasons are Docker handling the traffic first, IPv6 traffic bypassing IPv4 rules, or a cloud security group allowing or blocking traffic before it reaches the host.

## UFW Best Practices for Ubuntu Servers

Firewall rules last longer when they explain *why* access is allowed, not just which port is open.

*   **Write rules by service intent:** SSH from a bastion. Web traffic from anywhere. Databases only from app servers. These models survive port changes, IP churn, and tooling swaps.
*   **Reuse the same patterns everywhere:** When every server has custom rules, drift is guaranteed. Shared roles with shared firewall models make exceptions obvious.
*   **Review rules after role changes:** Web nodes become workers. Databases get split. Old access rarely removes itself, and stale rules are how exposure accumulates.
*   **Use logging for investigation, not surveillance:** Enable logging so you can answer questions when something looks wrong. Constant noise just trains people to ignore it.
*   **Always use rule comments:** Keep them short, specific, and tied to ownership or purpose.
    ```bash
    sudo ufw allow from 10.0.0.0/24 to any port 5432 comment "App servers to Postgres"
    ```
    Comments prevent firewall archaeology. If you have to guess why a rule exists, the system has already failed.

## Key Takeaways for Secure SSH, Web, and Database Access

On an Ubuntu server, UFW works when it reflects how the server is actually used, not when it just lists open ports.

The failures are consistent. SSH gets locked out because the rule came after enablement. Containers stay reachable because Docker handles the packet first. IPv6 stays open while IPv4 looks clean. Cloud security groups and UFW disagree, and nobody checks both. Over time, rules pile up and no longer match the services running.

The way through this is practical. Check what is listening before you write rules. Decide where SSH, web traffic, and databases should be reachable from. Apply UFW rules that match that access path, then remove anything that does not map to a running service or a clear owner.

When you treat UFW as a service access control instead of a port list, it holds up as servers change. That is the pattern behind UFW on Linux systems, and it is what keeps firewall rules from quietly becoming irrelevant.

---

### Common Questions

**How do I allow SSH in UFW without getting locked out?**
Covers rule order, defaults, and why enabling UFW before allowing SSH is still the fastest way to lose access.

**How do I allow SSH only from one IP address with UFW?**
Useful when moving from wide access to a bastion or office IP, and where people often forget IPv6.

**How do I open ports 80 and 443 with UFW for Nginx or Apache?**
Walks through profiles vs ports, interface scoping, and why “allowed” does not always mean reachable.

**Should I open PostgreSQL (5432) or MySQL (3306) to the internet?**
Short answer is no. The longer answer explains when people think they need to, and what to do instead.

**Why are Docker container ports open even when UFW blocks them?**
Explains Docker’s place in the packet path and why UFW can look correct while containers stay exposed.
