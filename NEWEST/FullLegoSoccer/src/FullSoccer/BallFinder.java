/* Developer: 			Taylor Harvin
 * Date Last Edited:	9/22/2015
 * Purpose:				Provides the Lego soccer robot with tools to find the ball, and
 * 						react to obstacles as needed.
 */


package FullSoccer;


import java.util.Random;


import lejos.hardware.Button;
import lejos.hardware.motor.EV3MediumRegulatedMotor;
import lejos.hardware.motor.Motor;
import lejos.hardware.port.MotorPort;
import lejos.hardware.port.Port;
import lejos.hardware.port.SensorPort;
import lejos.hardware.port.UARTPort;
import lejos.hardware.sensor.EV3IRSensor;
import lejos.hardware.sensor.EV3TouchSensor;
import lejos.hardware.sensor.EV3UltrasonicSensor;
import lejos.hardware.sensor.HiTechnicCompass;
import lejos.robotics.SampleProvider;
import lejos.robotics.localization.OdometryPoseProvider;
import lejos.robotics.localization.PoseProvider;
import lejos.robotics.navigation.DifferentialPilot;
import lejos.robotics.navigation.Navigator;
import lejos.robotics.navigation.Pose;
import lejos.robotics.navigation.Waypoint;
import lejos.utility.Delay;
import lejos.hardware.sensor.*;

public class BallFinder {
	private EV3UltrasonicSensor sonarSensor;	// Actual Sonar sensor
	private EV3MediumRegulatedMotor arm;		// Arm -- not used at the moment due to blocking API
	//private EV3IRSensor irDistSensor;
	private HiTechnicIRSeekerV2 irSensor;		// Actual IR Seeker
	private SampleProvider irSeekModeMod;		// Gets value for modulated IR
	private SampleProvider irSeekModeUnMod;		// Gets value for unmodulated IR
	private SampleProvider distMode;			// Gets value for sonar
	private float[] distanceSample;				// The actual sonar value -- RAW
	private float[] irSample;					// The actual IR value -- RAW
	private float ballDirMod = 0;				// The current modulated IR angle
	private float ballDirUnMod = 0;				// The current unmodulated IR angle
	public static final int AREA_WIDTH = 100;	// Width of the soccer field
	public static final int AREA_LENGTH = 150;	// Length of the soccer field
	private final float BALL_SONAR_DIST_GRAB = (float) 0.08;	// Sonar value threshold for grabbing the ball
	private Navigator roboMotor;				// Controls robot motion in the field/grid
	private boolean armOpen = true;				// Verifies that the arm is in a ready state for a grab
	private ColorDetector colorDetector;		// Checks for edges and goal lines
	private boolean modInFront = false;			// 0.0 modulated IR => true
	private boolean unModInFront = false;		// 0.0 unmodulated IR => true
	private boolean passState = false;			// True => the robot should pass the ball once it has it.
	
	// !!!PENDING REMOVAL CLASS VARIABLES!!!:
	//private boolean exit = false;
	//private boolean ballInFront;
	//private boolean hasBall = false;
	//private final float BALL_DETECT_DIST = (float) 1.0;
	//private OdometryPoseProvider odomPilot;
	//private float currDir = 0;
	private boolean modInRange = false;			// REMOVAL PENDING
	private boolean unModInRange = false;		// REMOVAL PENDING
	private boolean turnHitPreviously = false;	// REMOVAL PENDING
	private float lastTurnDir = 0;				// REMOVAL PENDING
	
	
	// BallFinder Constructor:
	/*
	 * Needs	sonar port
	 * 			touchPort -- PENDING REMOVAL
	 * 			Navigator
	 * 			Odometry Position Provider
	 * 			Differential Pilot -- PENDING REMOVAL
	 * 			EV3 ARM -- Not currently used, but may be later
	 * 			Color Detector
	 */
	public BallFinder(Port sonarPort,Port seekerPort,Port touchPort,Navigator nav,EV3MediumRegulatedMotor newArm, ColorDetector cDetect){
		sonarSensor = new EV3UltrasonicSensor(sonarPort);
		irSensor = new HiTechnicIRSeekerV2(seekerPort);
		distMode = sonarSensor.getDistanceMode();
		distanceSample = new float[distMode.sampleSize()];
		irSeekModeMod = irSensor.getModulatedMode();
		irSeekModeUnMod = irSensor.getUnmodulatedMode();
		irSample = new float[irSeekModeMod.sampleSize()];
		//hasBall = false;
		//ballInFront = false;
		roboMotor = nav;
		arm = newArm;
		colorDetector = cDetect;
	}
	
	
	// Set if the player will pass
	public void setPassState(boolean shouldPass){
		passState = shouldPass;
	}
	
