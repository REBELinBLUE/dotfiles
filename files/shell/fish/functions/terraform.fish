function terraform
    if set -q AWS_VAULT_PROFILE; and not set -q AWS_VAULT
        aws-vault exec $AWS_VAULT_PROFILE -- terraform $argv
    else
        command terraform $argv
    end
end