### How to generate debug log for terraform:
for mac and linux:
```bash
export TF_LOG="DEBUG"
export TF_LOG_PATH="/tmp/terraform.log"
```
for windows:
```powershell
$env:TF_LOG="DEBUG"
$env:TF_LOG_PATH="C:\tmp\terraform.log"
```


note that: to permanently add debug option, you need to do below:
for linux:
vi ~/.bashrc
add this two lines in bashrc:
export TF_LOG="DEBUG"
export TF_LOG_PATH="/tmp/terraform.log"

save the bashrc file then run below:
source ~/.bashrc

for windows:
add TF_LOG="DEBUG" and TF_LOG_PATH="C:\tmp\terraform.log" in system or user environment variable

