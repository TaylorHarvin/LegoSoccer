/* Programmer:	Taylor Harvin
 * Purpose:		This controls the basic motion of a soccer robot
 * 
 */
package SimpleSoccer;

import lejos.hardware.motor.*;
import lejos.hardware.port.Port;
import lejos.robotics.DCMotor;
import lejos.utility.Delay;

public class SoccerMotorMotion {
	
	// Speed constants
	public static int FAST = 100;
	public static int MEDIUM = 75;
	public static int SLOW = 25;
	

	
	// Motor associations
	public UnregulatedMotor leftMotor;
	public UnregulatedMotor rightMotor;
	public EV3MediumRegulatedMotor armMotor;
	
	public SoccerMotorMotion(Port left, Port right, Port arm){
		leftMotor = new UnregulatedMotor(left);
		rightMotor = new UnregulatedMotor(right);
		armMotor = new EV3MediumRegulatedMotor(arm);
	}
	
	public void goForward(int speed){
		leftMotor.setPower(speed);
		rightMotor.setPower(speed);
		leftMotor.forward();
		rightMotor.forward();
	}
	
	public void goBackward(int speed){
		leftMotor.setPower(speed);
		rightMotor.setPower(speed);
		leftMotor.backward();
		rightMotor.backward();
	}
	
	public void turnLeft(int speed){
		leftMotor.setPower(speed);
		rightMotor.setPower(speed);
		leftMotor.backward();
		rightMotor.forward();
	}
	
	public void turnRight(int speed){
		leftMotor.setPower(speed);
		rightMotor.setPower(speed);
		leftMotor.forward();
		rightMotor.backward();
	}
	
	
	public void haltMotionMotors(){
		leftMotor.flt();
		rightMotor.flt();
	}
	
	public void stop(){
		haltMotionMotors();
		leftMotor.close();
		rightMotor.close();
	}
	
	public void hitBall(){
		armMotor.setSpeed(2000);
		armMotor.rotate(-120);
		Delay.msDelay(2000);
		returnArm();
	}
	
	public void returnArm(){
		armMotor.setSpeed(2000);
		armMotor.rotate(120);
		Delay.msDelay(2000);
	}
}
