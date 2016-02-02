/* Developer: 			Taylor Harvin
 * Date Last Edited:	7/19/2015
 * Purpose:				This class is for the main Lego soccer player.  All tools are grouped together
 * 						to allow the robot to play soccer (except for the goalie position).
 */

package FullSoccer;

import java.io.IOException;

import lejos.hardware.Button;
import lejos.hardware.lcd.LCD;
import lejos.hardware.motor.EV3LargeRegulatedMotor;
import lejos.hardware.motor.EV3MediumRegulatedMotor;
import lejos.hardware.motor.Motor;
import lejos.hardware.port.MotorPort;
import lejos.hardware.port.SensorPort;
import lejos.robotics.DirectionFinder;
import lejos.robotics.DirectionFinderAdapter;
import lejos.robotics.SampleProvider;
import lejos.robotics.chassis.Chassis;
import lejos.robotics.chassis.Wheel;
import lejos.robotics.chassis.WheeledChassis;
import lejos.robotics.filter.MeanFilter;
import lejos.robotics.localization.CompassPoseProvider;
import lejos.robotics.localization.OdometryPoseProvider;
import lejos.robotics.localization.PoseProvider;
import lejos.robotics.navigation.DifferentialPilot;
import lejos.robotics.navigation.MoveController;
import lejos.robotics.navigation.MoveListener;
import lejos.robotics.navigation.MovePilot;
import lejos.robotics.navigation.MoveProvider;
import lejos.robotics.navigation.Navigator;
import lejos.utility.Delay;
import lejos.hardware.sensor.*;

public class GeneralPlayer {
//	public SoccerMotorMotion roboMotor;		// Motor control for all of the motors
	public HiTechnicCompass mainCompass;	// Main compass of the robot
	public final SampleProvider baseDir;		// Data provider from the compass
	private BallFinder ballFinder;			// A helper for soccer ball locating on the board
	//public GoalFinder goalFinder;			// A helper for goal locating when the robot has the ball
	private ColorDetector colorDetector;	// A helper for locating the position of the robot on the board

	private Navigator roboMotor;			// Grid navigation handler
	private EV3MediumRegulatedMotor arm;	// Main arm (not currently used due to navigation blocking)
	private GoalFinder goalFinder;			// Tools to find the goal
	private BotCommunicator botComm;		// Robot networking
	private int xPosOffset = 0;				// x Offset from the first robot
	private int yPosOffset = 0;				// y Offset from the second robot
	private DirectionFinderAdapter dirFind;
	private CompassPoseProvider compassProv;
	
