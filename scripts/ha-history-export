#!/usr/bin/env python3

import click
import requests


def extract_time_series(item):
    points = []
    for i in item:
        points.append((i['last_changed'], i['state']))
    return points


def extract_metadata(item):
    return {
        'entity_id': item[0]['entity_id'],
        'name': item[0]['attributes'].get('friendly_name'),
        'unit_of_measurement': item[0]['attributes'].get('unit_of_measurement'),
    }


def output_delimited_data(delim, data):
    for i in data:
        click.echo(delim.join(i))


def output_delimited_time_series(delim, data):
    for i in data:
        meta = extract_metadata(i)
        click.echo('# ' + str(meta))

        time_series = extract_time_series(i)
        output_delimited_data(delim, [('Timestamp', 'State')])
        output_delimited_data(delim, time_series)


@click.command()
@click.option('--url', type=str,
              help='URL of Home Assistant instance')
@click.option('--token', type=str,
              help='Home Assistant access token')
@click.option('--tsv', 'output_format', flag_value='tsv', default=True,
              help='Output TSV formatted time series.')
@click.option('--csv', 'output_format', flag_value='csv', default=False,
              help='Output CSV formatted time series.')
@click.option('--json', 'output_format', flag_value='json', default=False,
              help='Output raw JSON from API request')
@click.option('--time-from', type=str,
              help='Start of time range (in format YYYY-MM-DDThh:mm:ssTZD, defaults to one day earlier)')
@click.option('--time-to', type=str,
              help='End of time range (in format YYYY-MM-DDThh:mm:ssTZD, defaults to now)')
@click.argument('entity_id', nargs=-1)
def main(url, token, time_from, time_to, output_format, entity_id):
    """
    Export data from Home Assistant.
    """
    url += '/api/history/period'
    if time_from:
        url += '/' + time_from

    response = requests.get(
        url,
        headers={
            'Authorization': 'Bearer ' + token,
            'content-type': 'application/json',
        },
        params={
            'filter_entity_id': ','.join(entity_id),
            'end_time': time_to,
        },
    )

    if output_format == 'json':
        click.echo(response.text)
    elif output_format == 'csv':
        output_delimited_time_series(',', response.json())
    else:
        output_delimited_time_series('\t', response.json())


if __name__=='__main__':
    main(auto_envvar_prefix='HA_HISTORY_EXPORT')
