function terragrunt
    if set -q AWS_VAULT_PROFILE; and not set -q AWS_VAULT
        if set -q OP_ACCOUNT; and set -q OP_ENV
            aws-vault exec $AWS_VAULT_PROFILE -- op run --account=$OP_ACCOUNT --environment $OP_ENV -- terragrunt $argv
        else
            aws-vault exec $AWS_VAULT_PROFILE -- terragrunt $argv
        end
    else
        command terragrunt $argv
    end
end
