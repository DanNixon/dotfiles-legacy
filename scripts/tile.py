#!/usr/bin/env python3

import asyncio
import json
from datetime import datetime

import click
import requests
from aiohttp import ClientSession
from pytile import Client
from pytile.errors import TileError


def osm_address_lookup(latitude, longitude):
    """
    Performs a reverse geocode (address lookup given a latitude and longitude.
    See https://wiki.openstreetmap.org/wiki/Nominatim#Reverse_Geocoding for API details.
    """
    a = requests.get("https://nominatim.openstreetmap.org/reverse", params={
        "format": "jsonv2",
        "lat": latitude,
        "lon": longitude,
    })
    return a.json()["display_name"] if a.ok else None


class ReverseGeocode(object):
    """
    Used to cache reverse goeocode lookups.
    As Tiles may travel together they may have the same reported GPS
    coordinates, this class prevents redundant API calls in this case.
    """

    def __init__(self):
        self._cache = {}

    def lookup(self, latitude, longitude):
        if (latitude, longitude) in self._cache:
            return self._cache[(latitude, longitude)]
        return self._query_and_cache(latitude, longitude)

    def _query_and_cache(self, latitude, longitude):
        result = osm_address_lookup(latitude, longitude)
        if result is None:
            return None
        self._cache[(latitude, longitude)] = result
        return result


reverse_geocode = ReverseGeocode()


async def get_tiles(username, password, show_inactive):
    """
    Gets a list of the users Tiles.
    """
    async with ClientSession() as websession:
        try:
            client = Client(username, password, websession)
            await client.async_init()

            return await client.tiles.all(show_inactive=show_inactive)

        except TileError as e:
            click.echo(e)


def map_url(latitude, longitude, zoom=20):
    """
    Gets a map URL showing a position described by a latitude and longitude.
    """
    return "https://www.openstreetmap.org/#map={}/{}/{}".format(zoom, latitude, longitude)


def pretty_print_tiles(tiles):
    """
    Outputs the list of Tiles in a user friendly manner.
    """
    for tile in tiles:
        state = tile["tileState"]
        state_timestamp = datetime.fromtimestamp(float(state["timestamp"]) / 1000)

        click.echo(tile["name"])
        click.echo(state_timestamp.ctime())
        click.echo(reverse_geocode.lookup(state["latitude"], state["longitude"]))
        click.echo(map_url(state["latitude"], state["longitude"]))
        click.echo("Accuracy: {:.1f} (m?)".format(state["h_accuracy"]))

        click.echo()


@click.command()
@click.option("--username", prompt=True, required=True)
@click.option("--password", hide_input=True, prompt=True, required=True)
@click.option("--json", "output_json", is_flag=True)
@click.option("--all", "show_all", is_flag=True)
def main(username, password, output_json, show_all):
    tiles = asyncio.get_event_loop().run_until_complete(get_tiles(username, password, show_all))
    if output_json:
        print(json.dumps(tiles))
    else:
        pretty_print_tiles(tiles)


if __name__ == "__main__":
    main()
