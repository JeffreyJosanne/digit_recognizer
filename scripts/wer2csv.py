data = open('/Users/jeffrey/Downloads/UoE/Sem1/sp/digit_recogniser/output/outputWER','r')
count = -1
data_w = open('/Users/jeffrey/Downloads/UoE/Sem1/sp/digit_recogniser/output/csv_column','w')
for i in data:
    count += 1
    if count%2 ==0:
        data_w.write(i)
        data_w.write(',')
    else:
        data_w.write(i)
        data_w.write('\n')
