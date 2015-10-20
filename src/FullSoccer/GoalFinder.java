package FullSoccer;

import lejos.robotics.navigation.Navigator;
import lejos.utility.Delay;


public class GoalFinder {
	private Navigator nav;
	private final float goalX = (float) (54*.775);
	private final float goalY = (float) (-42*.775);
	private ColorDetector colorDetector;
	private float xPosOffset = 0;
	private float yPosOffset = 0;
	
	public GoalFinder(Navigator newNav, ColorDetector cDetect, float xOffset,float yOffset){
		nav = newNav;
		colorDetector = cDetect;
		xPosOffset = xOffset;
		//yPosOffset = yOffset;
		if(xOffset == 0 && yOffset == 0){
			xPosOffset = goalX;
			yPosOffset = goalY;
		}
		else{
			xPosOffset = (float) (40.0*.775);
			yPosOffset = (float) (27.0*0.775);
		}
		/*if(yOffset < goalY){
			//yPosOffset = Math.abs((Math.abs(goalY)-Math.abs(yOffset)));
			yPosOffset = ;
		}*/
		
	}
	
	// Go to the goal
	public void gotoGoal(){
		//nav.goTo(goalX+xPosOffset,goalY+yPosOffset);
		nav.goTo(xPosOffset,yPosOffset);
		while(nav.isMoving() /*&& !colorDetector.atEdgeOfGoal()*/){
			Delay.msDelay(50);
		}
	}
}
