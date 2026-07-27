function terragrunt
    if set -q AWS_VAULT_PROFILE; and not set -q AWS_VAULT
        aws-vault exec $AWS_VAULT_PROFILE -- terragrunt $argv
    else
        command terragrunt $argv
    end
end
