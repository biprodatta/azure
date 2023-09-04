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


### How to install terraform for MAC:
##### you should have brew installed in your mac
then open terminal and run below commands :
```sh
brew install kreuzwerker/taps/m1-terraform-provider-helper
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
m1-terraform-provider-helper activate
m1-terraform-provider-helper install hashicorp/template -v v2.2.0
```

