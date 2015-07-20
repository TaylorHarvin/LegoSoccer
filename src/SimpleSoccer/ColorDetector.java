/* Programmer:	Taylor Harvin
 * Date Last Modified: 7/19/2015
 * Purpose:		This controls color monitoring of the floor.
 * 				This helps with location detection of the robot.
 */

package SimpleSoccer;

import lejos.hardware.port.Port;
import lejos.hardware.port.SensorPort;
import lejos.hardware.sensor.EV3ColorSensor;
import lejos.robotics.Color;
import lejos.robotics.SampleProvider;

public class ColorDetector {
	public EV3ColorSensor colorSensor;		// Main color sensor
	public SampleProvider colorDataProvider;// Data collector from the color sensor
	public float[] colorSample;				// Result of data collection from the color sensor
	
	// Constructor for the ColorDetector
	public ColorDetector(Port colorSensorPort) {
		colorSensor = new EV3ColorSensor(colorSensorPort);
		colorDataProvider = colorSensor.getColorIDMode();
		colorSample = new float[colorDataProvider.sampleSize()];
	}
	
	// Check if the robot is in a shooting range of the goal
	public boolean inShootingRange(){
		colorDataProvider.fetchSample(colorSample, 0);
		if(colorSample[0] == Color.RED /*|| colorSample[0] == Color.GREEN*/)
			return true;
		else
			return false;
	}

}
