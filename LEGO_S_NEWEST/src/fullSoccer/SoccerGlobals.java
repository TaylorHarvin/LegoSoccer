package fullSoccer;

import lejos.robotics.navigation.Waypoint;

public class SoccerGlobals {
	//public static Waypoint GOAL_LOCATION = new Waypoint((54*.775),(-42*.775));
	public static Waypoint GOAL_LOCATION = new Waypoint(150,-75);
	public static int ARM_FULL_OPEN_ANGLE = -90;
	public static double SONAR_OBJECT_SEEN = 0.3;
	public static double SONAR_OBJECT_KICKABLE = 0.12;
	public static double IR_ERROR_ANGLE = 60;
	public static double GOAL_RANGE_THRESHOLD = 40;
}
