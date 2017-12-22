git branch -r --merged |
grep origin |
grep CUI- |
egrep -v '>|master' |
egrep -v '>|release' |
egrep -v '>|integration' |
cut -d/ -f2- |
xargs echo "git push origin --delete "