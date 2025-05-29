#k8s
alias k="kubectl"
alias kns="kubens"
alias kctx="kubectx"
alias kg="kubectl get"
alias kd="kubectl describe"
alias kgp="kubectl get pods"
alias kgd="kubectl get deployment"
alias kgn="kubectl get namespaces"
alias kdp="kubectl describe pod"
alias kdd="kubectl describe deployment"
alias kgpa="kubectl get pods -A"
alias kgda="kubectl get deployments -A"
alias kdelp="kubectl delete pod"
alias kdel="kubectl delete"
alias kaf="kubectl apply -f"
alias krrd="kubectl rollout restart deployment"
alias keit="kubectl exec -it"
alias ked="kubectl edit deployment"
alias kl="kubectl logs"
alias kgpg="kubectl get pods | grep"

#flux
alias fl="flux logs"
alias fgk="flux get kustomization"
alias fghr="flux get hr"
alias fshr="flux suspend hr"
alias fsk="flux suspend kustomization"
alias frhr="flux resume hr"
alias frk="flux resume kustomization"

#productivity
alias s="switch"
alias z="zed"
alias nv="nvim"

#git
alias gcm="git commit -m"




#functions
mdcd(){
mkdir $1
cd $1
}





ktunnel(){
    ~/repos/dsh-k8s-work/scripts/kubectx-tunnel.sh -n $1
}

klogs(){
    kgp -A | grep $1 | awk '{print $2, $1}' | xargs -l bash -c 'kubectl logs $0 --namespace $1'
}
