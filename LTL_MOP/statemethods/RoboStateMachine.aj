/* Developer: Taylor Harvin
 * Date: 6/27/2016
 * Purpose: Provide state properties of the robot
 *
 */

import fullSoccer.*;
import lejos.robotics.navigation.Waypoint;

aspect RoboStateMachine{
	private static float irModRead;					// Modulated IR value
	private static float irUnModRead;				// UnModulated IR value
	private static float sonarRead;					// Last sonar read by the robot
	private static boolean robotMoving;				// Check if any of the main motors are moving on the robot
	private static boolean robotTurning;			// Check if the both of the main motors are moving in the oposite direction
	private static boolean ballInFront;				// Check if the ball is in front of the robot
	private static boolean ballClose;				// Sonar says ball is within arms of the robot
	private static boolean inGoalRange;				// navigator says the robot is within the given kickable goal range
	private static boolean successfulIrRead;		// Was the last IR read valid?
	private static boolean successfulSonarRead;		// Was the last sonar read valid?
	
	
	
	// NOTE: Returning true => that the robot should be in this state
	public boolean Kicker.WonderState(){
		successfulIrRead = GetSensorControl().GetAllIrSig();
		//successfulSonarRead = GetSensorControl().fetchSonarVal();
		ballClose = GetSensorControl().BallClose();
		
		if(successfulIrRead){
			irModRead = GetSensorControl().GetLastModIR();
			irUnModRead = GetSensorControl().GetLastUnModIR();
		}
		else{
			System.out.println("IR Read Error");
			return true;
		}
		
		/*if(successfulSonarRead)
			sonarRead = GetSensorControl().GetLastSonar();
		else{
			sonarRead = -1;
			System.out.println("Sonar Read Error");
			return true;
		}*/
		
		// Check if the robot should stay in the wonder state
		// Valid IR => just look at IR instead of sonar, otherwise rely on sonar
		if(successfulIrRead){
			if(irModRead == 0 || irUnModRead == 0)
				return false;
			else
				return true;
		}
		else{
			if(ballClose)
				return false;
			else
				return true;
		}
	}
	
	// Going to ball state
	public boolean Kicker.GotoBallState(){
		robotMoving = GetMotionControl().RobotMoving();
		ballInFront = GetSensorControl().BallInFront();
		ballClose = GetSensorControl().BallClose();
		
		irModRead = GetSensorControl().GetLastModIR();
		irUnModRead = GetSensorControl().GetLastUnModIR();
		sonarRead = GetSensorControl().GetLastSonar();
		
		// Check if the robot should remain in the goto ball state
		if(ballInFront && robotMoving && !ballClose)
			return true;
		else
			return false;
	}
	
	// Turning to goal state
	public boolean Kicker.TurnToGoalState(){
		robotMoving = GetMotionControl().RobotMoving();
		robotTurning = GetMotionControl().RobotTurning();
		ballInFront = GetSensorControl().BallInFront();
		ballClose = GetSensorControl().BallClose();
		
		irModRead = GetSensorControl().GetLastModIR();
		irUnModRead = GetSensorControl().GetLastUnModIR();
		sonarRead = GetSensorControl().GetLastSonar();
		
		// Ball should remain in front of the robot while turning
		// NOTE: Need turning check
		if(ballInFront && ballClose && robotTurning)
			return true;
		else
			return false;
	}
	
	
	public boolean Kicker.DribbleBallState(){
		inGoalRange = GetMotionControl().InGoalRange();
		ballInFront = GetSensorControl().BallInFront();
		ballClose = GetSensorControl().BallClose();
		
		irModRead = GetSensorControl().GetLastModIR();
		irUnModRead = GetSensorControl().GetLastUnModIR();
		sonarRead = GetSensorControl().GetLastSonar();
		
		// Ball should be near and in front robot while moving to goal
		if(!inGoalRange && ballInFront && ballClose)
			return true;
		else
			return false;
	}
	
	
	// Kick state
	public boolean Kicker.KickBallAtGoal(){
		inGoalRange = GetMotionControl().InGoalRange();
		ballInFront = GetSensorControl().BallInFront();
		ballClose = GetSensorControl().BallClose();
		
		irModRead = GetSensorControl().GetLastModIR();
		irUnModRead = GetSensorControl().GetLastUnModIR();
		sonarRead = GetSensorControl().GetLastSonar();
		
		// Ball should be with the robot and in the goal range until kick
		if(inGoalRange && ballInFront && ballClose)
			return true;
		else
			return false;
		
	}
	
	// After Init
	/*pointcut RobotInit():call(public MotionControl(RegulatedMotor, RegulatedMotor,SensorControl,boolean)) ||
		call(public SensorControl(Port,Port,Port,boolean));
	
	pointcut Wonder():call(public boolean Wonder());
	
	pointcut GotoBallPC():call(public boolean GotoBall());
	
	pointcut GotoGoal():call(public boolean GotoWaypoint(Waypoint, boolean));
	
	// Goes with goto goal technically
	pointcut Dribble():call(public boolean DribbleBall());
	
	pointcut KickAtGoal():call(public boolean KickBall(int,int, int,int, int, int));*/
}