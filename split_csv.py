fname='job_postings_fact'
#orig_csv is an iterator, calling orig_csv.readline() for the kth time returns the kth line. When end of file reached it returns ''
with open(f'csv_files/{fname}.csv','r',encoding='utf-8') as orig_csv:
    col_names=orig_csv.readline()
    n=0
    has_more=True
    while has_more:
        with open(f'csv_files/{fname}{n}.csv','w',encoding='utf-8') as new_csv:
            new_csv.write(col_names)
            for j in range(int(4e5)):
                nl=orig_csv.readline()
                if not nl:
                    has_more=False
                    break
                else:
                    new_csv.write(nl)
        n+=1
