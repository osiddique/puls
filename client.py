import socket

def ChatWithServer(client_socket):
    while 1:
        try:
            send_data = raw_input ("Send to server: ")
            client_socket.send(send_data + '\n')
            recv_data = client_socket.recv(512)
            print "Received: ' " + recv_data[:-1] + " ' back from server"
            if (send_data == 'q' or send_data == 'Q' or\
                recv_data == 'q' or recv_data == 'Q'):
                client_socket.close()
                break
        except:
            print "Server connection lost..."
            break
         
if __name__ == "__main__":         
    client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    try:
        client_socket.connect(("localhost", 5000))
        ChatWithServer(client_socket)
    except:
        print "No server running at port 5000..."
        