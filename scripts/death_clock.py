#!/usr/bin/env python3

import datetime
import dateutil.relativedelta as rd
import click


@click.command()
@click.argument('birthday', type=str)
@click.argument('life_expectancy', type=int)
def main(birthday, life_expectancy):
    birthday = datetime.datetime.strptime(birthday, "%Y-%m-%d")
    life_expectancy = rd.relativedelta(years=life_expectancy)

    now = datetime.datetime.now()

    age = rd.relativedelta(now, birthday)
    click.echo("{} years, {} days".format(age.years, age.days))

    remaining = life_expectancy - age
    click.echo("{} years, {} days remaining".format(remaining.years,
                                                    remaining.days))


if __name__ == "__main__":
    main()
