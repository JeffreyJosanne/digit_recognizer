data = open('/Users/jeffrey/Downloads/UoE/Sem1/sp/digit_recogniser/output/outputFile.txt', 'r')
wer = 0
user = ''
for i in data:
    if i.startswith('WORD'):
        wer = i.split(' ')[1].split('=')[1]
        print(wer)
    if 'Rec' in i:
        user = (i.split(' ')[4].split('/')[1].split('_')[0])
    