/* Programmer: Taylor Harvin
 * Purpose:	   This is the initial kicker for the temp soccer project.
 */
package SimpleSoccer;

import lejos.hardware.port.MotorPort;
import lejos.utility.Delay;


public class InitialKicker {
	public final int AT_BALL = 0;
	public SoccerMotorMotion roboMotor;
	
	
	public InitialKicker(){
		roboMotor = new SoccerMotorMotion(MotorPort.B,MotorPort.C,MotorPort.A);
	}
	
	public void start(){
		Delay.msDelay(1500);
		roboMotor.goForward(SoccerMotorMotion.FAST);
		Delay.msDelay(5000);
		roboMotor.stop();
	}
	
	public void goToBall(){
		
	}
}
