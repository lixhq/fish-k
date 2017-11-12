function k -d "kubectl with determinition" -w k
  kubectl --context $argv[1] --namespace $argv[2] $argv[3..-1]
end