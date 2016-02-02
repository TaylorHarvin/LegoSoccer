/* Programmer:	Taylor Harvin
 * Purpose:		Initialize the type of the player (based on button click)
 * 
 */
package FullSoccer;

import lejos.hardware.Button;
import lejos.hardware.lcd.LCD;
import lejos.hardware.motor.EV3LargeRegulatedMotor;
import lejos.hardware.motor.EV3MediumRegulatedMotor;
import lejos.hardware.port.MotorPort;
import lejos.hardware.port.SensorPort;
import lejos.hardware.sensor.HiTechnicCompass;
import lejos.utility.Delay;

public class PlayerTypeInitializer {

	// Choose the robot type
	public static void main(String[] args) {
		System.out.println("Choose Player");
		int robotChoice = Button.waitForAnyPress();
		// Choose the robot type
		switch(robotChoice){
			case Button.ID_UP:
				System.out.println("Initial Kicker");
				//InitialKicker robotKicker = new InitialKicker();
				//robotKicker.start();
				//SoccerMotorMotion motorTest = new SoccerMotorMotion(MotorPort.A,MotorPort.D,MotorPort.B);
				//motorTest.goForward(SoccerMotorMotion.FAST);
				//motorTest.hitBall();
				//motorTest.closeArm();
				//Delay.msDelay(1000);
				break;
			case Button.ID_ENTER:
				System.out.println("Press up for\ncalibration");
				// Callibrate the compass if needed
				robotChoice = Button.waitForAnyPress();
				if(robotChoice == Button.ID_UP){
					HiTechnicCompass mainCompass;
					mainCompass = new HiTechnicCompass(SensorPort.S4);
					mainCompass.startCalibration();
					Button.waitForAnyPress();
					mainCompass.stopCalibration();
					mainCompass.close();
				}
				
				LCD.clear();
				// General Player (wonders for the ball on the board and kicks to the goal)
				System.out.println("General Player");
				GeneralPlayer robotGeneral = new GeneralPlayer(false,0,0);
				robotGeneral.start();
				break;
			case Button.ID_DOWN:
				System.out.println("Press up for\ncalibration");
				// Callibrate the compass if needed
				robotChoice = Button.waitForAnyPress();
				if(robotChoice == Button.ID_UP){
					HiTechnicCompass mainCompass;
					mainCompass = new HiTechnicCompass(SensorPort.S4);
					mainCompass.startCalibration();
					Button.waitForAnyPress();
					mainCompass.stopCalibration();
					mainCompass.close();
				}
				
				LCD.clear();
				// General Player (wonders for the ball on the board and kicks to the goal)
				System.out.println("General Player");
				GeneralPlayer robotGeneralKicker = new GeneralPlayer(true,0,-54);
				robotGeneralKicker.start();
				break;
			//case Button.ID_DOWN:
				// General Player (wonders for the ball on the board and kicks to the goal)
				/*System.out.println("Goalie");
				Goalie goalie = new Goalie();*/
				/*EV3MediumRegulatedMotor arm = new EV3MediumRegulatedMotor(MotorPort.C);
				arm.rotate(45);
				Button.waitForAnyPress();
				//goalie.start();
				break;*/
			case Button.ID_LEFT:
				// Test for server
				BotCommunicator serv = new BotCommunicator(true);
				Delay.msDelay(30000);
				break;
			case Button.ID_RIGHT:
				// Test for client
				BotCommunicator client = new BotCommunicator(false);
				Delay.msDelay(30000);
				break;
		}
		//InitialKicker robot = new InitialKicker();
		//robot.start();
	}

}
