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
	public static boolean sonarSuccess = false;
	public static boolean modIrSuccess = false;
	public static boolean unModIrSuccess = false;
	
	public static float irModRead = -1;
	public static float irUnModRead = -1;
	public static float sonarRead = -1;
	
	public static boolean inGoalRange = false;
	public static boolean ballInFront = false;
	public static boolean ballClose = false;
	public static boolean ballKickable = false;
	public static boolean robotMoving = false;
	public static boolean robotTurning = false;
	public static boolean bifStateGen;
	
	
	public static boolean BallInFront(float sonar, float irMod, float irUnMod){
		if(sonarRead < SoccerGlobals.BALL_SONAR_DIST_GRAB){
			return true;
		}
		//************** IR Check -- Modulated*****************//
		if(!Float.isNaN((irMod))){
			if(irMod == 0){
				return true;
			}
		}
		
		//************** IR Check -- UnModulated***************//
		if(!Float.isNaN(irUnMod)){
			if(irUnMod == 0){
				return true;
			}
		}
		return false;
	}
	
	public static boolean BallClose(float sonar){
		if(sonar < SoccerGlobals.BALL_SONAR_DIST_GRAB)
			return true;
		return false;
	}
	
	public static boolean BallKickable(float sonar){
		if(sonar < SoccerGlobals.SONAR_OBJECT_KICKABLE)
			return true;
		return false;
	}
	
	
	
	// NOTE: Returning true => that the robot should be in this state
	public static boolean WonderState(Kicker currMK){
		if(!ballInFront)
			return true;
		else
			return false;
		/*if(!Float.isNaN(irModRead) || !Float.isNaN(irUnModRead)){
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
		}*/
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
		
		
		//!!! NOTE: Might need to perform non-ping, and rely only on the previously retrieved
		// values, however, 
		//sonarRead = currMK.getSensorControl().pingSonar();
		sonarRead = currMK.getSensorControl().getLastSonar();
		irModRead = currMK.getSensorControl().getLastModIR();
		//irModRead = currMK.getSensorControl().pingIr(true);
		//irUnModRead = currMK.getSensorControl().pingIr(false);
		irUnModRead = currMK.getSensorControl().getLastUnModIR();
		System.out.println("BIF CHECK RES: "+sonarRead+" , "+irModRead+" , "+irUnModRead);
		
		
		ballInFront = BallInFront(sonarRead, irModRead, irUnModRead);
		
		inGoalRange = currMK.getMotionControl().inGoalRange();
		ballClose = BallClose(sonarRead);
		ballKickable = BallKickable(sonarRead);
		robotMoving = currMK.getMotionControl().robotMoving();
		robotTurning = currMK.getMotionControl().robotTurning();
		
		
		boolean inWonderState = WonderState(currMK);
		boolean inGotoBallState = GotoBallState(currMK);
		boolean inTurnToGoalState = TurnToGoalState(currMK);
		boolean inDribbleBallState = DribbleBallState(currMK);
		boolean inKickBallAtGoal = KickBallAtGoal(currMK);
		
		if(inWonderState)
			return State.WONDER;
		else if(inGotoBallState)
			return State.GOTO_BALL;
		else if(inTurnToGoalState)
			return State.TURN_TO_GOAL;
		else if(inDribbleBallState)
			return State.DRIBBLE_TO_GOAL;
		else if(inKickBallAtGoal)
			return State.KICK_BALL_TO_GOAL;
		else
			return State.INIT;
		
		/*if(WonderState(currMK))
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
			return State.INIT;*/
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
	
	/*public static void generateBallInFrontState(){
		System.out.println("Generated BIF");
		bifStateGen = true;
	}
	
	public static boolean checkBallInFront(Kicker currMK){
		float[] sensorPack = new float[3];
		sensorPack[0] = currMK.getSensorControl().getLastSonar();
		sensorPack[1] = currMK.getSensorControl().getLastModIR();
		sensorPack[2] = currMK.getSensorControl().getLastUnModIR();
		System.out.println("BIF CHECK RES: "+sensorPack[0]+" , "+sensorPack[1]+" , "+sensorPack[2]);
		return currMK.ballInFront(false,sensorPack);
	}*/
}