import pandas as pd
import subprocess
import shlex
data = pd.read_csv('sorted_file.csv')

for i in data['user']:
    file_str = i
    with open('/Users/jeffrey/Downloads/UoE/Sem1/sp/digit_recogniser/resources/user_list', "w") as f:
        f.write(file_str)
    with open('/Users/jeffrey/Downloads/UoE/Sem1/sp/digit_recogniser/resources/test_users', "w") as f:
        f.write(file_str)
    subprocess.call(shlex.split("singleScript"), shell = True)