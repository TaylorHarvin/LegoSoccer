/* Programmer:	Taylor Harvin
 * Date Last Modified: 7/19/2015
 * Purpose:		This class helps identify the location of the goal
 */


package SimpleSoccer;

import lejos.hardware.Button;
//import lejos.hardware.port.Port;
//import lejos.hardware.sensor.HiTechnicCompass;
import lejos.hardware.sensor.SensorMode;
import lejos.robotics.SampleProvider;
import lejos.robotics.filter.MeanFilter;
import lejos.utility.Delay;

public class GoalFinder {
	public final SensorMode baseDir;		// Helper for data collection from the compass
	public SoccerMotorMotion roboMotor;		// Motor controller for all motors of the robot
	public float [] vals;					// Values sampled from the compass sensor
	public SampleProvider averageDir;		// Average compass data in a given time
	public float goalLocation = 0;			// Exact direction of the goal (in terms of compass value)
	public float goalLocationLeftMax = 0;	// Exact direction of the goal minus a left error range
	public float goalLocationRightMax = 0;	// Exact direction of the goal plus a right error range
	
	
	// Constructor for the GoalFinder
	public GoalFinder(SensorMode compassMode,SoccerMotorMotion motor) {
		baseDir = compassMode;
		roboMotor = motor;
		averageDir = new MeanFilter(baseDir,5);
		vals = new float[averageDir.sampleSize()];
		averageDir.fetchSample(vals, 0);
	}
	
	
	// Set the direction of the goal (based on compass input)
	// Note: Point the robot in the direction of the goal before proceeding with this method
	public void setGoalLocation(){
		System.out.println("Set Goal Direction");
		Button.waitForAnyPress();
		averageDir.fetchSample(vals, 0);
		goalLocation = vals[0];
		
		/*
		if(goalLocation+120 > 360){
			goalLocation -= 360;
		}*/
		
		goalLocationLeftMax = goalLocation + 5;
		
		// Normalize the left goal range max 0 to 360
		if(goalLocationLeftMax > 360)
			goalLocationLeftMax -= 360;
		
		goalLocationRightMax = goalLocation - 5;
		// Normalize the right goal range max 0 to 360
		if(goalLocationRightMax < 0)
			goalLocationRightMax += 360;
		
		
		
		/*System.out.println("Move Dir");
		Delay.msDelay(4000);*/
	}
	
	// Aim the robot towards the goal
	public void turnToGoal(){
		System.out.println("Start Turn\nTo Goal");
		Boolean keepLooking = true;
		averageDir.fetchSample(vals, 0);
		float dirDiff1 = goalLocation-vals[0];
		float dirDiff2 = vals[0]-goalLocation;
		if(dirDiff1 < 0)
			roboMotor.turnLeft(SoccerMotorMotion.FAST);
		else
			roboMotor.turnRight(SoccerMotorMotion.FAST);
		
		// Turn the robot until the front of the robot is in the direction
		// of the goal
		do{
			Delay.msDelay(50);
			averageDir.fetchSample(vals, 0);
			//System.out.println(vals[0]);
			if(Button.ENTER.isDown())
				keepLooking = false;
		}while((vals[0] > goalLocationLeftMax || vals[0] < goalLocationRightMax) && keepLooking);
		roboMotor.haltMotionMotors();
		System.out.println("Goal Dir Set:\n"+goalLocation);
		System.out.println("Left Max:\n"+goalLocationLeftMax);
		System.out.println("Right Max:\n"+goalLocationRightMax);
		System.out.println("Final:\n"+vals[0]);
		System.out.println("Final:\n"+vals.toString());
		
	}
	
}
