# Docker with preconfigured Supervisor 3.0

## supervisor

[Supervisor] is a process manager.  Seems pretty popular with the Docker kids.

To add your own programs, just put their `.conf` files in `/etc/supervisor.d/`.

## remote shell

`EXPOSE`s a shell via port 14000 that you can connect to with `[socat]`.  For
example:

    socat -,raw,echo=0 TCP4:localhost:$PORT_14000

Bada bing, bada boom, you're running a `bash` shell as root in the container.
Yes, `openssh-server` would be more secure, but this should only be opened to
the host, which presumably you already trust pretty thoroughly.  This should
also be lighter-weight than sshd.

Some might call this a massive back door, others call it damn useful.

I'd initially intended to use [wsh], but I ran into [#3385].

[socat]: http://www.dest-unreach.org/socat/
[Supervisor]: http://supervisord.org/
[wsh]: https://github.com/chenyf/wsh
[#3385]: https://github.com/dotcloud/docker/issues/3385
