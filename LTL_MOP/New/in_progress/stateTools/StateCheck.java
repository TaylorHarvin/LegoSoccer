package stateTools;

import fullSoccer.*;
/*import lejos.robotics.navigation.Waypoint;
import lejos.robotics.RegulatedMotor;
import lejos.hardware.motor.UnregulatedMotor;
import lejos.robotics.navigation.Navigator;
import lejos.hardware.sensor.EV3UltrasonicSensor;
import lejos.hardware.sensor.HiTechnicCompass;
import lejos.hardware.sensor.HiTechnicIRSeekerV2;
import lejos.robotics.SampleProvider;*/

// State status options

	
public final class StateCheck{	
	static boolean sonarSuccess = false;
	static boolean modIrSuccess = false;
	static boolean unModIrSuccess = false;
	
	static float irModRead = -1;
	static float irUnModRead = -1;
	static float sonarRead = -1;
	
	static boolean inGoalRange = false;
	static boolean ballInFront = false;
	static boolean ballClose = false;
	static boolean ballKickable = false;
	static boolean robotMoving = false;
	static boolean robotTurning = false;
	
	
	// NOTE: Returning true => that the robot should be in this state
	public static boolean WonderState(Kicker currMK){
		if(!Float.isNaN(irModRead) || !Float.isNaN(irUnModRead)){
			if(irModRead == 0 || irUnModRead == 0)
				return false;
			else
				return true;
		}
		else{
			System.out.println("IR Read Error");
			if(ballClose)
				return false;
			else
				return true;
		}
	}
	
	// Going to ball state
	public static boolean GotoBallState(Kicker currMK){
		// Check if the robot should remain in the goto ball state
		if(ballInFront && robotMoving && !ballClose)
			return true;
		else
			return false;
	}
	
	// Turning to goal state
	public static boolean TurnToGoalState(Kicker currMK){
		// Ball should remain in front of the robot while turning
		// NOTE: Need turning check
		if(ballInFront && ballClose && robotTurning)
			return true;
		else
			return false;
	}
	
	
	public static boolean DribbleBallState(Kicker currMK){
		// Ball should be near and in front robot while moving to goal
		if(!inGoalRange && ballInFront && ballClose)
			return true;
		else
			return false;
	}
	
	
	// Kick state
	public static boolean KickBallAtGoal(Kicker currMK){
		// Ball should be with the robot and in the goal range until kick
		if(inGoalRange && ballInFront && ballClose)
			return true;
		else
			return false;
	}
	
	
	// Get the state of the robot
	// NOTE: This may be the incorrect way of doing this -- depending on what is needed
	public static State GetState(ChangeEvent currEvent, Kicker currMK){
	
		System.out.println("*PERFORMING STATE CHECK*");
		
		// Ping the sensors that were not pinged in the event
		/*if(currEvent != ChangeEvent.SONAR)
			sonarSuccess = currMK.getSensorControl().fetchSonarVal();
		if(currEvent != ChangeEvent.IR_MOD)
			modIrSuccess = currMK.getSensorControl().fetchAngleVal(true);
		if(currEvent != ChangeEvent.IR_UNMOD)
			unModIrSuccess = currMK.getSensorControl().fetchAngleVal(true);*/
		
		sonarRead = currMK.getSensorControl().pingSonar();
		irModRead = currMK.getSensorControl().pingIr(true);
		irUnModRead = currMK.getSensorControl().pingIr(false);
		
		float[] sensorPack = new float[3];
		sensorPack[0] = sonarRead;
		sensorPack[1] = irModRead;
		sensorPack[2] = irUnModRead;
		
		inGoalRange = currMK.getMotionControl().inGoalRange();
		ballInFront = currMK.ballInFront(false,sensorPack);
		ballClose = currMK.ballClose(false,sonarRead);
		ballKickable = currMK.ballKickable(false,sonarRead);
		robotMoving = currMK.getMotionControl().robotMoving();
		robotTurning = currMK.getMotionControl().robotTurning();
		
		
		if(WonderState(currMK))
			return State.WONDER;
		else if(GotoBallState(currMK))
			return State.GOTO_BALL;
		else if(TurnToGoalState(currMK))
			return State.TURN_TO_GOAL;
		else if(DribbleBallState(currMK))
			return State.DRIBBLE_TO_GOAL;
		else if(KickBallAtGoal(currMK))
			return State.KICK_BALL_TO_GOAL;
		else
			return State.INIT;
	}
	
	// Print the current state of the robot
	public static void PrintState(State currState){
		switch(currState){
			case WONDER:
				System.out.println("In -WONDER- State");
				break;
			case TURN_TO_GOAL:
				System.out.println("In -TURN_TO_GOAL- State");
				break;
			case GOTO_BALL:
				System.out.println("In -GOTO_BALL- State");
				break;
			case DRIBBLE_TO_GOAL:
				System.out.println("In -DRIBBLE_TO_GOAL- State");
				break;
			case KICK_BALL_TO_GOAL:
				System.out.println("In -KICK_BALL_TO_GOAL- State");
				break;
			case INIT:
				
				break;
			default:
				System.out.println("UNDEFINED STATE");
				break;
		}
	}
}