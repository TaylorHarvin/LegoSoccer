/* Programmer:	Taylor Harvin
 * Purpose:		Initialize the type of the player (based on button click)
 * 
 */
package SimpleSoccer;

import lejos.hardware.Button;

public class PlayerTypeInitializer {

	public static void main(String[] args) {
		int robotChoice = Button.waitForAnyPress();
		switch(robotChoice){
			case 1:
				System.out.println("Initial Kicker");
				InitialKicker robotKicker = new InitialKicker();
				robotKicker.start();
				break;
			case Button.ID_ENTER:
				System.out.println("Golie");
				Goalie robotGoalie = new Goalie();
				robotGoalie.start();
				break;
		}
		//InitialKicker robot = new InitialKicker();
		//robot.start();
	}

}
