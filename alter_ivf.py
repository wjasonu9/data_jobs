import csv
import numpy as np
import pandas as pd
import random

with open("csv_files/invoices_fact.csv", "r") as f:
    lines = f.readlines()
for j in range(1,46482):
    hour=random.randint(0,23)
    lines[j]=lines[j][:18]+f'{hour:02d}'+lines[j][20:]
with open("invoices_fact.csv", "w") as f:
    f.writelines(lines)

sk_repl=pd.read_csv('sk_repl.csv',index_col=0)['newi']
skill=pd.read_csv('https://drive.usercontent.google.com/download?id=1wfVxoU_bkkj2lw6jNeIz-NGhv901OYN8&confirm=t')
skill=skill.drop_duplicates('skills').set_index('skills')['skill_id']

with open("csv_files/invoices_fact.csv", "r", newline="", encoding="utf-8") as infile, \
     open("invoices_fact.csv", "w", newline="", encoding="utf-8") as outfile:
    reader = csv.DictReader(infile,delimiter='\t')
    writer=csv.DictWriter(outfile,delimiter='\t',fieldnames=[q 
        if q!='project_tool' else 'tool_id' for q in reader.fieldnames])
    writer.writeheader()
    for row in reader:
        tool=row["project_tool"]
        si=skill.get(tool,'')
        si=sk_repl[si] if si in sk_repl else si
        row["tool_id"]=si
        del row["project_tool"]
        hr=row["hours_rate"]
        row["hours_rate"]=f"{float(hr):.3f}" if len(hr)>7 else hr
        writer.writerow(row)
