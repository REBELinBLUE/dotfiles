function terragrunt
    set -l cmd "terragrunt $argv"

    if set -q OP_ENV
        set -l op_cmd "op run"
        if set -q OP_ACCOUNT
            set op_cmd "$op_cmd --account=$OP_ACCOUNT"
        end
        set cmd "$op_cmd --environment $OP_ENV -- $cmd"
    end

    if set -q AWS_VAULT_PROFILE; and not set -q AWS_VAULT
        set cmd "aws-vault exec $AWS_VAULT_PROFILE -- $cmd"
    end

    eval $cmd
end
