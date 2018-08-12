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
    parser = configparser.ConfigParser()
    # Disable default `configparser` converting keys to lowercase
    parser.optionxform = str
    parser.read(config_filename)
    keys = dict(date=parser['DEFAULT']['DateKey'],
                amount=parser['DEFAULT']['AmountKey'],
                description=parser['DEFAULT']['DescriptionKey'],
                to_account=parser['DEFAULT']['ToAccountKey'],
                from_account=parser['DEFAULT']['FromAccountKey'])
    from_account_translations = {}
    for key in parser['FromAccountTranslations']:
        from_account_translations[key] = parser['FromAccountTranslations'][key]
    return dict(keys=keys,
                from_account_translations=from_account_translations)


def generate_output(filename, config):
    """Translate the CSV to Ledger and output the result"""
    file_object = open(filename) if filename is not None else sys.stdin
    reader = csv.DictReader(file_object)
    for row in reader:
        # Keys
        keys = config['keys']
        date = row[keys['date']]
        amount = row[keys['amount']]
        description = row[keys['description']]
        to_account = row[keys['to_account']]
        from_account = row[keys['from_account']]
        # Translations
        from_account_translations = config['from_account_translations']
        from_account = from_account_translations[
            from_account] if from_account in from_account_translations else from_account
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
