#!/usr/bin/env python

import argparse,csv,datetime,json,os,re,stat,sys,time
import pandas as pd


arg_parser = argparse.ArgumentParser(description='prog_descrip')
arg_parser.add_argument('-c','--csv_file', nargs='?', action='store', required=True, type=os.path.abspath,
                            help=('Path to ptseries .csv FILE. (/PATH/TO/exported.csv)'),
                            dest='csv_file'
                           )
args = arg_parser.parse_args()

print os.path.isfile(args.csv_file)

csv = pd.read_csv(args.csv_file,header=None,index_col=None)

print csv

csv = csv.T

csv.to_csv((args.csv_file), index=False, header=False)