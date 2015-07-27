/* Developer: 			Taylor Harvin
 * Date Last Edited:	7/19/2015
 * Purpose:				Provides the Lego soccer robot with tools to find the ball, and
 * 						react to obstacles as needed.
 */


package SimpleSoccer;

import java.util.Random;

import lejos.hardware.Button;
import lejos.hardware.port.Port;
import lejos.hardware.port.SensorPort;
import lejos.hardware.port.UARTPort;
import lejos.hardware.sensor.EV3IRSensor;
import lejos.hardware.sensor.EV3TouchSensor;
import lejos.hardware.sensor.EV3UltrasonicSensor;
import lejos.robotics.SampleProvider;
import lejos.utility.Delay;

public class BallFinder {
	//private EV3UltrasonicSensor sonarSensor;
	private EV3IRSensor irSensor;
	private SampleProvider irSeek;
	private SampleProvider touch;
	private float[] irSample;
	private float[] touchSample;
	public SoccerMotorMotion roboMotor;
	public boolean searchMode;
	private boolean keepCheckingForBall = true;
	private boolean ballFound = false;
	private final float ballInFrontDistance = (float) 0.07;
	private final float objectDetectedDistance = (float) 1.5;
	private EV3TouchSensor frontTouch;
	public boolean wallHit = false;
	private boolean atBall = false;
	private boolean goToBall = false;
	private GoalFinder goalFinder;
	
	
	public BallFinder(Port touchPort,Port sonarPort, SoccerMotorMotion newRoboMotor){
		//sonarSensor = new EV3UltrasonicSensor(sonarPort);
		irSensor = new EV3IRSensor(sonarPort);
		//distance= sonarSensor.getDistanceMode();
		
		irSeek = irSensor.getMode("Seek");
		irSample = new float[irSeek.sampleSize()];
		roboMotor = newRoboMotor;
		searchMode = false;
		frontTouch = new EV3TouchSensor(touchPort);
		touch = frontTouch.getTouchMode();
		touchSample = new float[touch.sampleSize()];
	}
	
	
	
	public boolean aimedAtBall(){
		fetchAngleVal();
		// Directed towards the ball
		if(irSample[0] > -1 && irSample[0] < 1)
			return true;
		else
			return false;
	}
	
	public void searchForBall(){
		searchMode = true;
		while(searchMode){
			fetchAngleVal();
			// Directed towards the ball
			if(aimedAtBall())
				searchMode = false;
			else{
				if(irSample[0] > 0)
					roboMotor.turnRight(SoccerMotorMotion.MEDIUM, 0);
				else
					roboMotor.turnLeft(SoccerMotorMotion.MEDIUM, 0);
			}
		}
		
	}
	
	public void searchForBall(boolean goalieOverride){
		//roboMotor.haltMotionMotors(50);
		fetchAngleVal();
		// Directed towards the ball
		if(aimedAtBall()){}
		else{
			if(irSample[0] > 0){
				System.out.println("Forward");
				roboMotor.goForward(SoccerMotorMotion.SLOW, 0);
			}
			else if(irSample[0] < 0){
				System.out.println("Backward");
				roboMotor.goBackward(SoccerMotorMotion.SLOW, 0);
			}
			else{
				System.out.println("Stop");
				roboMotor.haltMotionMotors(100);
			}
		}
		
	}
	
	// Object detected -- go to it unless it moves away or a wall is hit
	public void goToBall(){
		searchMode = false;
		float tempSample = 0;
		goToBall = true;
		
		//Delay.msDelay(500);
		// Go close to the ball until
		//while(!touchActivated()){
			roboMotor.goForward(SoccerMotorMotion.MEDIUM_SLOW,0);
			while(!touchActivated() && goToBall){
				tempSample = fetchSonarVal();
				if(ballInRange())
					goToBall = false;
			}
			if(goToBall){
				// wall or robot hit, back up and turn away
				roboMotor.goBackward(SoccerMotorMotion.MEDIUM, 800);
				roboMotor.turnRight(SoccerMotorMotion.MEDIUM_SLOW,500);
			}
		//}
		// The ball is in front of the robot
		// Grab ball
		/*if(tempSample < ballInFrontDistance){
			roboMotor.grabBall();
		}*/
		System.out.println(tempSample);
		System.out.println("End Goto Ball");
		roboMotor.haltMotionMotors(200);
	}
	
	public float fetchAngleVal() {
		irSeek.fetchSample(irSample, 0);
		System.out.println(irSample[0]);
		Delay.msDelay(50);
		return irSample[0];
	}
	
	public float fetchSonarVal(){
		irSeek.fetchSample(irSample, 0);
		System.out.println(irSample[1]);
		Delay.msDelay(50);
		return irSample[1];
	}
	
	public void detectBall(){
		do{
			irSeek.fetchSample(irSample, 0);
			System.out.println(irSample[1]);
			Delay.msDelay(50);
			if(Button.ENTER.isDown())
				keepCheckingForBall = false;
			if(irSample[1] > 7){
				ballFound = true;
			}
		}while(keepCheckingForBall && !ballFound);
		roboMotor.killMotors();
		searchMode = false;
	}
	
	
	public boolean touchActivated(){
		touch.fetchSample(touchSample, 0);
		if(touchSample[0] == 1)
			return true;
		else
			return false;
	}
	
	
	// Start the check for a wall hit
	public void wallHit(){
		wallHit = false;
		//while(!wallHit){
			touch.fetchSample(touchSample, 0);
			if(touchSample[0] == 1){
				wallHit = true;
			}
		//}
	}
	
	
	public void start(){
		Boolean keepChecking = true;
		roboMotor.goForward(SoccerMotorMotion.MEDIUM,0);
		do{
			irSeek.fetchSample(irSample, 0);
			System.out.println(irSample[1]);
			Delay.msDelay(50);
			if(Button.ENTER.isDown())
				keepChecking = false;
		}while(keepChecking && irSample[1] > 7);
		roboMotor.goBackward(SoccerMotorMotion.SLOW, 1000);
		roboMotor.goForward(SoccerMotorMotion.FAST, 1000);
		roboMotor.hitBall();
		System.out.println("Done");
		roboMotor.stop();
		Delay.msDelay(10000);
		
	}
	
	public boolean ballInRange(){
		if(/*tempSample > objectDetectedDistance ||*/ this.fetchSonarVal() < ballInFrontDistance )
			return true;
		else
			return false;
	}
}
