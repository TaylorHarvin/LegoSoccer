/* Programmer:	Taylor Harvin
 * Date Last Modified: 7/19/2015
 * Purpose:		This controls color monitoring of the floor.
 * 				This helps with location detection of the robot.
 */

package FullSoccer;

import lejos.hardware.port.Port;
import lejos.hardware.port.SensorPort;
import lejos.hardware.sensor.EV3ColorSensor;
import lejos.robotics.Color;
import lejos.robotics.SampleProvider;

public class ColorDetector {
	private EV3ColorSensor colorSensor;		// Main color sensor
	private SampleProvider colorDataProvider;// Data collector from the color sensor
	private float[] colorSample;				// Result of data collection from the color sensor
	
	// Constructor for the ColorDetector
	public ColorDetector(Port colorSensorPort) {
		colorSensor = new EV3ColorSensor(colorSensorPort);
		colorDataProvider = colorSensor.getColorIDMode();
		colorSample = new float[colorDataProvider.sampleSize()];
	}
	
	// Check if the robot is in a shooting range of the goal (or if goalie is still in the goal)	
	public boolean atEdgeOfGoal(){
		colorDataProvider.fetchSample(colorSample, 0);
		//System.out.println("Color:" + colorSample);
		if((int) colorSample[0] == 0 /*|| colorSample[0] == Color.GREEN*/)
			return true;
		else
			return false;
	}
	
	// Check if the robot is at the edge of the board	
	public boolean atEdgeOfBoard(){
		colorDataProvider.fetchSample(colorSample, 0);
		if((int) colorSample[0] == Color.BLACK /*|| colorSample[0] == Color.GREEN*/)
			return true;
		else
			return false;
	}

	public void stop(){
		colorSensor.close();
	}
}
