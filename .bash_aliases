alias cdmitch='cd /mnt/c/Users/mitch'
export MITCH='/mnt/c/Users/mitch'

alias k='kubectl'

# function to generate sealedsecret and copy it to clipboard (Ubuntu for Windows)
# kubeseal and yq required
kseal() {
  if [ "$1" == "-h" ]; then
    echo "Usage: kseal [SECRET_NAME] [VALUE] [-h]"
    return
  fi

  echo "creating sealed secret file 'sealedsecret-$1.yaml'"
  echo $2 | kubectl create secret generic $1 --dry-run=client --from-file=key=/dev/stdin -o yaml | kubeseal --controller-name=sealed-secrets --controller-namespace=argocd --scope=cluster-wide -o yaml -w sealedsecret-$1.yaml

  echo "copying sealed secret to clipboard"
  yq e .spec.encryptedData.key sealedsecret-$1.yaml | clip.exe
}
