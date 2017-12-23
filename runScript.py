import subprocess
subprocess.call("/Users/jeffrey/Downloads/UoE/Sem1/sp/digit_recogniser/scripts/make_mfccs.sh", shell=True)
subprocess.call("/Users/jeffrey/Downloads/UoE/Sem1/sp/digit_recogniser/scripts/initialise_models", shell=True)
subprocess.call("/Users/jeffrey/Downloads/UoE/Sem1/sp/digit_recogniser/scripts/train_models", shell=True)
subprocess.call("/Users/jeffrey/Downloads/UoE/Sem1/sp/digit_recogniser/scripts/recognise_test_data", shell=True)
subprocess.call("/Users/jeffrey/Downloads/UoE/Sem1/sp/digit_recogniser/scripts/results", shell=True)