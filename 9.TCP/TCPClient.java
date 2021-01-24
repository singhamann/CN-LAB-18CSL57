import java.net.Socket;
import java.io.IOException;
import java.io.PrintStream;
import java.util.Scanner;

public class TCPClient{
 public static void main(String[] args) {
  try{
    Socket socket = new Socket("localhost",1300);
    Scanner socketScanner = new Scanner(socket.getInputStream());
    Scanner consoleScanner = new Scanner (System.in);
    System.out.println("Enter the filename:");
    String filename= consoleScanner.nextLine();
    PrintStream printStream = new PrintStream(socket.getOutputStream());
    printStream.println(filename);
    while(socketScanner.hasNextLine()){
      System.out.println(socketScanner.nextLine());
    }
    socket.close();
    socketScanner.close();
    consoleScanner.close();
  }
  catch(IOException e){
    System.out.println(e.getMessage());
  }
 }
   
 }