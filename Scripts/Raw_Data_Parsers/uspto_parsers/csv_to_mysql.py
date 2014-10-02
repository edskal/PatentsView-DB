def mysql_upload(host,username,password,dbname,folder):
    import csv
    import MySQLdb
    import re,os
    
    
   
    inp = open(os.path.join(folder,'patent.csv'),'rb').read().split("\r\n")
    del inp[0]
    del inp[-1]
    duplicates = {}
    allpatents = {}
    mergersid = {}
    seconddupl = {}
    secondmerg = {}
    for n in range(len(inp)-1):
        try:
            gg = allpatents[inp[n].split(",")[2]]
            try:
                duplicates[gg].append(inp[n].split(",")[0])
                seconddupl[inp[n].split(",")[0]] = gg
            except:
                duplicates[gg] = [inp[n].split(",")[0]]
                seconddupl[inp[n].split(",")[0]] = gg
        except:
            allpatents[inp[n].split(",")[2]] = inp[n].split(",")[0]
        
        if inp[n+1].split(',')[2] == "NULL":
            try:
                mergersid[runnums].append(inp[n+1].split(",")[0])
                secondmerg[inp[n+1].split(",")[0]] = runnums
            except:
                mergersid[runnums] = [inp[n+1].split(",")[0]]
                secondmerg[inp[n+1].split(",")[0]] = runnums
        else:
            runnums = inp[n+1].split(",")[0]
    
    mydb = MySQLdb.connect(host=host,
        user=username,
        passwd=password,
        db=dbname)
    cursor = mydb.cursor()
    
    #Empty the allpatents container to free up memory - not needed any more
    allpatents = {}
    
    
    duplicdata = {}
    mergersdata = {}
    diri = os.listdir(folder)
    del diri[diri.index('patent.csv')]
    diri.insert(0,'patent.csv')
    del diri[diri.index('rawlocation.csv')]
    diri.insert(2,'rawlocation.csv')
    
    rawlocchek = {}
    cursor.execute('select id from rawlocation')
    locids = [f[0] for f in cursor.fetchall()]
    for l in locids:
        rawlocchek[l.lower()] = 1
    
    for d in diri:
        print d
        infile = csv.reader(file(os.path.join(folder,d),'rb'))
        head = infile.next()
        nullid = None
        if d == "patent.csv":
            idelem = 0
        else:
            try:
                idelem = head.index('patent_id')
            except:
                idelem = None
        if d == 'rawassignee.csv' or d == 'rawinventor.csv':
            nullid = 2
        if d == 'rawlawyer.csv' or d == 'rawlocation.csv':
            nullid = 1
        checkifexists = None
        if d == 'rawlocation.csv':
            checkifexists = 1
        for i in infile:
            towrite = [re.sub('"','',item) for item in i]
            towrite = [re.sub("'",'',w) for w in towrite]
            if nullid:
                towrite[nullid] = 'NULL'
            try:
                gg = duplicates[i[idelem]]
                duplicdata[i[idelem]] = towrite  
            except:
                try:
                    gg = seconddupl[i[idelem]]
                    for nu in range(len(duplicdata[gg])):
                        if duplicdata[gg][nu] == "NULL":
                            duplicdata[gg][nu] = towrite[nu]
                except:
                    try:
                        gg = mergersid[i[idelem]]
                        mergersdata[i[idelem]] = towrite  
                    except:
                        try:
                            gg = secondmerg[i[idelem]]
                            for nu in range(len(mergersdata[gg])):
                                if mergersdata[gg][nu] == "NULL":
                                    mergersdata[gg][nu] = towrite[nu]
                        except:
                            if checkifexists:
                                try:
                                    gg = rawlocchek[towrite[0].lower()]
                                except:
                                    query = "insert into "+d.replace('.csv','')+" values ('"+"','".join(towrite)+"')"
                                    query = query.replace(",'NULL'",",NULL")
                                    cursor.execute(query)
                            else:
                                query = "insert into "+d.replace('.csv','')+" values ('"+"','".join(towrite)+"')"
                                query = query.replace(",'NULL'",",NULL")
                                cursor.execute(query)
            
    
        for v in mergersdata.values():
            query = "insert into "+d.replace('.csv','')+" values ('"+"','".join(towrite)+"')"
            query = query.replace(",'NULL'",",NULL")
            cursor.execute(query)
        
        for v in duplicdata.values():
            query = "insert into "+d.replace('.csv','')+" values ('"+"','".join(towrite)+"')"
            query = query.replace(",'NULL'",",NULL")
            cursor.execute(query)

    mydb.commit()

    print "ALL GOOD"