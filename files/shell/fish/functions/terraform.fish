function terraform
    if set -q AWS_VAULT_PROFILE; and not set -q AWS_VAULT
        if set -q OP_ACCOUNT; and set -q OP_ENV
            aws-vault exec $AWS_VAULT_PROFILE -- op run --account=$OP_ACCOUNT --environment $OP_ENV -- terraform $argv
        else
            aws-vault exec $AWS_VAULT_PROFILE -- terraform $argv
        end
    else
        command terraform $argv
    end
end
