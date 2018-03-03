#!/usr/bin/env python3

from base64 import b64encode
import time
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


def learn_code(device, name):
    click.echo('Learning: {}'.format(name))
    data = None
    device.enter_learning()
    while data is None:
        time.sleep(1)
        data = device.check_data()
    data = b64encode(data).decode('utf8')
    return (name, data)


@click.command()
@click.option('--timeout', default=5, help='Device discovery timeout in seconds')
@click.option('--learn', '-l', multiple=True, help='Name of commands to learn')
@click.argument('output', type=click.File('w'))
def main(timeout, learn, output):
    device = find_device(timeout)
    device.auth()
    click.echo('Device: {}'.format(device))

    data = dict([learn_code(device, n) for n in learn])

    output.write(yaml.dump(data, default_flow_style=False))


if __name__ == '__main__':
    main()
