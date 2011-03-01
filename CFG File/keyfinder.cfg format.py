#!/usr/bin/env python
'''
    Reformats keyfinder.cfg to the standard... mostly anyway
    It's pretty shitty
'''
import re,sys,os.path

if __name__ == '__main__':
    if not os.path.isfile("keyfinder.cfg"):
            sys.exit();
    f=open("keyfinder.cfg", 'r')
    cfgfile = f.read()
    f.close()
    cfgfile = cfgfile.split("\n")
    output = ""
    for line in cfgfile:
        if re.match(r'^;.*',line):
            output += line + "\n"
        str=line.split("|")
        toappend = []
        result = ""
        key = ""
        version = ""
        for i in range(0,len(str)):
            if i == 0:
                result = str[i]
            elif re.match(r'^[Kk]ey=.*|[Ss]erial=.*',str[i]):
                key = str[i]
            elif re.match(r'^[Vv]ersion.*',str[i]):
                version = str[i]
            else:
                toappend.append(str[i])
        if len(toappend) > 0:
            result += "|" + key + "|" + version
        elif version == "":
            result += "|" + key
        else:
            result += "|" + key + "|" + version
        for item in toappend:
            result += "|" + item
        if not re.match(r'^;.*',result):
            output += result + "\n"
    f=open("keyfinder2.cfg",'w')
    f.write(output)
    f.close()