	// Return pass state of the robot
	public boolean getPassState(){
		return passState;
	}
	
	// Get the ball angle relative to the robot
	public float fetchAngleVal(boolean modulated){
		if(modulated)
			irSeekModeMod.fetchSample(irSample, 0);
		else
			irSeekModeUnMod.fetchSample(irSample, 0);
		//System.out.println(irSample[0]);
		Delay.msDelay(50);
		return irSample[0];
	}
	// Get the ball distance value relative to the robot
	public float fetchSonarVal(){
		distMode.fetchSample(distanceSample, 0);
		//System.out.println(distanceSample[0]);
		Delay.msDelay(50);
		return distanceSample[0];
	}
	
	public /*float[]*/void getAllIrSig(){
		//float[] vals = new float[2];
		ballDirMod = fetchAngleVal(true);
		ballDirUnMod = fetchAngleVal(false);
		/*vals[0] = ballDirMod;
		vals[1] = ballDirUnMod;
		return vals;*/
	}
	
	// The navigator uses angles from -180 to 180 -- this corrects the ball ir reading
	public float adjustedAngle(float requestedHeading/*float ballAngle, float robotHeading*/){
		float adjustedHeading = 0;	// Corrected heading -- clip to -180 to 180
		if(requestedHeading < 180){
			adjustedHeading = -180 + (requestedHeading-180);
		}
		else if(requestedHeading > -180){
			adjustedHeading = 180 + (requestedHeading+180);
		}
		else{
			adjustedHeading = 180;
		}
		return adjustedHeading;
	}
	
	public boolean ballInFront(){
		Boolean ballFound = false;
		Float sonar = (float) 0;
		sonar = fetchSonarVal();
		if(sonar < BALL_SONAR_DIST_GRAB)
			return true;
		modInFront = false;
		unModInFront = false;
		unModInRange = false;
		modInRange = false;
		getAllIrSig();
		if(!Float.isNaN((ballDirMod))){
			if(ballDirMod == 0){
				modInFront = true;
			}
			/*else if(ballDirMod >= 0 && ballDirMod <= 30){
				modInRange = true;
			}*/
		}
			
		if(!Float.isNaN(ballDirUnMod)){
			if(ballDirUnMod == 0){
				unModInFront = true;
			}
			/*else if(ballDirUnMod >= 0 && ballDirUnMod <= 30){
				unModInRange = true;
			}*/
		}
		if((modInFront || unModInFront) /*|| (modInFront && unModInRange)||(unModInFront && modInRange)*/)
			ballFound = true;
		//System.out.println(ballFound);
		return ballFound;
	}
	
	
	// Turn to the angle of the ball
	public void turnToBall(boolean closeToBall){
		float angleError = -30;	// Offest for the 
		//System.out.println(diffPilot.getAngleIncrement());
		System.out.println("Turn To Ball");
		
		roboMotor.getMoveController().setLinearSpeed(10);
		Pose roboPos = roboMotor.getPoseProvider().getPose();
		getAllIrSig();
		//roboMotor.rotateTo(currDir+ballDir);
		System.out.println("HEAD_START "+roboPos.getHeading());
		//int printCount = 0;
		
		// Turn to the ball until sonar and/or IR says the ball is in front
		while(!ballInFront() && distanceSample[0] > BALL_SONAR_DIST_GRAB){
			// Modulated IR works better at a longer ball distance
			// Turn to the ball based on the modulated IR value
			if(!closeToBall && !Float.isNaN(ballDirMod)){
				//ballDirMod = adjustedAngle(ballDirMod, roboPos.getHeading());
				angleError = (ballDirMod/Math.abs(ballDirMod))*30;
				roboMotor.goTo(roboPos.getX(), roboPos.getY(),adjustedAngle(roboPos.getHeading() + ballDirMod + angleError));
				System.out.println("TURNING M:  "+(ballDirMod + angleError));
			}
			// Unmodulated IR works better at closer ball distances
			// Turn to the ball based on the unmodulated IR value
			else if(closeToBall && !Float.isNaN(ballDirUnMod)){
				//ballDirUnMod = adjustedAngle(ballDirUnMod, roboPos.getHeading());
				angleError = (ballDirUnMod/Math.abs(ballDirUnMod))*30;
				roboMotor.goTo(roboPos.getX(), roboPos.getY(),adjustedAngle(roboPos.getHeading()+ ballDirUnMod + angleError));
				System.out.println("TURNING UM:  "+(ballDirUnMod + angleError));
			}
			// Invalid value for ball direction -- turn in the last known ball direction
			else{
				// 180 degrees in the last known ball direction
				//roboMotor.goTo(roboPos.getX(), roboPos.getY(),roboPos.getHeading()+angleError*6);
				roboMotor.goTo(roboPos.getX(), roboPos.getY(),adjustedAngle(roboPos.getHeading()+angleError*6));
				
				System.out.println("ELSE TURN:\n"+(angleError*6));
			}
			// Keep turning until the ball is in front or the set turn stops
			while(!ballInFront() && roboMotor.isMoving()){
				Delay.msDelay(50);
				//System.out.println("TEST");
			}
			roboMotor.stop();
		}
		System.out.println("HEAD_END "+roboPos.getHeading());
		//roboMotor.clearPath();
		//roboMotor.stop();
		turnHitPreviously = true;
		//this.diffPilot.quickStop();
		//System.out.println(currDir);
		System.out.println(ballDirMod);
		System.out.println(ballDirUnMod);
		System.out.println(distanceSample[0]);
		System.out.println("End Turn");
	}
	
