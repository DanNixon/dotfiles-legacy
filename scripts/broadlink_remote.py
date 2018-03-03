#!/usr/bin/env python3

from base64 import b64decode
import click
import broadlink
import yaml


def find_device(timeout):
    click.echo('Discovering devices...')
    devices = broadlink.discover(timeout=timeout)

    if devices:
        click.echo('Found {} device(s)'.format(len(devices)))
        if len(devices) == 1:
            return devices[0]
        else:
            # TODO: pick device
            pass
    else:
        raise RuntimeError('Could not find any devices')


@click.command()
@click.option('--timeout', default=5, help='Device discovery timeout in seconds')
@click.argument('data_file', type=click.File('r'))
def main(timeout, data_file):
    device = find_device(timeout)
    device.auth()
    click.echo('Device: {}'.format(device))

    data = yaml.load(data_file)

    while True:
        cmd = input('cmd> ')
        if cmd in data:
            d = b64decode(data[cmd])
            device.send_data(d)
        else:
            click.echo('No such command!')


if __name__ == '__main__':
    main()
