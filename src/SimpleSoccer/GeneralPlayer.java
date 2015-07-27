/* Developer: 			Taylor Harvin
 * Date Last Edited:	7/19/2015
 * Purpose:				This class is for the main Lego soccer player.  All tools are grouped together
 * 						to allow the robot to play soccer (except for the goalie position).
 */

package SimpleSoccer;

import lejos.hardware.Button;
import lejos.hardware.motor.EV3LargeRegulatedMotor;
import lejos.hardware.port.MotorPort;
import lejos.hardware.port.SensorPort;
import lejos.robotics.SampleProvider;
import lejos.robotics.filter.MeanFilter;
import lejos.utility.Delay;
import lejos.hardware.sensor.*;

public class GeneralPlayer {
	public SoccerMotorMotion roboMotor;		// Motor control for all of the motors
	public HiTechnicCompass mainCompass;	// Main compass of the robot
	public final SensorMode baseDir;		// Data provider from the compass
	public BallFinder ballFinder;			// A helper for soccer ball locating on the board
	public GoalFinder goalFinder;			// A helper for goal locating when the robot has the ball
	public ColorDetector colorDetector;		// A helper for locating the position of the robot on the board
	
	
	
	// Constructor for the GeneralPlayer
	public GeneralPlayer(){
		roboMotor = new SoccerMotorMotion(MotorPort.A,MotorPort.D, MotorPort.B);
		System.out.println("Press Enter for Direction");
		Button.ENTER.waitForPress();
		mainCompass = new HiTechnicCompass(SensorPort.S4);
		
		baseDir = mainCompass.getCompassMode();
		goalFinder = new GoalFinder(baseDir,roboMotor);
		goalFinder.setGoalLocation();
		ballFinder = new BallFinder(SensorPort.S3,SensorPort.S2,roboMotor);
		colorDetector = new ColorDetector(SensorPort.S1);
	}
	
	
	
	
	// Start the general player's game of soccer (the first task is to search for the ball)
	// Note:  This is assuming that the goal direction has been set by this point
	public void start(){
		// Wonder (to find ball)
		ballFinder.searchForBall();
		// ball found, so go to the ball
		ballFinder.goToBall();
		// Turn to the goal (forward)
		goalFinder.turnToGoal();
		// Go to the goal ( go forward until red or green are hit)
		roboMotor.goForward(SoccerMotorMotion.MEDIUM,0);
		//Delay.msDelay(1500);
		Boolean inShootingRange = colorDetector.atEdgeOfGoal();
		// Go to the goal to shoot (assuming that the robot still has the ball)
		while(!inShootingRange){
			while(!colorDetector.atEdgeOfGoal() && !ballFinder.touchActivated()){
				Delay.msDelay(10);
				inShootingRange = colorDetector.atEdgeOfGoal();
			}
			// Another robot hit (or wall), go backward a little bit
			if(!inShootingRange){
				roboMotor.goBackward(SoccerMotorMotion.MEDIUM,1000);
				roboMotor.haltMotionMotors(200);
				roboMotor.goForward(SoccerMotorMotion.MEDIUM,0);
			}
		}
		roboMotor.haltMotionMotors(200);
		// Hit the ball
		roboMotor.goBackward(SoccerMotorMotion.MEDIUM,1000);
		// Turn to the goal (forward)
		goalFinder.turnToGoal();
		roboMotor.aimKick();
		//goalFinder.turnToGoal();
		roboMotor.hitBall();
		roboMotor.haltMotionMotors(200);
		// Go back to wondering for the ball
		//ballFinder.searchForBall();
	}
}
