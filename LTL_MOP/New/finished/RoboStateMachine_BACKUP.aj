/* Developer: Taylor Harvin
 * Date Last Changed: 7/06/2016
 * Purpose: Provide state properties of the robot
 *
 */

import fullSoccer.*;
import lejos.robotics.navigation.Waypoint;
import lejos.robotics.RegulatedMotor;
import lejos.hardware.motor.UnregulatedMotor;
import lejos.robotics.navigation.Navigator;
import lejos.hardware.sensor.EV3UltrasonicSensor;
import lejos.hardware.sensor.HiTechnicCompass;
import lejos.hardware.sensor.HiTechnicIRSeekerV2;
import lejos.robotics.SampleProvider;

aspect RoboStateMachine{
	public enum State {
		INIT, WONDER, GOTO_BALL, TURN_TO_GOAL, DRIBBLE_TO_GOAL,
		KICK_BALL_TO_GOAL, GAME_OVER
	}
	
	
	
	// NOTE: Returning true => that the robot should be in this state
	public boolean Kicker.WonderState(){
		//boolean successfulIrRead = getSensorControl().getAllIrSig();
		//successfulSonarRead = getSensorControl().fetchSonarVal();
		boolean ballClose = ballClose(false);
		float irModRead = getSensorControl().getLastModIR();
		float irUnModRead = getSensorControl().getLastUnModIR();
		
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
	public boolean Kicker.GotoBallState(){
		boolean robotMoving = getMotionControl().robotMoving();
		boolean ballInFront = ballInFront(false);
		boolean ballClose = ballClose(false);
		
		float irModRead = getSensorControl().getLastModIR();
		float irUnModRead = getSensorControl().getLastUnModIR();
		float sonarRead = getSensorControl().getLastSonar();
		
		// Check if the robot should remain in the goto ball state
		if(ballInFront && robotMoving && !ballClose)
			return true;
		else
			return false;
	}
	
	// Turning to goal state
	public boolean Kicker.TurnToGoalState(){
		boolean robotMoving = getMotionControl().robotMoving();
		boolean robotTurning = getMotionControl().robotTurning();
		boolean ballInFront = ballInFront(false);
		boolean ballClose = ballClose(false);
		
		float irModRead = getSensorControl().getLastModIR();
		float irUnModRead = getSensorControl().getLastUnModIR();
		float sonarRead = getSensorControl().getLastSonar();
		
		// Ball should remain in front of the robot while turning
		// NOTE: Need turning check
		if(ballInFront && ballClose && robotTurning)
			return true;
		else
			return false;
	}
	
	
	public boolean Kicker.DribbleBallState(){
		boolean inGoalRange = getMotionControl().inGoalRange();
		boolean ballInFront = ballInFront(false);
		boolean ballClose = ballClose(false);
		
		float irModRead = getSensorControl().getLastModIR();
		float irUnModRead = getSensorControl().getLastUnModIR();
		float sonarRead = getSensorControl().getLastSonar();
		
		// Ball should be near and in front robot while moving to goal
		if(!inGoalRange && ballInFront && ballClose)
			return true;
		else
			return false;
	}
	
	
	// Kick state
	public boolean Kicker.KickBallAtGoal(){
		boolean inGoalRange = getMotionControl().inGoalRange();
		boolean ballInFront = ballInFront(false);
		boolean ballClose = ballClose(false);
		
		float irModRead = getSensorControl().getLastModIR();
		float irUnModRead = getSensorControl().getLastUnModIR();
		float sonarRead = getSensorControl().getLastSonar();
		
		// Ball should be with the robot and in the goal range until kick
		if(inGoalRange && ballInFront && ballClose)
			return true;
		else
			return false;
		
	}
	
	
	// Get the state of the robot
	// NOTE: This may be the incorrect way of doing this -- depending on what is needed
	public State Kicker.GetState(){
		if(this.WonderState())
			return State.WONDER;
		else if(this.GotoBallState())
			return State.GOTO_BALL;
		else if(this.DribbleBallState())
			return State.DRIBBLE_TO_GOAL;
		else if(this.KickBallAtGoal())
			return State.KICK_BALL_TO_GOAL;
		else
			return State.INIT;
	}
	
	pointcut playPC(Kicker MK) : call(public void Kicker.play()) && target(MK);
	pointcut getBallDirectionPC(Kicker MK) : call(public void Kicker.getBallDirection()) && target(MK);
	pointcut ballClosePC(Kicker MK) : call(public void Kicker.ballClose(boolean)) && target(MK);
	pointcut ballKickablePC(Kicker MK) : call(public void Kicker.ballKickable(boolean)) && target(MK);
	pointcut ballInFrontPC(Kicker MK) : call(public void Kicker.ballInFront(boolean)) && target(MK);
	pointcut gotoWaypointPC(Kicker MK) : call(public void Kicker.gotoWaypoint(Waypoint, boolean)) && target(MK);
	pointcut turnToBallPC(Kicker MK) : call(public void Kicker.turnToBall()) && target(MK);
	pointcut gotoBallPC(Kicker MK) : call(public void Kicker.gotoBall()) && target(MK);
	pointcut wonderPC(Kicker MK) : call(public void Kicker.wonder()) && target(MK);
	
	// IR -- Mod 
	pointcut irModChange(Kicker MK) : cflowbelow(playPC(MK)) && set(float SensorControl.ballDirMod);
	after(Kicker MK):irModChange(MK){
		System.out.println("!!!IR Changed!!!");
		MK.GetState();
		//MK.WonderState();
		//MK.ballInFront(false);
	}
	
	
	// IR -- UnMod
	pointcut irUnModChange(Kicker MK) :cflowbelow(getBallDirectionPC(MK)) && set(float SensorControl.ballDirUnMod);
	after(Kicker MK):irUnModChange(MK){
		System.out.println("!!!IR Changed!!!");
		MK.GetState();
	}
	
	// Sonar
	pointcut sonarChange(Kicker MK) : cflowbelow(ballClosePC(MK)) && set(float[] SensorControl.distanceSample);
	after(Kicker MK):sonarChange(MK){
		System.out.println("!!!Sonar Changed!!!");
		MK.GetState();
	}
	
	
	//***************SENSOR SETUPS************************
	// Sonar sensor setup
	//pointcut sonarSensorSetup(Kicker MK) : cflowbelow(playPC(MK)) && set(EV3UltrasonicSensor SensorControl.sonarSensor);
	//after(Kicker MK):sonarSensorSetup(MK){}
	
	
	
	// IR sensor setup
	//pointcut irSensorSetup(Kicker MK): cflowbelow(playPC(MK)) && set(HiTechnicIRSeekerV2 SensorControl.irSensor);
	//after(Kicker MK):irSensorSetup(MK){}
	
	
	// Compass sensor setup
	//pointcut compassSensorSetup(Kicker MK): cflowbelow(playPC(MK)) && set(HiTechnicCompass SensorControl.compassSensor);
	//after(Kicker MK):compassSensorSetup(MK){
		
	//}
	
	
	
	//***************SAMPLE SETUPS************************
	
	
	// IR Mod sampler
	pointcut irSeekModeModSetup(Kicker MK):cflowbelow(playPC(MK)) && set(SampleProvider SensorControl.irSeekModeMod);
	after(Kicker MK):irSeekModeModSetup(MK){
		System.out.println("!!!IR SampleProvider - MOD!!!");
		MK.GetState();
	}
	
	
	
	// IR Un-Mod sampler
	pointcut irSeekModeUnModSetup(Kicker MK):cflowbelow(playPC(MK)) && set(SampleProvider SensorControl.irSeekModeUnMod);
	after(Kicker MK):irSeekModeUnModSetup(MK){
		System.out.println("!!!IR SampleProvider - UN_MOD!!!");
		MK.GetState();
	}
	
	
	
	
	// Compass sampler
	//pointcut compassSPSetup(Kicker MK):cflowbelow(playPC(MK)) && set(SampleProvider SensorControl.compassSP);
	//after(Kicker MK):compassSPSetup(MK){}
	
	
	
	//***************MOTOR SETUPS*************************
	// Arm setup
	pointcut armSetup(Kicker MK):cflowbelow(playPC(MK)) && set(UnregulatedMotor MotionControl.arm);
	after(Kicker MK):armSetup(MK){
		System.out.println("!!!ARM Setup!!!");
		MK.GetState();
	}
	
	
	
	// Left motor setup
	pointcut leftMotorSetup(Kicker MK):cflowbelow(playPC(MK)) && set(RegulatedMotor MotionControl.leftMotor);
	after(Kicker MK):leftMotorSetup(MK){
		System.out.println("!!!LEFT MOTOR!!!");
		MK.GetState();
	}
	
	
	
	// Right motor setup
	pointcut rightMotorSetup(Kicker MK):cflowbelow(playPC(MK)) && set(RegulatedMotor MotionControl.rightMotor);
	after(Kicker MK):rightMotorSetup(MK){
		System.out.println("!!!RIGHT MOTOR!!!");
		MK.GetState();
	}
	
	
	
	// roboMotor setup
	pointcut roboMotorSetup(Kicker MK):cflowbelow(playPC(MK)) && set(Navigator MotionControl.roboMotor);
	after(Kicker MK):roboMotorSetup(MK){
		System.out.println("!!!ROBO MOTOR!!!");
		MK.GetState();
	}
	
	
	
	
	// roboMotor Motion Check -- Internal boolean for Navigator (LeJOS API)
	//pointcut roboMotorMoving(Kicker MK):cflowbelow(playPC(MK)) && set(Navigator Navigator._keepGoing);
	//after(Kicker MK):roboMotorMoving(MK){}
	
	
	
	
	
	
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