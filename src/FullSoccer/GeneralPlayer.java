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
import lejos.robotics.SampleProvider;
import lejos.robotics.filter.MeanFilter;
import lejos.robotics.localization.OdometryPoseProvider;
import lejos.robotics.localization.PoseProvider;
import lejos.robotics.navigation.DifferentialPilot;
import lejos.robotics.navigation.MoveController;
import lejos.robotics.navigation.MoveListener;
import lejos.robotics.navigation.Navigator;
import lejos.utility.Delay;
import lejos.hardware.sensor.*;

public class GeneralPlayer {
//	public SoccerMotorMotion roboMotor;		// Motor control for all of the motors
	//public HiTechnicCompass mainCompass;	// Main compass of the robot
	//public final SensorMode baseDir;		// Data provider from the compass
	public BallFinder ballFinder;			// A helper for soccer ball locating on the board
	//public GoalFinder goalFinder;			// A helper for goal locating when the robot has the ball
	private ColorDetector colorDetector;		// A helper for locating the position of the robot on the board
	private DifferentialPilot diffPilot;
	private Navigator roboMotor;
	private EV3MediumRegulatedMotor arm;
	private GoalFinder goalFinder;
	private BotCommunicator botComm;
	private int xPosOffset = 0;
	private int yPosOffset = 0;
	
	// Constructor for the GeneralPlayer
	public GeneralPlayer(boolean isServer,int xOffset,int yOffset){
		//roboMotor = new SoccerMotorMotion(MotorPort.A,MotorPort.D, MotorPort.B);
		
		DifferentialPilot diffPilot = new DifferentialPilot(3.348, 15.2,Motor.A,Motor.D);
		OdometryPoseProvider odomPilot = new OdometryPoseProvider (diffPilot);
		arm = null;
		roboMotor = new Navigator(diffPilot);
		roboMotor.setPoseProvider(odomPilot);
		//System.out.println("Press Enter for Direction");
		//Button.ENTER.waitForPress();
		//smainCompass = new HiTechnicCompass(SensorPort.S4);
		//baseDir = mainCompass.getCompassMode();
		ballFinder = new BallFinder(SensorPort.S2,SensorPort.S3,null,roboMotor,odomPilot,diffPilot,arm,colorDetector);
		ballFinder.setPassState(!isServer);
		colorDetector = new ColorDetector(SensorPort.S1);
		diffPilot.setRotateSpeed(50);
		goalFinder = new GoalFinder(roboMotor,colorDetector);
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
		float[] otherBotPos = new float[2];
		PoseProvider roboPos = roboMotor.getPoseProvider();
		Boolean passConfirmed = false;
		
		// Kicker waiting for pass
		if(!ballFinder.getPassState()){
			roboMotor.goTo(20, 0);
			while(roboMotor.isMoving()){
				Delay.msDelay(50);
			}
			try {
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
		
			while(!ballFinder.goToBall()){
				//ballFinder.turnToBall(true);
				ballFinder.turnToBall(false);
				System.out.println("Goto Ball");
			}
		}
		
		System.out.println("PASSED STATE: "+ballFinder.getPassState());
		
		// The initial player has the ball and needs to send it's position to the other player
		if(ballFinder.getPassState()){
			try {
				botComm.sendPosition(roboPos.getPose().getX()+xPosOffset, roboPos.getPose().getY()+yPosOffset);
				otherBotPos = botComm.getBotPos();
				System.out.println(otherBotPos[0]+" -- "+otherBotPos[1]);
				ballFinder.turnToPlayer(otherBotPos[0], otherBotPos[1]);
				/*System.out.println("!!!ABOUT TO PASS!!!");
				Delay.msDelay(5000);
				ballFinder.kickBall();
				Delay.msDelay(500);*/
				roboMotor.clearPath();
				botComm.sendMessage("PASSED");
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			Delay.msDelay(5000);
		}
		
		
		// Turn to the goal (forward)
		// Go to the goal ( go forward until red or green are hit)
		/*goalFinder.gotoGoal();
		ballFinder.kickBall();
		
		// TEMP: GOTO home position after kick to the goal
		roboMotor.goTo(0, 0);
		while(roboMotor.isMoving()){
			Delay.msDelay(50);
		}*/
		// Turn to the goal (forward)

		// Go back to wondering for the ball

	}
}
