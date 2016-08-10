package loggingTools;


import java.io.*;

public class Logger{
	private static PrintWriter  outFile = null;
	private static FileOutputStream outFileStream = null;
	
	public static void setFile(LogFile fileType) throws FileNotFoundException{
		outFileStream = new FileOutputStream(new File(fileType + ".out"),true);
	}
	
	public static void log(LogFile fileType, String msg){
		
		
		
		try{
			setFile(fileType);
			outFile = new PrintWriter (outFileStream);
			outFile.append(msg+"\n");
			//outFileStream.println(msg);
		}
		catch(FileNotFoundException e){
			System.out.println("Error");
		}
		outFile.close();
	}
}