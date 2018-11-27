#!/usr/bin/env python
#-*- coding: utf-8 -*-

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

"""
This is a modified version of this script: https://gist.github.com/bitmorse/5201491
Script for exporting tracks through the last.fm API.
Usage: lastexport.py -u USERNAME [-p STARTPAGE]
"""

import urllib2, urllib, sys, time, re, math, os
import xml.etree.ElementTree as ET
from optparse import OptionParser

__version__ = '0.0.4'

def get_options(parser):
  """ Define command line options."""
  parser.add_option("-u", "--username", dest="username", default=None,
    help="last.fm username.")
  parser.add_option("-p", "--startpage", dest="startpage", default=1,
    help="Startpage (default = 1).")
  parser.add_option("-t", "--starttime", dest="starttime", default=0,
    help="Only fetch scrobbles after this UNIX timestamp (default = 0).")

  options, args = parser.parse_args()

  if not options.username:
    sys.exit("Username not specified, see --help")

  return options.username, options.starttime, options.startpage

def connect_server(username, starttime=0, startpage=1, sleep_func=time.sleep):
    # Put from parameter directly in string, since 'from' is a keyword in
    # Python, and using it as variable name in dictionary doesn't work
    baseurl = 'http://ws.audioscrobbler.com/2.0/?from={}&'.format(starttime)
    urlvars = dict( method='user.getrecenttracks',
                    api_key='e38cc7822bd7476fe4083e36ee69748e',
                    user=username,
                    page=startpage,
                    limit=200)

    url = baseurl + urllib.urlencode(urlvars)
    for interval in (1, 5, 10, 62, 240):
        try:
            f = urllib2.urlopen(url)
            break
        except Exception, e:
            last_exc = e
            print "Exception occured, retrying in {}s: {}".format(interval, e)
            sleep_func(interval)
    else:
        print "Failed to open page {}".format(urlvars['page'])
        raise last_exc

    response = f.read()
    f.close()

    # Bad hack to fix bad xml
    response = re.sub('\xef\xbf\xbe', '', response)
    return response

def get_pageinfo(response):
    """Check how many pages of tracks the user have."""
    xmlpage = ET.fromstring(response)
    totalpages = xmlpage.find('recenttracks').attrib.get('totalPages')
    return int(totalpages)

def get_tracklist(response):
    """Read XML page and get a list of tracks and their info."""
    xmlpage = ET.fromstring(response)
    tracklist = xmlpage.getiterator('track')
    return tracklist

def parse_track(track):
    """Extract info from every track entry and output to list."""
    if track.find('artist').getchildren():
        # Artist info is nested in loved/banned tracks xml
        artistname = track.find('artist').find('name').text
        artistmbid = track.find('artist').find('mbid').text
    else:
        artistname = track.find('artist').text
        artistmbid = track.find('artist').get('mbid')

    if track.find('album') is None:
        # No album info for loved/banned tracks
        albumname = ''
        albummbid = ''
    else:
        albumname = track.find('album').text
        albummbid = track.find('album').get('mbid')

    trackname = track.find('name').text
    trackmbid = track.find('mbid').text
    date = track.find('date').get('uts')

    output = [date, trackname, artistname, albumname, trackmbid, artistmbid, albummbid]

    for i, v in enumerate(output):
        if v is None:
            output[i] = ''

    return output

def write_tracks(tracks, outfileobj):
    """Write tracks to an open file"""
    for fields in tracks:
        outfileobj.write(("\t".join(fields) + "\n").encode('utf-8'))

def get_tracks(username, starttime, startpage, sleep_func=time.sleep):
    page = startpage
    response = connect_server(username, starttime, page, sleep_func)
    totalpages = get_pageinfo(response)
    print 'Fetching {} pages with tracks...'.format(totalpages)

    if startpage > totalpages:
        raise ValueError("First page ({}) is higher than total pages ({}).".format(startpage, totalpages))

    while page <= totalpages:
        # Skip connect if on first page, already have that one stored.
        if page > startpage:
            response =  connect_server(username, starttime, page, sleep_func)

        tracklist = get_tracklist(response)
    
        tracks = []
        for track in tracklist:
            # Don't export the currently playing track as it doesn't have date
            if not track.attrib.has_key("nowplaying") or not track.attrib["nowplaying"]:
                tracks.append(parse_track(track))

        yield page, totalpages, tracks

        page += 1
        sleep_func(0.3)

def update_progress(progress):
    temp = '[ {}'.format('#'*(progress)).ljust(100)
    sys.stdout.write('\r{} ] {}%'.format(temp, progress))
    if progress == 100:
        sys.stdout.write('\n')

def main(username, starttime=0, startpage=1, dataPath='data'):
    trackdict = dict()
    page = startpage  # For case of exception
    totalpages = -1  # Ditto
    n = 0

    outfile = '{}.txt'.format(username)

    try:
        for page, totalpages, tracks in get_tracks(username, starttime, startpage):
            update_progress(100*page/totalpages)
            for track in tracks:
                trackdict.setdefault(track[0], track)

            sys.stdout.flush()
    except ValueError, e:
        exit(e)
    except Exception:
        raise
    finally:
        if not os.path.exists(dataPath):
            os.makedirs(dataPath)

        with open(os.path.join(dataPath, outfile), 'a') as outfileobj:
            tracks = sorted(trackdict.values())
            write_tracks(tracks, outfileobj)
            print "Wrote page {}-{} of {} to {}".format(startpage, page, totalpages, os.path.join(dataPath, outfile))

if __name__ == "__main__":
    parser = OptionParser()
    username, starttime, startpage = get_options(parser)
    main(username, starttime, startpage)
