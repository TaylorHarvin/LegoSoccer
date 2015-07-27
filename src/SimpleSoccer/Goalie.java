package SimpleSoccer;

import lejos.hardware.Button;
import lejos.hardware.port.MotorPort;
import lejos.hardware.port.SensorPort;
import lejos.hardware.sensor.HiTechnicCompass;
import lejos.hardware.sensor.SensorMode;
import lejos.utility.Delay;

public class Goalie {
	public SoccerMotorMotion roboMotor;		// Motor control for all of the motors
	public BallFinder ballFinder;			// A helper for soccer ball locating on the board
	public ColorDetector colorDetector;		// A helper for locating the position of the robot on the board
	
	
	
	// Constructor for the GeneralPlayer
	public Goalie(){
		roboMotor = new SoccerMotorMotion(MotorPort.A,MotorPort.D, MotorPort.B);
		ballFinder = new BallFinder(SensorPort.S3,SensorPort.S2,roboMotor);
		colorDetector = new ColorDetector(SensorPort.S1);
	}
	
	public void start(){
		// Continue as goalie until  enter is pressed
		while(!Button.ENTER.isDown()){
			// In goal, search for ball
			while(!colorDetector.atEdgeOfGoal() && !ballFinder.ballInRange() && !Button.ENTER.isDown()){
				ballFinder.searchForBall(true);
				Delay.msDelay(50);
			}
			if(ballFinder.ballInRange()){
				//roboMotor.hitBall();
			}
		}
	}
}