	// Constructor for the GeneralPlayer
	public GeneralPlayer(boolean isServer,int xOffset,int yOffset){
		//roboMotor = new SoccerMotorMotion(MotorPort.A,MotorPort.D, MotorPort.B);
		
		//DifferentialPilot diffPilot = new DifferentialPilot(3.348, 15.2,Motor.A,Motor.D);
		System.out.println("Press Enter for Direction");
		Button.ENTER.waitForPress();
		mainCompass = new HiTechnicCompass(SensorPort.S4);
		baseDir = mainCompass.getCompassMode();
		
		dirFind = new DirectionFinderAdapter(baseDir);
		
		// !!!NOTE: DIMS MAY BE WRONG FOR WHEEL!!!
		Wheel wheel1 = WheeledChassis.modelWheel(Motor.A, 3.348).offset(-7.6);
		Wheel wheel2 = WheeledChassis.modelWheel(Motor.D, 3.348).offset(7.6);
		Chassis chassis = new WheeledChassis(new Wheel[] { wheel1, wheel2 }, WheeledChassis.TYPE_DIFFERENTIAL);
		MovePilot movePilot = new MovePilot(chassis);
		
		compassProv = new CompassPoseProvider (movePilot, dirFind);
		arm = null;
		roboMotor = new Navigator(movePilot);
		roboMotor.setPoseProvider(compassProv);
		
		colorDetector = new ColorDetector(SensorPort.S1);
		ballFinder = new BallFinder(SensorPort.S2,SensorPort.S3,null,roboMotor,arm,colorDetector);
		ballFinder.setPassState(!isServer);
		
		goalFinder = new GoalFinder(roboMotor,colorDetector,xOffset,yOffset);
		botComm = new BotCommunicator(isServer);
		xPosOffset = xOffset;
		yPosOffset = yOffset;
	}
	
	
	
	
	// Start the general player's game of soccer (the first task is to search for the ball)
	// Note:  This is assuming that the goal direction has been set by this point
	public void start(){
		//float[] vals;
		/*while(!Button.ENTER.isDown()){
			LCD.clearDisplay();
			System.out.println(ballFinder.ballInFront());
			//vals = new float[2];
			//vals = ballFinder.getAllIrSig();
			//System.out.println(vals[0] +","+vals[1]);
			Delay.msDelay(5000);
		}*/
		
		/*roboMotor.goTo(20,-52);
		while(roboMotor.isMoving()){
			Delay.msDelay(50);
		}*/
		
		/*ballFinder.closeArm();
		goalFinder.gotoGoal();
		ballFinder.kickBall();*/
		
		float[] otherBotPos = new float[2];					// Other robot position for the pass
		PoseProvider roboPos = roboMotor.getPoseProvider();	// Current robot position finder
		Boolean passConfirmed = false;						// Network/ball pass confirmed from the robot with the ball.
		
		// Kicker waiting for pass
		if(!ballFinder.getPassState()){
			roboMotor.goTo(20, 0);
			
			// Wait for the robot to move to the requested location
			while(roboMotor.isMoving()){
				Delay.msDelay(50);
			}
			try {
				// Waiting for client to grab the ball and send its position
				otherBotPos = botComm.getBotPos();
				System.out.println(otherBotPos[0]+xPosOffset+" -- "+otherBotPos[1]+yPosOffset);
				ballFinder.turnToPlayer(otherBotPos[0]-xPosOffset, otherBotPos[1]-yPosOffset);
				botComm.sendPosition(roboPos.getPose().getX()+xPosOffset, roboPos.getPose().getY()+yPosOffset);
				passConfirmed = botComm.passConfirmed();
			} catch (IOException e) {
				e.printStackTrace();
			}
			//Delay.msDelay(5000);
		}
		
		// Ball has been passed, or this is the original player headed to the ball
		// Get the ball in either case
		System.out.println("PASS CONFIRMED: "+ passConfirmed);
		if(passConfirmed || ballFinder.getPassState()){
			// Wonder (to find ball)
			System.out.println("GOING TO PASS");
			ballFinder.turnToBall(false);
			// ball found, so go to the ball
			//ballFinder.goToBall();
			//
			while(!ballFinder.goToBall()){
				//ballFinder.turnToBall(true);
				ballFinder.turnToBall(false);
				System.out.println("Goto Ball");
			}
			// The second player has the ball and is going to the goal
			if(passConfirmed){
				// Turn to the goal (forward)
				// Go to the goal ( go forward until red or green are hit)
				roboMotor.clearPath();
				goalFinder.gotoGoal();
				ballFinder.kickBall();
			}
		}
		
		System.out.println("PASSED STATE: "+ballFinder.getPassState());
		
		// The initial player has the ball and needs to send its position to the other player
		if(ballFinder.getPassState()){
			try {
				botComm.sendPosition(roboPos.getPose().getX()+xPosOffset, roboPos.getPose().getY()+yPosOffset);
				otherBotPos = botComm.getBotPos();
				System.out.println(otherBotPos[0]+" -- "+otherBotPos[1]);
				ballFinder.turnToPlayer(otherBotPos[0], otherBotPos[1]);
				System.out.println("!!!ABOUT TO PASS!!!");
				//Delay.msDelay(5000);
				ballFinder.kickBall();
				Delay.msDelay(500);
				roboMotor.clearPath();
				botComm.sendMessage("PASSED");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			//Delay.msDelay(5000);
		}
		
		
		
		
		// TEMP: GOTO home position after kick to the goal
		roboMotor.clearPath();
		roboMotor.goTo(0, 0);
		while(roboMotor.isMoving()){
			Delay.msDelay(50);
		}
		// Turn to the goal (forward)

		// Go back to wondering for the ball

	}
}
