package fullSoccer;
import lejos.hardware.Battery;
import lejos.hardware.Button;
import lejos.hardware.motor.EV3LargeRegulatedMotor;
import lejos.hardware.motor.Motor;
import lejos.hardware.port.MotorPort;
import lejos.hardware.port.SensorPort;
import lejos.hardware.port.TachoMotorPort;
import lejos.robotics.navigation.Waypoint;
import lejos.utility.Delay;

public class PlayerInit {

	public static void main(String[] args) {
		System.out.println("Battery Current: " + Battery.getBatteryCurrent());
		System.out.println("Battery Voltage: " + Battery.getVoltage());
		System.out.println("Choose Player");
		//int robotChoice = Button.waitForAnyPress();
		float ballLoc;
		
		//switch(robotChoice){
			//case Button.ID_UP:
				System.out.println("Player 1 Selected");
				Kicker robot = new Kicker();
				robot.play();
				
		//		break;
		//}

	}

}

