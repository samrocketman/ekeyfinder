#!/usr/bin/env python
'''
  Created by Sam Gleske
  Created 02-28-2011 (mm-dd-yyyy)
  
  This python script takes MediaWiki wiki documentation and 
  generates simple html output.  This was designed so that I could 
  use a single style sheet and generate documentation for all of 
  Enchanted Keyfinder to a format to compile into a chm format.
  
  This makes less work for me for generating documentation for each
  version of Enchanted Keyfinder.
  
  Why did I do this?  Because I'm awesome and lazy.
  
  Instructions:
    1. Go to each wiki page and edit it.
    2. Create a text file with the name based on the page title of 
       the html file you wish to generate.  Eg. "Title of Page.txt"
    3. Copy the contents of the wiki page into the text file.
    4. Make sure each wiki text file is located in the same folder.
       This is designed to have no folders and unique file names.
    5. Generate html pages from the Usage below.
  
  Usage: ./PageFormatter.py "Title of Page.txt"
  will generate title_of_page.html
  
  Usage for Bash or Cygwin: 
  find . -type f -name '*.txt' -print0 | xargs -0 ./PageFormatter.py
  will generate html documentation for all text files
'''
import re,sys,os.path,string

#here's some cross platform settings
htm_ext = ".html"
#this way changing what type of file is parsed and generated is easy.  Whether EOL be Windows (\r\n), Unix (\n), or Mac (\r).
NEW_LINE = "\r\n" #this is the EOL format of the generated docs
INPUT_NEW_LINE = "\n" #this is the EOL format of the input documents

