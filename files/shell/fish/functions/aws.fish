function aws
    if set -q AWS_VAULT_PROFILE; and not set -q AWS_VAULT
        aws-vault exec $AWS_VAULT_PROFILE -- aws $argv
    else
        command aws $argv
    end
end