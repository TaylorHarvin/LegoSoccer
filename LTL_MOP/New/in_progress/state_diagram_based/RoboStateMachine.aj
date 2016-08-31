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
	
	//*************PC Flags************************
	private boolean bifFlag = false;
	private boolean bcFlag = false;
	private boolean bKickable = false;
	//*********************************************
	
	public boolean readyForStateCheck(){
		return (sonarSet && irModSet && irUnModSet);
		//return true;
	}
	
	public void resetStatePreCheck(){
		sonarSet = false;
		irModSet = false;
		irUnModSet = false;
		bifFlag = false;
		bcFlag = false;
		bKickable = false;
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
			case TURN_TO_BALL:
				System.out.println("GEN TURN_TO_BALL");
				// NOTE: Ensure that wonder event is triggered before BIF
				StateCheck.TurnToBallState(currMK);
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
	pointcut ballInFrontPC(Kicker MK) : call(public boolean Kicker.ballInFront(boolean)) && target(MK);
	pointcut ballClosePC(Kicker MK) : call(public boolean Kicker.ballClose(boolean)) && target(MK);
	pointcut ballKickablePC(Kicker MK) : call(public boolean Kicker.ballKickable(boolean)) && target(MK);
	//ADVICE SECTION*****************************************************************************
	
	//BIF -- Cflow Section******************************************************************************
	// IR -- Mod advice, handle change in IR MOD value (after new ping)
	pointcut irModChange_BIF(Kicker MK) : cflowbelow(ballInFrontPC(MK)) && set(float SensorControl.ballDirMod)&& within(SensorControl);
	// IR -- Mod advice, handle change in IR MOD value (after new ping)
	after(Kicker MK):irModChange_BIF(MK){
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
	pointcut irUnModChange_BIF(Kicker MK) : cflowbelow(ballInFrontPC(MK)) && set(float SensorControl.ballDirUnMod)&& within(SensorControl);
	// IR -- Un-Mod advice, handle change in IR UN-MOD value (after new ping)
	after(Kicker MK):irUnModChange_BIF(MK){
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
	pointcut sonarChange_BIF(Kicker MK) : cflowbelow(ballInFrontPC(MK)) && set(float SensorControl.sonarRead)&& within(SensorControl);
	// Sonar -- Sonar advice, handle change in Sonar value (after new ping)
	after(Kicker MK):sonarChange_BIF(MK){
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
	//****************************************************************************************************
	
	
	//Ball Close -- Cflow Section******************************************************************************
	// IR -- Mod advice, handle change in IR MOD value (after new ping)
	pointcut irModChange_BC(Kicker MK) : cflowbelow(ballClosePC(MK)) && set(float SensorControl.ballDirMod)&& within(SensorControl);
	// IR -- Mod advice, handle change in IR MOD value (after new ping)
	after(Kicker MK):irModChange_BC(MK){
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
	pointcut irUnModChange_BC(Kicker MK) : cflowbelow(ballClosePC(MK)) && set(float SensorControl.ballDirUnMod)&& within(SensorControl);
	// IR -- Un-Mod advice, handle change in IR UN-MOD value (after new ping)
	after(Kicker MK):irUnModChange_BC(MK){
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
	pointcut sonarChange_BC(Kicker MK) : cflowbelow(ballClosePC(MK)) && set(float SensorControl.sonarRead)&& within(SensorControl);
	// Sonar -- Sonar advice, handle change in Sonar value (after new ping)
	after(Kicker MK):sonarChange_BC(MK){
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
	//*****************************************************************************************************************************
	
	
	//Ball Kickable -- Cflow Section******************************************************************************
	// IR -- Mod advice, handle change in IR MOD value (after new ping)
	pointcut irModChange_bk(Kicker MK) : cflowbelow(ballKickablePC(MK)) && set(float SensorControl.ballDirMod)&& within(SensorControl);
	// IR -- Mod advice, handle change in IR MOD value (after new ping)
	after(Kicker MK):irModChange_bk(MK){
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
	pointcut irUnModChange_bk(Kicker MK) : cflowbelow(ballKickablePC(MK)) && set(float SensorControl.ballDirUnMod)&& within(SensorControl);
	// IR -- Un-Mod advice, handle change in IR UN-MOD value (after new ping)
	after(Kicker MK):irUnModChange_bk(MK){
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
	pointcut sonarChange_bk(Kicker MK) : cflowbelow(ballKickablePC(MK)) && set(float SensorControl.sonarRead)&& within(SensorControl);
	// Sonar -- Sonar advice, handle change in Sonar value (after new ping)
	after(Kicker MK):sonarChange_bk(MK){
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
	//*****************************************************************************************************************************
	
	
	
	// Trigger needed events for after turn to ball state
	pointcut turnto_ball_state_exit(Kicker MK) : call(public boolean Kicker.turnToBall()) && this(MK);
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
	
	
	after(Kicker MK):ballInFrontPC(MK){
		bifFlag = true;
	}
	
	
	after(Kicker MK):ballClosePC(MK){
		bcFlag = true;
	}
	
	
	after(Kicker MK):ballKickablePC(MK){
		bKickable = true;
	}
}