class PageFormatter:
    '''
      This object takes a page title and raw MediaWiki input and is
      capable of generating simple html output.
      
      Usage:
        myobj = PageFormatter("= Wiki Input =","title of page")
        print myobj.htmloutput()
    '''
    pre_open = False
    p_open = False
    table_open = False
    th_written = False #this switches on and off per table
    ul_open = False
    ol_open = False
    output = ""
    headregex = re.compile(r"^=.*")
    h1regex = re.compile(r"^(= )(.*)( =).*")
    h2regex = re.compile(r"^(== )(.*)( ==).*")
    h3regex = re.compile(r"^(=== )(.*)( ===).*")
    coderegex = re.compile(r"^ (.*)")
    blanklineregex = re.compile(r"^$")
    tableregex = re.compile(r"^\{\|.*|^\|\}|^\|(.*)|^!.*\|(.*)")
    tableheadregex = re.compile(r"^!.*\|(.*)")
    tablecellregex = re.compile(r"^\|(.*)")
    ulregex = re.compile(r"^\* .*")
    olregex = re.compile(r"^# .*")
    def __init__(self, raw, pagetitle): #Initiate object
        self.raw = raw
        self.openhtml(pagetitle)
    def openhtml(self,pagetitle):
        self.output += "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">" + NEW_LINE
        self.output += "<html xmlns=\"http://www.w3.org/1999/xhtml\">" + NEW_LINE + "<head>" + NEW_LINE
        self.output += "<title>" + pagetitle + "</title>" + NEW_LINE
        self.output += "<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" />" + NEW_LINE
        self.output += "<meta http-equiv=\"content-language\" content=\"en\" />" + NEW_LINE
        self.output += "<link rel=\"stylesheet\" href=\"style/style.css\" />" + NEW_LINE
        self.output += "</head>" + NEW_LINE + "<body>" + NEW_LINE
    def closehtml(self):
        self.output += "</body>" + NEW_LINE + "</html>" + NEW_LINE
    def closealltags(self):
        if self.pre_open:
            self.pre_open = False
            self.output += "</pre>" + NEW_LINE
        if self.p_open:
            self.p_open = False
            self.output += "</p>" + NEW_LINE
        if self.table_open:
            self.table_open = False
            self.th_written = False
            self.output += "  </tr>" + NEW_LINE + "</table>" + NEW_LINE
        if self.ul_open:
            self.ul_open = False
            self.output += "</ul>" + NEW_LINE
        if self.ol_open:
            self.ol_open = False
            self.output += "</ol>" + NEW_LINE
    def wiki_inline_replace(self,line):
        if __name__ == '__main__':
            line = re.sub(r"&",r"&amp;",line) #replace all & with &amp;
            line = re.sub(r" > ",r" &gt; ",line) #replace all > with &gt;
            line = re.sub(r" < ",r" &lt; ",line) #replace all < with &lt;
        line = re.sub(r"'''(.*?)'''",r"<b>\1</b>",line) #replace wiki formatting for bold
        line = re.sub(r"''(.*?)''",r"<em>\1</em>",line) #replace wiki formatting for italic
        line = re.sub(r"\[\[Category:.*?\]\]",r"",line) #remove wiki categories
        line = re.sub(r"\[\[File:(.*?)\|.*?\]\]",r'<img src="style/\1" alt="\1" />',line) #replace wiki images
        line = re.sub(r"\[\[File:(.*?)\]\]",r'<img src="style/\1" alt="\1" />',line) #replace wiki images
        for match in re.findall(r"\[\[.*?\]\]", line): #replace wiki formatting for local wiki urls
            replacement = re.sub(r"\[\[(.*?)\]\]",r"\1",match)
            #list of known redirects
            if replacement.replace(" ","_").lower() == 'community_forum':
                replacement = '<a href="community_forums' + htm_ext + '">' + replacement + '</a>'
            elif replacement.replace(" ","_").lower() == 'cfg_file':
                replacement = '<a href="keyfinder.cfg' + htm_ext + '">' + replacement + '</a>'
            elif replacement.replace(" ","_").lower() == 'settings_file':
                replacement = '<a href="keyfinder.ini' + htm_ext + '">' + replacement + '</a>'
            elif replacement.replace(" ","_").lower() == 'user_cfg_file':
                replacement = '<a href="user.cfg' + htm_ext + '">' + replacement + '</a>'
            elif replacement.replace(" ","_").lower() == 'application_list':
                replacement = '<a href="software_listbox' + htm_ext + '">' + replacement + '</a>'
            elif replacement.replace(" ","_").lower() == 'key_display':
                replacement = '<a href="key_memo_box' + htm_ext + '">' + replacement + '</a>'
            else:
                replacement = '<a href="' + replacement.replace(" ","_").lower() + htm_ext + '">' + replacement + '</a>'
            line = line.replace(match,replacement)
        for match in re.findall(r"\[.*?\]",line): #replace wiki formatting for remote urls
            replacement = re.sub(r"\[(.*?)\]",r"\1",match)
            replacement = replacement.split(" ",1)
            replacement = '<a href="' + replacement[0] + '" title="' + replacement[0] + '">' + replacement[1] + '</a>'
            line = line.replace(match,replacement)
        line = filter(lambda x: x in string.printable, line)#Stripping non printable unicode characters
        return line
    def htmloutput(self): #generate html output from the raw input
        rawlines=self.raw.split(INPUT_NEW_LINE)
        for line in rawlines:
            if self.blanklineregex.match(line):
                self.closealltags()
            elif self.coderegex.match(line): #parse code declarations, if the line starts with a no break space
                if not self.pre_open:
                    self.closealltags()
                    self.pre_open = True
                    self.output += "<pre>" + NEW_LINE
                self.output += self.coderegex.sub(r"\1"+NEW_LINE,line)
            elif self.headregex.match(line): #parse out headings , = text like this =
                self.closealltags()
                line = self.h1regex.sub(r"<h1>\2</h1>"+NEW_LINE,line)
                line = self.h2regex.sub(r"<h2>\2</h2>"+NEW_LINE,line)
                line = self.h3regex.sub(r"<h3>\2</h3>"+NEW_LINE,line)
                self.output += self.wiki_inline_replace(line)
            elif self.ulregex.match(line): #parse out bullets, * line starts with a star
                if not self.ul_open:
                    self.closealltags()
                    self.ul_open = True
                    self.output += "<ul>" + NEW_LINE
                line = line.split("* ",1)
                self.output += "  <li><span>" + self.wiki_inline_replace(line[len(line)-1]) + "</span></li>" + NEW_LINE
            elif self.olregex.match(line): #parse out numbers, # line starts with a bang
                if not self.ol_open:
                    self.closealltags()
                    self.ol_open = True
                    self.output += "<ol>" + NEW_LINE
                line = line.split("# ",1)
                self.output += "  <li>" + self.wiki_inline_replace(line[len(line)-1]) + "</li>" + NEW_LINE
            elif self.tableregex.match(line): #parse out tables, some complicated shit... go look up how wiki tables are formatted
                line = line.split("|",1)
                if not self.table_open:
                    self.closealltags()
                    self.table_open = True
                    self.tr_open = True
                    self.output += "<table>" + NEW_LINE + "  <tr>" + NEW_LINE
                elif line[len(line)-1] == "-":
                    self.th_written = True
                    self.output += "  </tr>" + NEW_LINE + "  <tr>" + NEW_LINE
                elif line[len(line)-1] == '}':
                    self.closealltags()
                elif not self.th_written:
                    self.output += "    <th>" + self.wiki_inline_replace(line[len(line)-1]) + "</th>" + NEW_LINE
                else:
                    self.output += "    <td>" + self.wiki_inline_replace(line[len(line)-1]) + "</td>" + NEW_LINE
            else:
                if self.wiki_inline_replace(line) != '':
                    if not self.p_open: #if it doesn't belong in any other category then throw it in a <p> tag for xhtml validation
                        self.closealltags()
                        self.p_open = True
                        self.output += "<p>" + self.wiki_inline_replace(line)
                    else:
                        self.output += NEW_LINE + self.wiki_inline_replace(line)
        self.closealltags()
        self.closehtml()
        return self.output

if __name__ == '__main__': #main entry point
    for argument in sys.argv:
        if argument == sys.argv[0] or not os.path.isfile(argument):
            continue;
        title = argument.rsplit(".",1)[0]
        title = re.sub(r"^\./(.*)",r"\1",title)
        htmlfile = title.replace(" ","_").lower() + htm_ext
        f=open(argument, 'r')
        myobj = PageFormatter(f.read(),title)
        f.close()
        #print myobj.htmloutput()
        f=open(htmlfile,'w')
        f.write(myobj.htmloutput())
        f.close()
        print "Generated:",htmlfile
