#!/usr/bin/env python3

import click
import pychromecast
# from pychromecast.controllers.youtube import YouTubeController
import os
import sys
import time


# yt = YouTubeController()
# cast.register_handler(yt)
# yt.play_video('L43bArxyszU')


@click.group()
@click.pass_context
def cli(ctx):
    ctx.ensure_object(dict)

    host = os.environ.get('CHROMECAST_HOST')
    if not host:
        click.echo('CHROMECAST_HOST not set')
        sys.exit(1)

    ctx.obj['cast'] = pychromecast.Chromecast(host)

    ctx.obj['cast'].start()
    time.sleep(0.5)


@cli.command()
@click.pass_context
def status(ctx):
    cast = ctx.obj['cast']
    click.echo(cast.status)


@cli.command()
@click.pass_context
def pause(ctx):
    cast = ctx.obj['cast']
    cast.media_controller.pause()


@cli.command()
@click.pass_context
def play(ctx):
    cast = ctx.obj['cast']
    cast.media_controller.play()


@cli.command()
@click.pass_context
def stop(ctx):
    cast = ctx.obj['cast']
    cast.media_controller.stop()


@cli.group()
def app():
    pass


@app.command()
@click.pass_context
def quit(ctx):
    cast = ctx.obj['cast']
    cast.quit_app()


if __name__ == "__main__":
    cli()
