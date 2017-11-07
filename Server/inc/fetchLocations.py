#!/usr/bin/env python
import pymysql
import json
import datetime
import sys
from pytz import timezone

tz = timezone('US/Eastern')

db = pymysql.Connect(host="lines-test.czznmnpo1rs1.us-west-2.rds.amazonaws.com",
                     user="lines_master",
                     password="beaublake",
                     database="lines_test_schema")

cur = db.cursor(pymysql.cursors.DictCursor)

cur.execute("SELECT DISTINCT city FROM lines_table_2")

data =  cur.fetchall()
cities = []
for c in data:
    if c.get('city'):
        cities.append(c.get('city'))

print cities
