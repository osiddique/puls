import Network (listenOn, withSocketsDo, accept, PortID(..), Socket)
import System.IO (hSetBuffering, hGetLine, hPutStrLn, BufferMode(..), Handle)
import Control.Concurrent (forkIO)
import Text.Printf

main :: IO ()
main = withSocketsDo $ do
    server_socket <- listenOn $ PortNumber 5000
    putStrLn "TCP Server Waiting for client on port 5000"
    waitForClient server_socket
    
waitForClient :: Socket -> IO ()
waitForClient server_socket = do
    (client_handle,_,client_address) <- accept server_socket
    printf "I got a connection from "
    print client_address
    printf "\n"
    hSetBuffering client_handle LineBuffering
    forkIO $ clientHandler client_handle client_address
    waitForClient server_socket
    
clientHandler :: Show a => Handle -> a -> IO ()
clientHandler client_handle client_address = do
    recv_data <- hGetLine client_handle
    printf "Received message ' %s ' from " recv_data
    print client_address
    printf "...sending it back\n"
    do hPutStrLn client_handle $ recv_data
    clientHandler client_handle client_address
    