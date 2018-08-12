#!/usr/bin/env python3

"""This module converts `csv` to `ledger`."""

import sys
import csv
import argparse
import configparser

LINE_LENGTH = 50
WHITESPACE_INDENT_LENGTH = 2
WHITESPACE_INDENT = ' ' * WHITESPACE_INDENT_LENGTH


def get_parameters():
    """Return the parameters."""
    parser = argparse.ArgumentParser()
    parser.add_argument(
        '-c',
        '--config',
        help='Configuration file',
        required=True)
    parser.add_argument('filename', nargs='?')
    args = parser.parse_args()
    return args.filename, args.config


def get_config(config_filename):
    """Return keys from the config."""
    config = configparser.ConfigParser()
    config.read(config_filename)
    return dict(date=config['DEFAULT']['DateKey'],
                amount=config['DEFAULT']['AmountKey'],
                description=config['DEFAULT']['DescriptionKey'],
                to_account=config['DEFAULT']['ToAccountKey'],
                from_account=config['DEFAULT']['FromAccountKey'])

def generate_output(filename, config):
    """Translate the CSV to Ledger and output the result"""
    file_object = open(filename) if filename is not None else sys.stdin
    reader = csv.DictReader(file_object)
    for row in reader:
        # Keys
        date = row[config['date']]
        amount = row[config['amount']]
        description = row[config['description']]
        to_account = row[config['to_account']]
        from_account = row[config['from_account']]
        # Whitespace
        whitespace_length = LINE_LENGTH - \
            len(to_account) - len(amount) - WHITESPACE_INDENT_LENGTH
        whitespace_length = whitespace_length if whitespace_length > 0 else 1
        whitespace_alignment = ' ' * whitespace_length
        # Output
        print("%s %s" % (date, description))
        print(
            "%s%s%s$%s" %
            (WHITESPACE_INDENT,
             to_account,
             whitespace_alignment,
             amount))
        print("%s%s" % (WHITESPACE_INDENT, from_account))
        print('')

def main():
    """main"""
    # Get Parameters
    filename, config_filename = get_parameters()

    # Get Config
    config = get_config(config_filename)

    # Generate Output
    generate_output(filename, config)

if __name__ == "__main__":
    main()
