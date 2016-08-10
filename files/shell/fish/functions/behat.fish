# FIXME: There has to be a better way to do this
function behat -d "Wraps behat to make the colours fit my terminal better"
    set -l FORMATTING '{
        "output_styles": {
            "keyboard": [null, null, ["bold"]],
            "stdout": [null, null, []],
            "exception": ["red"],
            "undefined": ["yellow"],
            "pending": ["yellow"],
            "pending_param": ["yellow", null, ["bold"]],
            "failed": ["red"],
            "failed_param": ["red", null, ["bold"]],
            "passed": ["green"],
            "passed_param": ["green", null, ["bold"]],
            "skipped": ["cyan"],
            "skipped_param": ["cyan", null, ["bold"]],
            "comment":["blue"],
            "tag": ["cyan"]
        }
    }'

    if [ -e './vendor/bin/behat' ]
        eval ./vendor/bin/behat --format-settings='$FORMATTING' $argv
    else
        eval behat --format-settings='$FORMATTING' $argv
    end
end

