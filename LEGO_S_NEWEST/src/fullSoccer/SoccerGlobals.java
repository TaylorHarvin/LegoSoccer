package fullSoccer;

import lejos.robotics.navigation.Waypoint;

public class SoccerGlobals {
	//public static Waypoint GOAL_LOCATION = new Waypoint((54*.775),(-42*.775));
	public static Waypoint GOAL_LOCATION = new Waypoint(150,-75); // X,Y of goal point
	public static int ARM_FULL_OPEN_ANGLE = -90;				// Angle for arm to be fully up
	public static double SONAR_OBJECT_SEEN = 0.3;				// threshold for object distance to sonar for a valid "see"
	public static double SONAR_OBJECT_KICKABLE = 0.12;			// Ball distance for a valid kick
	public static double IR_ERROR_ANGLE = 60;					// Possible error value of IR to reduce problems -- MIGHT BE REMOVED
	public static double GOAL_RANGE_THRESHOLD = 40;				// Kickable diameter to the goal
	public static double BALL_SONAR_DIST_GRAB = (float) 0.08;	// Sonar value threshold for grabbing the ball
}
 