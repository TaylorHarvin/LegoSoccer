package FullSoccer;

import lejos.hardware.Button;
import lejos.hardware.port.MotorPort;
import lejos.hardware.port.SensorPort;
import lejos.hardware.sensor.HiTechnicCompass;
import lejos.hardware.sensor.SensorMode;
import lejos.utility.Delay;

public class Goalie {
	/*public SoccerMotorMotion roboMotor;		// Motor control for all of the motors
	public BallFinder ballFinder;			// A helper for soccer ball locating on the board
	public ColorDetector colorDetector;		// A helper for locating the position of the robot on the board
	private int lastMovingDir;
	private int goalColorTriggeredDir;
	private boolean haltForEdge;
	private boolean ballInRange;
	private boolean override;
	
	// Constructor for the GeneralPlayer
	public Goalie(){
		roboMotor = new SoccerMotorMotion(MotorPort.A,MotorPort.D, MotorPort.B);
		ballFinder = new BallFinder(SensorPort.S2,SensorPort.S3,null,roboMotor);
		ballFinder.setBallInFrontMin(0.081);
		colorDetector = new ColorDetector(SensorPort.S1);
		haltForEdge = false;
		goalColorTriggeredDir = 0;
	}
	
	public void start(){
		boolean tempGoalCheck = false;
		roboMotor.hitBall();
		// Continue as goalie until  enter is pressed
		while(!Button.ENTER.isDown()){
			
			
			// In goal, search for ball
			do{
				tempGoalCheck = colorDetector.atEdgeOfGoal();
				if(tempGoalCheck && ((ballFinder.ballToLeft() && goalColorTriggeredDir == 2) || (ballFinder.ballToRight() && goalColorTriggeredDir == 1)))
					haltForEdge =  true;
				else
					haltForEdge = false;
				ballInRange = ballFinder.ballInRange();
				override = Button.ENTER.isDown();
				lastMovingDir = ballFinder.searchForBall(true);
				//Delay.msDelay(50);
			}while(!haltForEdge && !ballFinder.ballInRange() && !Button.ENTER.isDown());
			
			if(colorDetector.atEdgeOfGoal())
				goalColorTriggeredDir = lastMovingDir;
			if(ballFinder.ballInRange()){
				System.out.println("!!!HIT!!!");
				roboMotor.goalieKick();
			}
			
		}
	}*/
}
