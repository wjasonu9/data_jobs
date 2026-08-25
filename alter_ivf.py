import random

with open("csv_files/invoices_fact.csv", "r") as f:
    lines = f.readlines()
for j in range(1,46482):
    hour=random.randint(0,23)
    lines[j]=lines[j][:18]+f'{hour:02d}'+lines[j][20:]
with open("invoices_fact.csv", "w") as f:
    f.writelines(lines)
