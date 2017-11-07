#!/usr/bin/env python
import pymysql
import json
import datetime
import math
from pytz import timezone
tz = timezone('US/Eastern')


def getLinearWeightedAverage(ratingData):
    #ratingData looks like [(2, datetime.datetime(2017, 7, 20, 15, 31, 34)), (3, datetime.datetime(2017, 7, 20, 15, 31, 48))]
    ratings = [float(x[0]) for x in ratingData]
    timeDiffs = [float((datetime.datetime.now(tz).replace(tzinfo=None) - x[1]).seconds / 60) for x in ratingData]
    timeSum = sum(timeDiffs)
    weights = [(((timeSum - timeDiffs[i]) / timeSum) / (len(ratings)-1)) for i in range(0, len(ratings))]
    weightedValues = [ratings[i] * weights[i] for i in range(0, len(ratings))]
    return int(round(sum(weightedValues)))


db = pymysql.Connect(host="lines-test.czznmnpo1rs1.us-west-2.rds.amazonaws.com",
                     user="lines_master",
                     password="beaublake",
                     database="lines_test_schema")

cur = db.cursor(pymysql.cursors.DictCursor)

cur.execute("SELECT * FROM lines_table_2")

data =  cur.fetchall()

locations = {}
for rating in data:

    if not locations.get(rating.get('locationName')):
        locations[rating.get('locationName')] = {'recentData':[], 'lastUpdated':[], 'estimated':{}}

    # get ratings within previous 2 hours
    if rating.get('timeDate') > (datetime.datetime.now(tz).replace(tzinfo=None) - datetime.timedelta(hours=2)):
        locations[rating.get('locationName')]['recentData'].append((rating['circleRating'], rating['timeDate']))

    hour = rating['timeDate'].hour
    if not locations[rating.get('locationName')]['estimated'].get(hour):
        locations[rating.get('locationName')]['estimated'][hour] = [rating['circleRating']]
    else:
        locations[rating.get('locationName')]['estimated'][hour].append(rating['circleRating'])


# Then convert to averages

for location, values in locations.iteritems():
    # Current wait:
    if values.get('recentData') and len(values.get('recentData')) > 1:
        weightedRating = getLinearWeightedAverage(values.get('recentData'))

        locations[location]['recent'] = str(weightedRating)
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

# Return data for app to read
print json.dumps(locations)

