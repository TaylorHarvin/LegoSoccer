/* Developer: Taylor Harvin
 * Date Last Changed: 7/06/2016
 * Purpose: Provide state properties of the robot
 *
 */

import fullSoccer.*;
import lejos.robotics.navigation.Waypoint;
import lejos.robotics.RegulatedMotor;
import lejos.hardware.motor.UnregulatedMotor;
import lejos.robotics.navigation.Navigator;
import lejos.hardware.sensor.EV3UltrasonicSensor;
import lejos.hardware.sensor.HiTechnicCompass;
import lejos.hardware.sensor.HiTechnicIRSeekerV2;
import lejos.robotics.SampleProvider;

aspect RoboStateMachine{

	
	
	// Get the state of the robot
	// NOTE: This may be the incorrect way of doing this -- depending on what is needed
	public void Kicker.GetState(){
		System.out.println("TEST");
	}
	
	pointcut playPC(Kicker MK) : call(public void Kicker.play()) && target(MK);

	
	// IR -- Mod 
	pointcut irModChange(Kicker MK) : cflowbelow(playPC(MK)) && set(float SensorControl.ballDirMod);
	after(Kicker MK):irModChange(MK){
		System.out.println("!!!IR Changed!!!");
		//MK.GetState();
		//MK.WonderState();
		//MK.ballInFront(false);
	}
	
	
	

}