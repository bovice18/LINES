#!/usr/bin/env python
import pymysql

import sys
from pytz import timezone

tz = timezone('US/Eastern')

if len(sys.argv) < 4:
    print "INPUT ERROR"
    quit()

location = sys.argv[1]
rating = sys.argv[2]
date = sys.argv[3]

cityDict = {'Pussers': 'Annapolis',
            'Acme': 'Annapolis',
            'McGarveys': 'Annapolis',
            'Dock Street': 'Annapolis',
            'Armadillos': 'Annapolis',
            'Federal House': 'Annapolis',
            'Bentleys': 'College Park',
            'Terrapins Turf': 'College Park',
            'Cornerstone': 'College Park'}

if not cityDict.get(location):
    print "Unknown Location"
    quit()

db = pymysql.Connect(host="lines-test.czznmnpo1rs1.us-west-2.rds.amazonaws.com",
                     user="lines_master",
                     password="beaublake",
                     database="lines_test_schema")

cur = db.cursor(pymysql.cursors.DictCursor)
exStr = "INSERT INTO lines_table_2 (locationName, circleRating, timeDate, city)" \
        " VALUES (" + \
            '"' + location + '",' + \
            '"' + rating + '",' + \
            '"' + date + '",' + \
            '"' + cityDict[location] + '"' + ')'
print exStr
cur.execute(exStr)
db.commit()

quit()
