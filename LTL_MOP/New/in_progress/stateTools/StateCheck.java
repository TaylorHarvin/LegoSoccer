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

	
public class StateCheck{	
	boolean sonarSuccess = false;
	boolean modIrSuccess = false;
	boolean unModIrSuccess = false;
	
	float irModRead = -1;
	float irUnModRead = -1;
	float sonarRead = -1;
	
	boolean inGoalRange = false;
	boolean ballInFront = false;
	boolean ballClose = false;
	boolean robotMoving = false;
	boolean robotTurning = false;
	
	
	// NOTE: Returning true => that the robot should be in this state
	public boolean WonderState(Kicker currMK){
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
	public boolean GotoBallState(Kicker currMK){
		// Check if the robot should remain in the goto ball state
		if(ballInFront && robotMoving && !ballClose)
			return true;
		else
			return false;
	}
	
	// Turning to goal state
	public boolean TurnToGoalState(Kicker currMK){
		// Ball should remain in front of the robot while turning
		// NOTE: Need turning check
		if(ballInFront && ballClose && robotTurning)
			return true;
		else
			return false;
	}
	
	
	public boolean DribbleBallState(Kicker currMK){
		// Ball should be near and in front robot while moving to goal
		if(!inGoalRange && ballInFront && ballClose)
			return true;
		else
			return false;
	}
	
	
	// Kick state
	public boolean KickBallAtGoal(Kicker currMK){
		// Ball should be with the robot and in the goal range until kick
		if(inGoalRange && ballInFront && ballClose)
			return true;
		else
			return false;
	}
	
	
	// Get the state of the robot
	// NOTE: This may be the incorrect way of doing this -- depending on what is needed
	public State GetState(ChangeEvent currEvent, Kicker currMK){
	
		
		
		// Ping the sensors that were not pinged in the event
		/*if(currEvent != ChangeEvent.SONAR)
			sonarSuccess = currMK.getSensorControl().fetchSonarVal();
		if(currEvent != ChangeEvent.IR_MOD)
			modIrSuccess = currMK.getSensorControl().fetchAngleVal(true);
		if(currEvent != ChangeEvent.IR_UNMOD)
			unModIrSuccess = currMK.getSensorControl().fetchAngleVal(true);*/
		
		irModRead = currMK.getSensorControl().pingIr(true);
		irUnModRead = currMK.getSensorControl().pingIr(false);
		sonarRead = currMK.getSensorControl().pingSonar();
		
		inGoalRange = currMK.getMotionControl().inGoalRange();
		ballInFront = currMK.ballInFront(false);
		ballClose = currMK.ballClose(false);
		robotMoving = currMK.getMotionControl().robotMoving();
		robotTurning = currMK.getMotionControl().robotTurning();
		
		
		if(this.WonderState(currMK))
			return State.WONDER;
		else if(this.GotoBallState(currMK))
			return State.GOTO_BALL;
		else if(this.DribbleBallState(currMK))
			return State.DRIBBLE_TO_GOAL;
		else if(this.KickBallAtGoal(currMK))
			return State.KICK_BALL_TO_GOAL;
		else
			return State.INIT;
	}
	
	// Print the current state of the robot
	public void PrintState(State currState){
		switch(currState){
			case WONDER:
				System.out.println("In -WONDER- State");
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