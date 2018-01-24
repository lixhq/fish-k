function __fish_k_needs_command
    set -l cmd (commandline -opc)
    if test (count $cmd) -eq 1
        return 0
    end
    return 1
end

function __fish_k_using_command -a current_command
    set -l cmd (commandline -opc)
    if test (count $cmd) -gt 1
        if test $current_command = $cmd[4]
            return 0
        end
    end
    return 1
end

function __fish_k_arg_number -a number
    set -l cmd (commandline -opc)
    test (count $cmd) -eq $number
end

function __fish_k_arg_at -a number
  set -l cmd (commandline -opc)
  echo $cmd[$number]
end

function __fish_k_context

end

set kubectl_actions (kubectl help | grep '^  ' | sed 's/^  //' | sed "s/ [ ]*/	/")
set kubectl_resources (kubectl get --show-all 2>&1 | grep '^    \* ' | sed 's/^    \* //' | awk '{print $1}')

complete -f -c k -n '__fish_k_needs_command' -a '(kubectl config get-contexts -o name)' -d "Context"
complete -f -c k -n '__fish_k_arg_number 2' -a '(kubectl --context (set -l cmd (commandline -opc); and echo $cmd[2]) get namespaces -o name | sed 's~namespaces/~~')' -d "Namespace"
complete -f -c k -n '__fish_k_arg_number 2' -a '_getall' -d "Get from all namespaces"
complete -f -c k -n '__fish_k_arg_number 2' -a '_' -d "Skip namespace"
complete -f -c k -n '__fish_k_arg_number 3;' -a '$kubectl_actions'

complete -f -c k -n '__fish_k_arg_number 3;' -a '_switch' -d "Switch to context and namespace"

complete -f -c k -n '__fish_k_arg_number 4; and __fish_k_using_command get' -a '$kubectl_resources'
complete -f -c k -n '__fish_k_arg_number 5; and __fish_k_using_command get' -a '(kubectl --context (set -l cmd (commandline -opc); and echo $cmd[2]) --namespace (set -l cmd (commandline -opc); and echo $cmd[3]) get (set -l cmd (commandline -opc); and echo $cmd[5]) -o name | sed "s~.*/~~")'

complete -f -c k -n '__fish_k_arg_number 4; and __fish_k_using_command delete' -a '$kubectl_resources'
complete -f -c k -n '__fish_k_arg_number 5; and __fish_k_using_command delete' -a '(kubectl --context (set -l cmd (commandline -opc); and echo $cmd[2]) --namespace (set -l cmd (commandline -opc); and echo $cmd[3]) get (set -l cmd (commandline -opc); and echo $cmd[5]) -o name | sed "s~.*/~~")'

complete -f -c k -n '__fish_k_arg_number 4; and __fish_k_using_command edit' -a '$kubectl_resources'
complete -f -c k -n '__fish_k_arg_number 5; and __fish_k_using_command edit' -a '(kubectl --context (set -l cmd (commandline -opc); and echo $cmd[2]) --namespace (set -l cmd (commandline -opc); and echo $cmd[3]) get (set -l cmd (commandline -opc); and echo $cmd[5]) -o name | sed "s~.*/~~")'

complete -f -c k -n '__fish_k_arg_number 4; and __fish_k_using_command logs' -a '(kubectl --context (set -l cmd (commandline -opc); and echo $cmd[2]) --namespace (set -l cmd (commandline -opc); and echo $cmd[3]) get pods -o name | sed "s~.*/~~")' -d "Pod"

complete -f -c k -n '__fish_k_arg_number 4; and __fish_k_using_command exec' -a '(kubectl --context (set -l cmd (commandline -opc); and echo $cmd[2]) --namespace (set -l cmd (commandline -opc); and echo $cmd[3]) get pods -o name | sed "s~.*/~~")' -d "Pod"

complete -f -c k -n '__fish_k_arg_number 4; and __fish_k_using_command describe' -a '$kubectl_resources'
complete -f -c k -n '__fish_k_arg_number 5; and __fish_k_using_command describe' -a '(kubectl --context (set -l cmd (commandline -opc); and echo $cmd[2]) --namespace (set -l cmd (commandline -opc); and echo $cmd[3]) get (set -l cmd (commandline -opc); and echo $cmd[5]) -o name | sed "s~.*/~~")'

#complete -f -c k -n '__fish_k_arg_number 4; and __fish_k_using_command ' -a '(kubectl --context (set -l cmd (commandline -opc); and echo $cmd[2]) --namespace (set -l cmd (commandline -opc); and echo $cmd[3]) get pods -o name | sed "s~.*/~~")' -d "Pod"

#complete -f -c k -n '__fish_k_arg_number 5; and __fish_k_using_command get' -a '$kubectl_resources'
#complete -f -c k -n '__fish_k_arg_number 4; and __fish_k_using_command delete' -a '$kubectl_resources'
#complete -f -c k -n '__fish_k_arg_number 4; and __fish_k_using_command delete' -a '$kubectl_resources'
