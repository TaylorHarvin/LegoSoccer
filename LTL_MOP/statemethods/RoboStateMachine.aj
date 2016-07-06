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
		boolean successfulIrRead = GetSensorControl().GetAllIrSig();
		//successfulSonarRead = GetSensorControl().fetchSonarVal();
		boolean ballClose = GetSensorControl().BallClose();
		
		if(successfulIrRead){
			float irModRead = GetSensorControl().GetLastModIR();
			float irUnModRead = GetSensorControl().GetLastUnModIR();
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
		boolean robotMoving = GetMotionControl().RobotMoving();
		boolean ballInFront = GetSensorControl().BallInFront();
		boolean ballClose = GetSensorControl().BallClose();
		
		float irModRead = GetSensorControl().GetLastModIR();
		float irUnModRead = GetSensorControl().GetLastUnModIR();
		float sonarRead = GetSensorControl().GetLastSonar();
		
		// Check if the robot should remain in the goto ball state
		if(ballInFront && robotMoving && !ballClose)
			return true;
		else
			return false;
	}
	
	// Turning to goal state
	public boolean Kicker.TurnToGoalState(){
		boolean robotMoving = GetMotionControl().RobotMoving();
		boolean robotTurning = GetMotionControl().RobotTurning();
		boolean ballInFront = GetSensorControl().BallInFront();
		boolean ballClose = GetSensorControl().BallClose();
		
		float irModRead = GetSensorControl().GetLastModIR();
		float irUnModRead = GetSensorControl().GetLastUnModIR();
		float sonarRead = GetSensorControl().GetLastSonar();
		
		// Ball should remain in front of the robot while turning
		// NOTE: Need turning check
		if(ballInFront && ballClose && robotTurning)
			return true;
		else
			return false;
	}
	
	
	public boolean Kicker.DribbleBallState(){
		boolean inGoalRange = GetMotionControl().InGoalRange();
		boolean ballInFront = GetSensorControl().BallInFront();
		boolean ballClose = GetSensorControl().BallClose();
		
		float irModRead = GetSensorControl().GetLastModIR();
		float irUnModRead = GetSensorControl().GetLastUnModIR();
		float sonarRead = GetSensorControl().GetLastSonar();
		
		// Ball should be near and in front robot while moving to goal
		if(!inGoalRange && ballInFront && ballClose)
			return true;
		else
			return false;
	}
	
	
	// Kick state
	public boolean Kicker.KickBallAtGoal(){
		boolean inGoalRange = GetMotionControl().InGoalRange();
		boolean ballInFront = GetSensorControl().BallInFront();
		boolean ballClose = GetSensorControl().BallClose();
		
		float irModRead = GetSensorControl().GetLastModIR();
		float irUnModRead = GetSensorControl().GetLastUnModIR();
		float sonarRead = GetSensorControl().GetLastSonar();
		
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
	
	
	
	// IR -- Mod 
	pointcut irModChange() : set(float SensorControl.ballDirMod);
	
	// IR -- UnMod
	pointcut irUnModChange() : set(float SensorControl.ballDirUnMod);
	
	// Sonar
	pointcut sonarChange() : set(float[] SensorControl.distanceSample);
	
	
	
	//***************SENSOR SETUPS************************
	// Sonar sensor setup
	pointcut sonarSensorSetup() : set(EV3UltrasonicSensor SensorControl.sonarSensor);
	
	// IR sensor setup
	pointcut irSensorSetup(): set(HiTechnicIRSeekerV2 SensorControl.irSensor);
	
	// Compass sensor setup
	pointcut compassSensorSetup(): set(HiTechnicCompass SensorControl.compassSensor);
	
	//***************SAMPLE SETUPS************************
	
	
	// IR Mod sampler
	pointcut irSeekModeModSetup():set(SampleProvider SensorControl.irSeekModeMod);
	
	// IR Un-Mod sampler
	pointcut irSeekModeUnModSetup():set(SampleProvider SensorControl.irSeekModeUnMod);
	
	// Compass sampler
	pointcut compassSPSetup():set(SampleProvider SensorControl.compassSP);
	
	
	//***************MOTOR SETUPS*************************
	// Arm setup
	pointcut armSetup():set(UnregulatedMotor MotionControl.arm);
	
	// Left motor setup
	pointcut leftMotorSetup():set(RegulatedMotor MotionControl.leftMotor);
	
	// Right motor setup
	pointcut rightMotorSetup():set(RegulatedMotor MotionControl.rightMotor);
	
	// roboMotor setup
	pointcut roboMotorSetup():set(Navigator MotionControl.roboMotor);
	
	// roboMotor Motion Check -- Internal boolean for Navigator (LeJOS API)
	pointcut roboMotorMoving():set(Navigator Navigator._keepGoing);
	
	
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