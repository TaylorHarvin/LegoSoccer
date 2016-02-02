package FullSoccer;

import lejos.hardware.Button;
import lejos.hardware.motor.Motor;
import lejos.hardware.port.MotorPort;
import lejos.hardware.port.SensorPort;
import lejos.hardware.sensor.HiTechnicCompass;
import lejos.hardware.sensor.SensorMode;
import lejos.robotics.localization.OdometryPoseProvider;
import lejos.robotics.navigation.DifferentialPilot;
import lejos.robotics.navigation.Navigator;
import lejos.utility.Delay;

public class Goalie {
	private Navigator roboMotor;		// Motor control for all of the motors
	private BallFinder ballFinder;			// A helper for soccer ball locating on the board
	private ColorDetector colorDetector;		// A helper for locating the position of the robot on the board
	private int lastMovingDir;
	private int goalColorTriggeredDir;
	private boolean haltForEdge;
	private boolean ballInRange;
	private boolean override;
	
	// Constructor for the GeneralPlayer
	public Goalie(){
		DifferentialPilot diffPilot = new DifferentialPilot(3.348, 15.2,Motor.A,Motor.D);
		OdometryPoseProvider odomPilot = new OdometryPoseProvider (diffPilot);
		//arm = null;
		roboMotor = new Navigator(diffPilot);
		roboMotor.setPoseProvider(odomPilot);
		colorDetector = new ColorDetector(SensorPort.S1);
		haltForEdge = false;
		goalColorTriggeredDir = 0;
	}
	
	public void start(){
		/*boolean tempGoalCheck = false;
		ballFinder.hitBall();
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
			
		}*/
	}
}
