#if \r (carriage return for typewriters) is found, you are using the csv module and Windows, then use newline='' in open() to avoid extra blank lines
with open(f'csv_files/job_postings_fact.csv','rb') as orig_csv:
    for qjx in orig_csv:
        if b'\r' in qjx:
            print('\\r found')
            break
    else:
        print('\\r not found')
