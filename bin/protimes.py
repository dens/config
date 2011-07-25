#!/usr/bin/python

import sys, csv, datetime

if len (sys.argv) != 2:
    print "usage: %s CSV-FILE" % sys.argv[0]
    exit()

def datefromisostr (datestr):
    assert len (datestr) == len ("yyyy-mm-dd")
    return datetime.date (int (datestr[:4]), int (datestr[5:7]), int (datestr[8:10]))

month = map (lambda row: [datefromisostr (row[0]).isocalendar()[1]] + row[1:],
             csv.reader (open (sys.argv[1], 'rb'), delimiter = ',', quotechar = '"'))
weeks = {}
maxwidth = 0

for m in month:
    week, project, hour, minute = m[:4]
    if len (project) > maxwidth: maxwidth = len (project)
    if not week in weeks: weeks[week] = {}
    if not project in weeks[week]: weeks[week][project] = 0
    weeks[week][project] += int (hour) * 60 + int (minute)

for week, projects in weeks.items():
    print "Woche %i:" % week
    for p, t in sorted (projects.items()):
        print " %*s: %5.2f" % (maxwidth, p, t / 60.0)
    print
