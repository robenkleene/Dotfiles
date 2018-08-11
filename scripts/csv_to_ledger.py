#!/usr/bin/env python3

"""This module converts `csv` to `ledger`."""

import sys
import csv
import argparse
import configparser

LINE_LENGTH = 50
WHITESPACE_INDENT_LENGTH = 2
WHITESPACE_INDENT = ' ' * WHITESPACE_INDENT_LENGTH

def main():
    """main"""
    # Command-Line Options
    parser = argparse.ArgumentParser()
    parser.add_argument('-c', '--config', help='Configuration file', required=True)
    parser.add_argument('filename', nargs='?')
    args = parser.parse_args()
    filename = args.filename
    config_filename = args.config

    # Config
    config = configparser.ConfigParser()
    config.read(config_filename)
    date_key = config['DEFAULT']['DateKey']
    amount_key = config['DEFAULT']['AmountKey']
    description_key = config['DEFAULT']['DescriptionKey']
    to_account_key = config['DEFAULT']['ToAccountKey']
    from_account_key = config['DEFAULT']['FromAccountKey']

    # `csv` to `ledger`
    file_object = open(filename) if filename is not None else sys.stdin
    reader = csv.DictReader(file_object)
    for row in reader:
        # Keys
        date = row[date_key]
        amount = row[amount_key]
        description = row[description_key]
        to_account = row[to_account_key]
        from_account = row[from_account_key]
        # Whitespace
        whitespace_length = LINE_LENGTH - len(to_account) - len(amount) - WHITESPACE_INDENT_LENGTH
        whitespace_length = whitespace_length if whitespace_length > 0 else 1
        whitespace_alignment = ' ' * whitespace_length
        # Output
        print("%s %s" % (date, description))
        print("%s%s%s$%s" % (WHITESPACE_INDENT, to_account, whitespace_alignment, amount))
        print("%s%s" % (WHITESPACE_INDENT, from_account))
        print('')

if __name__ == "__main__":
    main()
