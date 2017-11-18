function k -d "kubectl with determinition" -w k
  switch $argv[2]
    case _
      kubectl --context $argv[1] $argv[3..-1]
    case _getall
      kubectl --context $argv[1] get --all-namespaces $argv[3..-1]
    case '*'
      kubectl --context $argv[1] --namespace $argv[2] $argv[3..-1]
  end

end