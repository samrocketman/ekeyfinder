#!/usr/bin/env python
'''
  Created by Sam Gleske
  Created 02-28-2011 (mm-dd-yyyy)
  MIT License (http://www.opensource.org/licenses/mit-license.php)
  
  This python script parses mediawiki xml schema exported from the
  MediaWiki wiki interface (admin function).  During parsing it
  utilizes documentation.py to generate html documentation.
  
  Generate the wikixml file using only latest revisions without 
  history.
  
  Why did I do this?  Because I'm awesome and lazy.
  
  Usage: ./wikidoc.py
  will generate all the html files needed for the chm to compile
'''
import re,sys,os.path
from documentation import *

#here's some cross platform settings
htm_ext = ".html"

if __name__ == '__main__':
    #necessary regular expressions, parsing xml quick and dirty
    page_regex = re.compile(r'<page>(.*?)</page>', re.MULTILINE|re.DOTALL)
    wikidoc_regex = re.compile(r'<text.*?>(.*?)</text>', re.MULTILINE|re.DOTALL)
    
    f=open("documentation/wikidoc.xml", 'r')
    wikixml = f.read()
    f.close()
    hits = re.findall(page_regex, wikixml)
    #print hits[0]
    for hit in hits:
        title = re.findall(r'<title>(.*?)</title>',hit)[0]
        wikidoc = re.findall(wikidoc_regex,hit)[0]
        htmlfile = title.replace(" ","_").lower() + htm_ext
        myobj = PageFormatter(wikidoc,title)
        f=open(htmlfile,'w')
        f.write(myobj.htmloutput())
        f.close()
        print "Generated:",htmlfile