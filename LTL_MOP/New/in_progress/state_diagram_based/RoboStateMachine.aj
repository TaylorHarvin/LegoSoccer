/* Developer: Taylor Harvin
 * Date Last Changed: 8/14/2016
 * Purpose: Provide state properties of the robot
 *
 */

import fullSoccer.*;
import stateTools.*;
import lejos.robotics.navigation.Waypoint;
import lejos.robotics.RegulatedMotor;
import lejos.hardware.motor.UnregulatedMotor;
import lejos.robotics.navigation.Navigator;
import lejos.hardware.sensor.EV3UltrasonicSensor;
import lejos.hardware.sensor.HiTechnicCompass;
import lejos.hardware.sensor.HiTechnicIRSeekerV2;
import lejos.robotics.SampleProvider;
import lejos.utility.Delay;

aspect RoboStateMachine{
	
	// Generate the ball in front true event on-demand rather than through Kicker
	public void Kicker.generateBallInFrontState(){
		System.out.println("Generated BIF");
	}
	
	// Check the current ball in front state from the Kicker (without triggering any events)
	public boolean Kicker.checkBallInFront(Kicker currMK){
		float[] sensorPack = new float[3];
		System.out.println("BIF CHECK RES: "+sensorPack[0]+" , "+sensorPack[1]+" , "+sensorPack[2]);
		return currMK.ballInFront(true,null);
	}
	
	// Generate the current state on-demand here rather than directly from state check method
	public void Kicker.generateStateEvent(State currState, Kicker currMK){
		switch(currState){
			case WONDER:
				System.out.println("GEN WONDER");
				// NOTE: Ensure that wonder event is triggered before BIF
				StateCheck.WonderState(currMK);
				break;
			case GOTO_BALL:
				System.out.println("GEN GOTO_BALL");
				StateCheck.GotoBallState(currMK);
				break;
			case TURN_TO_GOAL:
				System.out.println("GEN TURN_TO_GOAL");
				StateCheck.TurnToGoalState(currMK);
				break;
			case DRIBBLE_TO_GOAL:
				System.out.println("GEN DRIBBLE_TO_GOAL");
				StateCheck.DribbleBallState(currMK);
				break;
			case KICK_BALL_TO_GOAL:
				System.out.println("GEN KICK_BALL_TO_GOAL");
				StateCheck.KickBallAtGoal(currMK);
				break;
			default:
				System.out.println(currState);
				System.out.println("GEN NONE");
				break;
		}
		
	}
	
	
	
	
	
	//POINTCUT SECTION**************************************************************************
	// General pointcut to allow for access to Kicker object for other pointcuts (through cflowbelow)
	pointcut playPC(Kicker MK) : call(public void Kicker.play()) && target(MK);
	// IR -- Mod advice, handle change in IR MOD value (after new ping)
	pointcut irModChange(Kicker MK) : cflowbelow(playPC(MK)) && set(float SensorControl.ballDirMod);
	// IR -- Un-Mod advice, handle change in IR UN-MOD value (after new ping)
	pointcut irUnModChange(Kicker MK) : cflowbelow(playPC(MK)) && set(float SensorControl.ballDirUnMod);
	// Sonar -- Sonar advice, handle change in Sonar value (after new ping)
	pointcut sonarChange(Kicker MK) : cflowbelow(playPC(MK)) && set(float SensorControl.sonarRead);
	// Trigger needed events for after turn to ball state
	pointcut turnto_ball_state_exit(Kicker MK) : call(public boolean Kicker.turnToBall()) && this(MK);
	
	
	//ADVICE SECTION*****************************************************************************
	
	
	// IR -- Mod advice, handle change in IR MOD value (after new ping)
	after(Kicker MK):irModChange(MK){
		System.out.println("***IR MOD Changed***");
		State currState = StateCheck.GetState(ChangeEvent.IR_MOD, MK);
		MK.generateStateEvent(currState,MK);
		StateCheck.PrintState(currState);
	}
	
	

	// IR -- Un-Mod advice, handle change in IR UN-MOD value (after new ping)
	after(Kicker MK):irUnModChange(MK){
		
		System.out.println("***IR UN-MOD Changed***");
		//StateCheck.GetState(ChangeEvent.IR_UNMOD, MK);
		State currState = StateCheck.GetState(ChangeEvent.IR_UNMOD, MK);
		MK.generateStateEvent(currState,MK);
		StateCheck.PrintState(currState);
	}
	
	// Sonar -- Sonar advice, handle change in Sonar value (after new ping)
	after(Kicker MK):sonarChange(MK){
		System.out.println("***Sonar Changed***");
		State currState = StateCheck.GetState(ChangeEvent.SONAR, MK);
		MK.generateStateEvent(currState,MK);
		StateCheck.PrintState(currState);
	}
	
	
	
	// Trigger needed events for after turn to ball state
	after(Kicker MK):turnto_ball_state_exit(MK){
		System.out.println("TURN Event EXIT");
		
		//************BIF FAIL TEST**************
		System.out.println("MOVE BALL FOR FAIL -- NOW!");
		Delay.msDelay(5000);
		System.out.println("Delay Finished!");
		//***************************************
		
		// Generate ballinfront_true event if the ball is in front
		if(MK.checkBallInFront(MK))
			MK.generateBallInFrontState();
	}
}