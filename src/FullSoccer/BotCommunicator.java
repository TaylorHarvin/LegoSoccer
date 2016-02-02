package FullSoccer;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.ArrayList;
import java.util.Map;

public class BotCommunicator {
	private ServerSocket servSocket;
	private Socket clientSocket;
	//private Map<Integer, String> teamList;
	//private Map<Integer, String> oponentList;
	
	private static final int port = 1234;
	private String serverIp = "192.168.43.228";
	private OutputStream outStream;
	private InputStream inStream;
	private DataInputStream dataInput;
	private DataOutputStream dataOutput;
	private boolean isServer = false;
	
	public BotCommunicator(boolean server){
		isServer = server;
		try {
			if(isServer){
				setSocketType(isServer);
				setupInBuffer();
				setupOutBuffer();
				//sendMessage("Test from EV3 SERV");
				//System.out.println(receiveMessage());
			}
			else{
				setSocketType(isServer);
				setupInBuffer();
				setupOutBuffer();
				//System.out.println(receiveMessage());
				//sendMessage("Test from Client");
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//teamList.
	}
	
	// Establish connection with other robot and setup the socket
	// for communication
	public void setSocketType(boolean server) throws IOException{
		// Attempt to establish the connection with the other robot
		if(server){
			servSocket = new ServerSocket(port);
			System.out.println("Waiting for Client");
			clientSocket = servSocket.accept();
			System.out.println("Connected to Client");
		}
		else{
			clientSocket = new Socket(serverIp, port);
			System.out.println("Connected to Server");
		}
	}
	
	public void setupOutBuffer() throws IOException{
		if(isServer){
			// !!!NOT TESTED YET!!!
			while(!clientSocket.isConnected()){}
			// ^^^!!!NOT TESTED YET!!!^^^
			outStream = clientSocket.getOutputStream();
			dataOutput = new DataOutputStream(outStream);
		}
		else{
			outStream = clientSocket.getOutputStream();
			dataOutput = new DataOutputStream(outStream);
		}
	}
	
	public void setupInBuffer() throws IOException{
		if(isServer){
			while(!clientSocket.isConnected()){}
			inStream = clientSocket.getInputStream();
			dataInput = new DataInputStream(inStream);
		}
		else{
			inStream = clientSocket.getInputStream();
			dataInput = new DataInputStream(inStream);
		}
		
	}
	
	public void sendMessage(String message) throws IOException{
		dataOutput.writeUTF(message);
		dataOutput.flush();
	}
	
	
	public String receiveMessage() throws IOException{
		return dataInput.readUTF();
	}
	
	public void sendPosition(float x, float y){
		try {
			sendMessage(x+","+y);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void closeServer() throws IOException{
		servSocket.close();
	}
	
	public void closeClient() throws IOException{
		clientSocket.close();
	}
	
	public float[] getBotPos() throws IOException{
		String otherBotPos = receiveMessage();
		float botPos[] = new float[2];
		int xySplit = 0;
		xySplit = otherBotPos.indexOf(",");
		botPos[0] = Float.parseFloat(otherBotPos.substring(0, xySplit));
		botPos[1] = Float.parseFloat(otherBotPos.substring(xySplit+1, otherBotPos.length()));
		return botPos;
	}
	
	// Wait for the other player to pass the ball
	public boolean passConfirmed() throws IOException{
		String passed = "";
		passed = receiveMessage();
		System.out.println("RES: \n"+passed);
		// Check if the other robot set a passed signal
		if(passed.contains("PASSED")){
			return true;
		}
		return false;
	}
	
}