	// The robot is facing the ball, and this method moves the robot to it
	public boolean goToBall(){
		System.out.println("Go To Ball");
		this.openArm();
		//float currBallDist = fetchSonarVal();
		//Pose roboPos = roboMotor.getPoseProvider().getPose();
		
		roboMotor.getMoveController().setLinearSpeed(10);
		
		//diffPilot.forward();
		roboMotor.getMoveController().forward();
		while(distanceSample[0] > BALL_SONAR_DIST_GRAB && ballInFront()){}
		roboMotor.getMoveController().stop();
			/*ballX = (float) (distanceSample[0]*Math.cos(roboPos.getHeading()));
			ballY = (float) (distanceSample[0]*Math.sin(roboPos.getHeading()));
			roboMotor.goTo(ballX,ballY);*/
			
		// Check if the ball was actually grabbed
		if(distanceSample[0] <= BALL_SONAR_DIST_GRAB){
			turnHitPreviously = false;
			lastTurnDir = 0;
			this.grabBall();
			return true;
		}
		else
			return false;
	}
	
	// The robot is at the ball, so grab it
	public void grabBall(){
		System.out.println("Close: " + armOpen);
		if(armOpen){
			armOpen = false;
			Motor.B.rotate(170);
		}
	}
	
	// The robot is at the ball, so grab it
	public void closeArm(){
		System.out.println("Close: " + armOpen);
		if(armOpen){
			armOpen = false;
			Motor.B.rotate(200);
		}
	}
	
	public void turnToPlayer(float otherBotPos, float otherBotPos2){
		roboMotor.clearPath();
		System.out.println("TURNING TO PLAYER_START");
		PoseProvider currPose = this.roboMotor.getPoseProvider();
		Waypoint otherPos = new Waypoint(otherBotPos,otherBotPos2);
		Waypoint currPos = new Waypoint(currPose.getPose());
		// !!!NOTE!!! -- ADJUSTED HEADING USED -- VERIFY WORKING
		roboMotor.goTo(currPose.getPose().getX(),currPose.getPose().getY(),currPos.angleTo(otherPos));
		float minHeading = (float) (currPos.angleTo(otherPos)-0.09);
		float maxHeading = (float) (currPos.angleTo(otherPos)+0.09);
		float currHeading = 0;
		boolean turnOverride = false;
		while(roboMotor.isMoving() && !turnOverride){
			Delay.msDelay(50);
			currHeading = currPose.getPose().getHeading();
			if(currHeading >= minHeading && currHeading <= maxHeading)
				turnOverride = true;
		}
		roboMotor.clearPath();
		System.out.println("TURNING TO PLAYER_END: "+turnOverride);
	}
	
	
	// The robot is at the ball, so grab it
	public void openArm(){
		System.out.println("Open: " + armOpen);
		if(!armOpen){
			Motor.B.rotate(-190);
			armOpen = true;
		}
	}
	
	// Kick the ball -- timing might need some work
	public void kickBall(){
		openArm();
		roboMotor.getMoveController().backward();
		Delay.msDelay(1000);
		// Go to the goal to shoot (assuming that the robot still has the ball)
		
		/*roboMotor.getMoveController().backward();
		Delay.msDelay(10);*/
		roboMotor.getMoveController().stop();
		closeArm();
		roboMotor.getMoveController().forward();
		Delay.msDelay(1200);
		openArm();
		roboMotor.getMoveController().stop();
	}

	
	// Close all sensors
	public void stop(){
		sonarSensor.close();
		irSensor.close();
		colorDetector.stop();
	}
}
