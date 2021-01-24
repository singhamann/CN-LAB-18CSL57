import java.io.*;
import java.net.*;

class UDPServer{
    public static void main(String[] args) throws IOException 
    {
        DatagramSocket ds=new DatagramSocket();
        InetAddress ip = InetAddress.getByName("localhost");
        BufferedReader br=new BufferedReader(new InputStreamReader(System.in));
        
        int port =2345;
        String msg;
        
        while(true)
        {
            msg=br.readLine();
            DatagramPacket dp=new DatagramPacket(msg.getBytes(),msg.length(),ip,port);
            if(!msg.equals("quit"))
                ds.send(dp);
            else
                break;
        }
    }
}