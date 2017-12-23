import pandas as pd
file = open('info.txt','r')
sorted_file = 'sorted_file.csv'
section = []
contents = []
j = 0
id = []
user = []
gender = []
device = []
speaker_info = []
for i in file.readlines():
    if i!= "\n" and j>37:
        i = i.strip("\n")
        # if i.startswith("Year"):
        #     print("Thats a Year at", j)
        # print(j, i)
        if i.startswith("   ") or i.startswith("Information") or i.startswith("Year") or i.startswith("Name") or i.startswith("---") or i.startswith("students"):
            continue
        else:
            if(len(i.split(' ')) > 1):
                id.append(j)
                user.append(i.split(' ')[0])
                gender.append(i.split(' ')[1])
                device.append(i.split(' ')[2])
                speaker_info.append(i.split(' ')[3])
                # print(j, i.split(' ')[0], i.split(' ')[1], i.split(' ')[2], i.split(' ')[3])
    j += 1

data = pd.DataFrame(
    {'id': id,
     'user': user,
     'gender': gender,
     'device': device,
     'speaker': speaker_info
    })
print(data.groupby('gender').head(5))
# data.to_csv(sorted_file)