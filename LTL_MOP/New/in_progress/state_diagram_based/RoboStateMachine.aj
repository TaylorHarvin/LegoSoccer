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
	private long lastStateCheck = System.currentTimeMillis();
	private final long PING_TIME_LIMIT = 10000;
	private boolean sonarSet = false;
	private boolean irModSet = false;
	private boolean irUnModSet = false;
	
	
	public boolean readyForStateCheck(){
		return (sonarSet && irModSet && irUnModSet);
	}
	
	public void resetStatePreCheck(){
		sonarSet = false;
		irModSet = false;
		irUnModSet = false;
	}
	
	// Generate the ball in front true event on-demand rather than through Kicker
	public void Kicker.generateBallInFrontState(){
		System.out.println("Generated BIF");
	}
	
	// Check the current ball in front state from the Kicker (without triggering any events)
	public boolean Kicker.checkBallInFront(Kicker currMK){
		return currMK.ballInFront(true);
	}
	
	
	// Generate the ball close true event on-demand rather than through Kicker
	public void Kicker.generateBallCloseState(){
		System.out.println("Generated Ball Close");
	}
	
	// Check the current ball close state from the Kicker (without triggering any events)
	public boolean Kicker.checkBallClose(Kicker currMK){
		return currMK.ballClose(true);
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
	
	
	
	// Trigger needed events for after turn to ball state
	pointcut turnto_ball_state_exit(Kicker MK) : call(public boolean Kicker.turnToBall()) && this(MK);
	
	
	//ADVICE SECTION*****************************************************************************
	
	
	// IR -- Mod advice, handle change in IR MOD value (after new ping)
	pointcut irModChange(Kicker MK) : cflowbelow(playPC(MK)) && set(float SensorControl.ballDirMod)&& within(SensorControl);
	// IR -- Mod advice, handle change in IR MOD value (after new ping)
	after(Kicker MK):irModChange(MK){
		irModSet = true;
		//System.out.println("Time Diff: "+(System.currentTimeMillis()-lastStateCheck));
		//if((System.currentTimeMillis()-lastStateCheck) > PING_TIME_LIMIT){
		if(readyForStateCheck()){
			lastStateCheck = System.currentTimeMillis();
			System.out.println("***IR MOD Changed***");
			State currState = StateCheck.GetState(ChangeEvent.IR_MOD, MK);
			MK.generateStateEvent(currState,MK);
			StateCheck.PrintState(currState);
			resetStatePreCheck();
		}
	}
	
	
	// IR -- Un-Mod advice, handle change in IR UN-MOD value (after new ping)
	pointcut irUnModChange(Kicker MK) : cflowbelow(playPC(MK)) && set(float SensorControl.ballDirUnMod)&& within(SensorControl);
	// IR -- Un-Mod advice, handle change in IR UN-MOD value (after new ping)
	after(Kicker MK):irUnModChange(MK){
		irUnModSet = true;
		//System.out.println("Time Diff: "+(System.currentTimeMillis()-lastStateCheck));
		//if((System.currentTimeMillis()-lastStateCheck) > PING_TIME_LIMIT){
		if(readyForStateCheck()){
			lastStateCheck = System.currentTimeMillis();
			System.out.println("***IR UN-MOD Changed***");
			//StateCheck.GetState(ChangeEvent.IR_UNMOD, MK);
			State currState = StateCheck.GetState(ChangeEvent.IR_UNMOD, MK);
			MK.generateStateEvent(currState,MK);
			StateCheck.PrintState(currState);
			resetStatePreCheck();
		}
	}
	
	// Sonar -- Sonar advice, handle change in Sonar value (after new ping)
	pointcut sonarChange(Kicker MK) : cflowbelow(playPC(MK)) && set(float SensorControl.sonarRead)&& within(SensorControl);
	// Sonar -- Sonar advice, handle change in Sonar value (after new ping)
	after(Kicker MK):sonarChange(MK){
		sonarSet = true;
		//System.out.println("Time Diff: "+(System.currentTimeMillis()-lastStateCheck));
		//if((System.currentTimeMillis()-lastStateCheck) > PING_TIME_LIMIT){
		if(readyForStateCheck()){
			lastStateCheck = System.currentTimeMillis();
			System.out.println("***Sonar Changed***");
			State currState = StateCheck.GetState(ChangeEvent.SONAR, MK);
			MK.generateStateEvent(currState,MK);
			StateCheck.PrintState(currState);
			resetStatePreCheck();
		}
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