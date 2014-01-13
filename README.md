# Docker with preconfigured Supervisor 3.0

## supervisor

[Supervisor] is a process manager.  Seems pretty popular with the Docker kids.

To add your own programs, just put their `.conf` files in `/etc/supervisor.d/`.

## remote shell

`sshd` is listening on port 22.  The password's in `src/setup.sh` and is quite
obvious.

I'd initially intended to use [wsh], but I ran into [#3385].

## other bloat

`crond` and `rsyslog` are both provided in this image.  I'd not intended to run
these, but I've decided to let each container manage its own backups and other
automated tasks.  As a result, `/var/log` needs to be minded.  It's not flagged
as a volume in Dockerfile, which leaves it up to the user to map a volume with
`-v` if the contents are meaningful; otherwise they'll be removed when the
container is culled.

[Supervisor]: http://supervisord.org/
[wsh]: https://github.com/chenyf/wsh
[#3385]: https://github.com/dotcloud/docker/issues/3385
