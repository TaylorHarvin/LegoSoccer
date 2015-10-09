package FullSoccer;

import lejos.robotics.navigation.Navigator;
import lejos.utility.Delay;


public class GoalFinder {
	private Navigator nav;
	private final float goalX = (float) (54*.775);
	private final float goalY = (float) (-42*.775);
	private ColorDetector colorDetector;
	
	public GoalFinder(Navigator newNav, ColorDetector cDetect){
		nav = newNav;
		colorDetector = cDetect;
	}
	
	// Go to the goal
	public void gotoGoal(){
		nav.goTo(goalX,goalY);
		while(nav.isMoving() && !colorDetector.atEdgeOfGoal()){
			Delay.msDelay(50);
		}
	}
}
