# $OO_USER_CONFIG/user/Scripts/python/projektzeiten.py

# Beispiel ~/zeit.txt:
#
# pro1     Projekt Eins
# pro2     Projekt Zwei
# pro3     Projekt Drei
# ======================
# 2011-08-10    2.5     pro1      sonstige info
# 2011-08-10    1.5     pro2      bla bla
#
# 2011-08-11    2       pro3
# 2011-08-11    4       pro1      mehr info...
#

import os, re, datetime

def sourcefile():
    return os.environ['HOME'] + '/zeit.txt'

def datefromisostr (datestr):
    assert len (datestr) == len ("yyyy-mm-dd")
    return datetime.date (int (datestr[:4]), int (datestr[5:7]), int (datestr[8:10]))

def readdata (srcfile):
    fi = open (srcfile, 'r')
    
    mappings = {}
    for line in fi:
        x = re.match (r'(\S+)\s+(.+)', line.strip())
        if x:
            (alias, name) = x.group (1, 2)
            mappings[alias] = name
        else:
            break
    
    weeks = {}
    for line in fi:
        x = re.match (r'([0-9]{4}-[0-9]{2}-[0-9]{2})\s+([0-9,.]+)\s+(\S+)\s*(.*)', line)
        if x:
            (date, hours, project, info) = x.group (1, 2, 3, 4)
            week = datefromisostr (date).isocalendar()[1]
            hours = hours.replace (',', '.')
            project = mappings[project]
            if not week in weeks: weeks[week] = {}
            if not project in weeks[week]: weeks[week][project] = 0.0
            weeks[week][project] += float (hours)

    return weeks

def findrow (sheet, name):
    row = 2
    while True:
        cell = sheet.getCellByPosition (0, row)
        content = cell.getString().strip()
        if content == name.strip():
            return row
        if len (content) == 0:
            raise Exception ('Zeile nicht gefunden: "' + name + '"')
        row += 1

def insert_last_week():
    weeks = readdata (sourcefile())
    lastweek = max (weeks.keys())

    doc = XSCRIPTCONTEXT.getDocument()
    sheet = doc.getSheets().getByName ('Tabelle1')

    for (project, hours) in weeks[lastweek].items():
        row = findrow (sheet, project)
        cell = sheet.getCellByPosition (lastweek + 1, row)
        cell.setValue (hours)
