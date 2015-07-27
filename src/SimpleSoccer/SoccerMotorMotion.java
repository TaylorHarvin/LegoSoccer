/* Programmer:	Taylor Harvin
 * Date Last Modified: 7/19/2015
 * Purpose:		This controls the basic motion of a soccer robot
 * 				motors (the arm and the two main motors)
 */
package SimpleSoccer;

import lejos.hardware.motor.*;
import lejos.hardware.port.Port;
import lejos.robotics.DCMotor;
import lejos.robotics.RegulatedMotor;
import lejos.utility.Delay;

public class SoccerMotorMotion {
	
	// Speed constants
	public static int FAST = 700;		// Fast speed for the wheel motors
	public static int MEDIUM = 525;		// Medium speed for the wheel motors
	public static int MEDIUM_SLOW = 325;// Medium-slow speed for the wheel motors
	public static int SLOW = 125;		// Slow speed for the wheel motors
	
	public final float baseArmPos;	// starting position of the arm (angle)
	public float curArmPos;			// angle position of armMotor

	
	// Motor associations
	public EV3LargeRegulatedMotor leftMotor;	// Left motor of the robot wheels
	public EV3LargeRegulatedMotor rightMotor;	// Right motor of the robot wheels
	public EV3MediumRegulatedMotor armMotor;	// Arm of the robot
	
	
	// Constructor for SoccerMotorMotion
	// Note: the ports passed as arguments should already be linked 
	//       to the correct motors prior to passing as arguments.
	
	public SoccerMotorMotion(Port left, Port right, Port arm){
		leftMotor = new EV3LargeRegulatedMotor(left);
		rightMotor = new EV3LargeRegulatedMotor(right);
		RegulatedMotor[] tempReg = new RegulatedMotor[1];
		tempReg[0] = rightMotor;
		leftMotor.synchronizeWith(tempReg);
		leftMotor.startSynchronization();
		armMotor = new EV3MediumRegulatedMotor(arm);
		baseArmPos = armMotor.getPosition();
		curArmPos = baseArmPos;
	}
	
	
	// Make the robot go forwards at a given speed
	public void goForward(int speed,int timeDelay){
		//leftMotor.startSynchronization();
		leftMotor.setSpeed(speed);
		rightMotor.setSpeed(speed);
		leftMotor.forward();
		rightMotor.forward();
		Delay.msDelay(timeDelay);
		//leftMotor.endSynchronization();
	}
	
	// Make the robot go backwards at a given speed
	public void goBackward(int speed, int timeDelay){
		leftMotor.startSynchronization();
		leftMotor.setSpeed(speed);
		rightMotor.setSpeed(speed);
		leftMotor.backward();
		rightMotor.backward();
		Delay.msDelay(timeDelay);
		leftMotor.endSynchronization();
	}
	
	
	// Turn the robot to the left at a given speed
	public void turnLeft(int speed, int timeDelay){
		leftMotor.startSynchronization();
		leftMotor.setSpeed(speed);
		rightMotor.setSpeed(speed);
		leftMotor.backward();
		rightMotor.forward();
		Delay.msDelay(timeDelay);
		leftMotor.endSynchronization();
	}
	
	
	// Turn the robot to the right at a given speed
	public void turnRight(int speed, int timeDelay){
		leftMotor.startSynchronization();
		leftMotor.setSpeed(speed);
		rightMotor.setSpeed(speed);
		leftMotor.forward();
		rightMotor.backward();
		Delay.msDelay(timeDelay);
		leftMotor.endSynchronization();
	}
	
	
	// End rotation of the wheel motors
	// Note: This is for hard stops -- may cause direction change
	public void killMotors(){
		leftMotor.startSynchronization();
		leftMotor.stop();
		rightMotor.stop();
		leftMotor.endSynchronization();
	}
	
	
	// End rotation of the wheel motors
	// Note: this is for gradual stops
	public void haltMotionMotors(int timeDelay){
		//leftMotor.startSynchronization();
		/*leftMotor.flt();
		rightMotor.flt();*/
		leftMotor.stop();
		rightMotor.stop();
		Delay.msDelay(timeDelay);
		//leftMotor.endSynchronization();
	}
	
	
	// This completely closes the motors
	// Note: ONLY use this at termination of the program
	public void stop(){
		//leftMotor.startSynchronization();
		haltMotionMotors(0);
		leftMotor.close();
		rightMotor.close();
		//leftMotor.endSynchronization();
	}
	
	
	/*  Kick the ball
	 *  Note:  It is assumed that the arm is already down, and
	 *  	   the ball is in front of the robot
	 */
	 
	public void hitBall(){
		goForward(100,1000);
		goForward(SoccerMotorMotion.FAST,100);
		armMotor.setSpeed(10000);
		armMotor.rotate(120);
		//returnArm();
	}
	
	// Close the arm fully.
	// Note:  This is the standard state of the arm until a ball is found.
	public void closeArm(){
		armMotor.setSpeed(7000);
		armMotor.rotate(-100);
	}
	
	
	// The robot has the ball; and this method releases it.
	// Note:  The ball should not move with this method.
	public void openArmWithBall(){
		armMotor.setSpeed(7000);
		armMotor.rotate(-45);
		//Delay.msDelay(2000);
		System.out.println(armMotor.getPosition());
	}
	
	
	// The arm is closed when the ball is within range of being grabbed
	public void grabBall(){
		armMotor.setSpeed(7000);
		armMotor.rotate(45);
		Delay.msDelay(100);
		curArmPos = armMotor.getPosition();
		//Delay.msDelay(2000);
		
	}
	
	
	/* Position the robot to kick the ball. The robot will release the ball, back up, close
	 * the main arm.
	 * Note:  The robot must be aimed towards the it's target prior to this.
	 */
	public void aimKick(){
		this.haltMotionMotors(1000);
		openArmWithBall();
		Delay.msDelay(1000);
		goBackward(SoccerMotorMotion.SLOW,1200);
		this.haltMotionMotors(200);
		closeArm();
	}
	
}
