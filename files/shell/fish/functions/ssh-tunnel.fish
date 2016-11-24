function ssh-tunnel -d "Starts a new SSH tunnel"
    # set running (ps aux | grep ssh | grep 3128 -c)
    # if test $running -ne 0
    #     disconnect
    # end

    #eval (command ssh -fNL LOCALPORT:IP:REMOTEPORT user@domain)
    eval (command ssh -fNL 3306:mysql.db.internal:3306 stephen.ball@somewhere)
    e_success "Connected"
end

# function _tunnel_is_connected
#     set running (ps aux | grep ssh | grep 3306 -c)
#     if [ $running = 1 ]
#         echo "Connected"
#     else
#         echo "Not connected"
#     end
# end

function disconnect
    set running  (ps aux | grep "ssh -fNL" | grep 3306 -c)
    if [ $running = 0 ]
        e_warning "No running tunnels"
    else
        ps aux | grep "ssh -fNL" | grep 3306 | awk '{print $2}' | xargs kill
        e_error "All SSH tunnels closed"
    end
end
