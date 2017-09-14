#!/usr/bin/env python
import pymysql
import json
import datetime
import sys
from pytz import timezone

city = ""
if len(sys.argv) > 1:
    city = sys.argv[1].replace('_', ' ')

tz = timezone('US/Eastern')

db = pymysql.Connect(host="lines-test.czznmnpo1rs1.us-west-2.rds.amazonaws.com",
                     user="lines_master",
                     password="beaublake",
                     database="lines_test_schema")

cur = db.cursor(pymysql.cursors.DictCursor)
if city:
    cur.execute('SELECT * FROM lines_table_2 WHERE city=' + '"' + city + '"')
else:
    cur.execute("SELECT * FROM lines_table_2")

data =  cur.fetchall()

locations = {}
for rating in data:

    if not locations.get(rating.get('locationName')):
        locations[rating.get('locationName')] = {'recentData':[], 'lastUpdated':[], 'estimated':{}}

    # get ratings within previous 2 hours
    if rating.get('timeDate') > (datetime.datetime.now(tz).replace(tzinfo=None) - datetime.timedelta(hours=2)):
        locations[rating.get('locationName')]['recentData'].append((rating['circleRating'], rating['timeDate']))
        #locations[rating.get('locationName')]['lastUpdated'].append(rating['timeDate'])

    hour = rating['timeDate'].hour
    if not locations[rating.get('locationName')]['estimated'].get(hour):
        locations[rating.get('locationName')]['estimated'][hour] = [rating['circleRating']]
    else:
        locations[rating.get('locationName')]['estimated'][hour].append(rating['circleRating'])


# Then convert to averages

for location, values in locations.iteritems():
    # Current wait:
    if values.get('recentData') and len(values.get('recentData')) > 1:
        ratings = [x[0] for x in values.get('recentData')]
        timeWeights = [x[1] for x in values.get('recentData')]

        timeWeights = [((((datetime.datetime.now(tz).replace(tzinfo=None) - x).seconds / 60)/sum(ratings))/(len(ratings)-1)) for x in timeWeights]
        weightedRatings = [ratings[i] * timeWeights[i] for i in range(0, len(ratings))]

        locations[location]['recent'] = str(sum(ratings)/len(ratings))
        locations[location]['lastUpdated'] = str(max([x[1] for x in values.get('recentData')]))
    elif len(values.get('recentData')) == 1:
        locations[location]['recent'] = str(values.get('recentData')[0][0])
        locations[location]['lastUpdated'] = str(values.get('recentData')[0][1])
    else:
        locations[location]['recent'] = "0"
        locations[location]['lastUpdated'] = ""

    locations[location].pop('recentData')

    # Estimated Wait:
    if values.get('estimated'):
        for hour, vals in values.get('estimated').iteritems():
            locations[location]['estimated'][hour] = str(sum(vals) / len(vals))

# Create array of locations rather than dict
outPutList = []
for name, dicts in locations.iteritems():
    newLoc = {}
    newLoc['locationName'] = name
    for k, v in dicts.iteritems():
        newLoc[k] = v
    outPutList.append(newLoc)

print outPutList
