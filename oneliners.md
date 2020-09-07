# Unpack all rar archives in the directories with the same names
```bash
for item in $(ls *.rar); do dirname=$(echo $item | cut -f 1 -d "."); unrar x $item "${dirname}/"; done 
```
