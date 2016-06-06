package fullSoccer;
import lejos.hardware.motor.EV3LargeRegulatedMotor;
import lejos.hardware.motor.EV3MediumRegulatedMotor;
import lejos.hardware.motor.Motor;
import lejos.hardware.motor.UnregulatedMotor;
import lejos.hardware.port.MotorPort;
import lejos.robotics.DirectionFinder;
import lejos.robotics.DirectionFinderAdapter;
import lejos.robotics.RegulatedMotor;
import lejos.robotics.chassis.Chassis;
import lejos.robotics.chassis.Wheel;
import lejos.robotics.chassis.WheeledChassis;
import lejos.robotics.localization.CompassPoseProvider;
import lejos.robotics.localization.PoseProvider;
import lejos.robotics.navigation.MoveController;
import lejos.robotics.navigation.MovePilot;
import lejos.robotics.navigation.Navigator;
import lejos.robotics.navigation.Waypoint;
import lejos.utility.Delay;

public class MotionControl {
	private final int MAX_GOTO_TRY = 50;	// robot going to ball tries
	private MovePilot movePilot;			// handles base properties for the navigator
	public Navigator roboMotor;				// Grid navigation handler
	private UnregulatedMotor arm;			// robot kicking arm
	PoseProvider posProv;					// provides the robot's position in waypoint terms
	public SensorControl mainSC;					// handles all sensor value pulls
	MoveController baseMC;					// direct motor control -- NOTE: MAY BE REMOVED
	private CompassPoseProvider compassProv;
	
	// LTL VIOLATION FLAGS
	boolean TRIGGER_KICKABLE_LTL_VIOLATION = false;
	boolean TRIGGER_PRE_GOAL_RANGE_LTL_VIOLATION = true;
	boolean TRIGGER_BALL_CLOSE_AT_GOTO_LTL_VIOLATION = false;
	boolean TRIGGER_STOP_AT_BALL_LTL_VIOLATION = false;
	
	
	public MotionControl(RegulatedMotor leftMotor, RegulatedMotor rightMotor, SensorControl sc, boolean simEnabled){
		// !!!NOTE: DIMS MAY BE WRONG FOR WHEEL!!!
		//float wheelDiam = 3.348;
		if(!simEnabled){
			float wheelDiam = (float) /*3.3*/4.746;
			float trackWidth = (float) 6.6 /*7.6*/;
			
			Wheel wheel1 = WheeledChassis.modelWheel(leftMotor, wheelDiam).offset(-1*trackWidth);
			Wheel wheel2 = WheeledChassis.modelWheel(rightMotor, wheelDiam /*1.62*/).offset(trackWidth);
			Chassis chassis = new WheeledChassis(new Wheel[] { wheel1, wheel2 }, WheeledChassis.TYPE_DIFFERENTIAL);
			movePilot = new MovePilot(chassis);
			roboMotor = new Navigator(movePilot);
			mainSC = sc;
			DirectionFinderAdapter df = new DirectionFinderAdapter(mainSC.compassSP);
			
			//compassProv = new CompassPoseProvider(movePilot,df);
			//roboMotor.setPoseProvider(compassProv);
			arm = new UnregulatedMotor(MotorPort.C);
			posProv = roboMotor.getPoseProvider();
			
			baseMC = roboMotor.getMoveController();
			
			// Set the start speeds of motors
			movePilot.setAngularSpeed(10);
			arm.setPower(40);
		}
		else{
			
		}
	}
	
	// Dribble ball -- slight tap moving forward assumed
	public void DribbleBall(){
		System.out.println("Dribble Ball");
		arm.backward();
		Delay.msDelay(200);
		arm.forward();
		Delay.msDelay(200);
	}
	
	public boolean RobotMoving(){
		return roboMotor.isMoving();
	}
	
	public boolean GotoWaypoint(Waypoint destination, boolean withBall){
		roboMotor.clearPath();			// Ensure that no other waypoints exist
		//roboMotor.addWaypoint(destination);
		//roboMotor.followPath();
		roboMotor.goTo(destination);
		//roboMotor.goTo((float)destination.getX(), (float)destination.getY(), (float)destination.getHeading());
		float prevHeading = -1;			// Robot direction -- previous
		float currHeading = -1;			// Robot direction -- current
		boolean dribbleReady = false;
		
		// Allow the motion controller to determine full actions while going to waypoint
		if(withBall){
			float distToGoalPoint = 9999;
			System.out.println("GOING TO GOAL");
			currHeading = posProv.getPose().getHeading();
			prevHeading = 9999;
			
			arm.setPower(0); // prevent an accidental dribble on the first move
			
			while(RobotMoving() && mainSC.BallInFront()){
				
				currHeading = this.GetRobotHeading();
				
				// Only dribble the ball if the robot is moving forward
				// and the ball is close enough to dribble the ball
				if((Math.abs(Math.abs(prevHeading)-Math.abs(currHeading)) < 0.05) && (TRIGGER_KICKABLE_LTL_VIOLATION || mainSC.BallKickable())){
					// Setup dribble speeds
					if(!dribbleReady){
						System.out.println("Dribble Ready");
						arm.setPower(35);
						movePilot.setLinearSpeed(8);
						movePilot.setAngularSpeed(8);
						dribbleReady = true;
					}
					DribbleBall();
				}
				
				prevHeading = currHeading;
				if(InGoalRange() || TRIGGER_PRE_GOAL_RANGE_LTL_VIOLATION)
					return true;
				
			}
			roboMotor.stop();
		}
		else
			return true;
		
		
		return false;
	}
	
	// Returns the current heading of the robot
	// Note -- it is sometimes invalid
	public float GetRobotHeading(){
		return posProv.getPose().getHeading();
	}
	
	// Returns the current x position of the robot
	// Note -- it is sometimes invalid
	public float GetRobotX(){
		return posProv.getPose().getX();
	}
	
	
	// Returns the current y position of the robot
	// Note -- it is sometimes invalid
	public float GetRobotY(){
		return posProv.getPose().getY();
	}
	
	
	// Basic forward motion of the robot at the given speed
	// NOTE: this overrides the Navigator API
	//		 it is possible that this causes issues with positioning
	public void StartMotionForward(int speed){
		//movePilot.setLinearAcceleration(speed);
		movePilot.setLinearSpeed(speed);
		movePilot.forward();
	}
	
	
	// Halt all motor motion
	// NOTE: this overrides the Navigator API
	//		 it is possible that this causes issues with positioning
	public void StopMotion(){
		//baseMC.stop();
		this.movePilot.stop();
	}
	
	
	
	// Turn the robot towards the ball
	// NOTE: it will fail if the ball moves at all or the 
	// original IR sensor value may be inaccurate
	public boolean TurnToBall(){
		float ballDir = mainSC.GetBallDirection();
		float ballLoc = 0;
		boolean ballIRInvalid = false;
		boolean searchForIR = true;
		
		if(ballDir != -1)
			ballLoc = this.GetRobotHeading()+mainSC.GetBallDirection();
		else{
			ballLoc = this.GetRobotHeading()+ 180;
			ballIRInvalid = true;
			System.out.println("Ball IR not found -- 180");
		}
		System.out.println("Init Heading: "+this.GetRobotHeading());
		/*if(ballLoc < 0)
			ballLoc -= SoccerGlobals.IR_ERROR_ANGLE;
		else if(ballLoc > 0)
			ballLoc += SoccerGlobals.IR_ERROR_ANGLE;*/
		
		if(ballLoc > 180){
			ballLoc = ballLoc - 180;
		}
		else if(ballLoc < -180){
			ballLoc = ballLoc + 180;
		}
		System.out.println("Final: " + ballLoc);
		
		//this.GotoWaypoint(new Waypoint(this.GetRobotX(),this.GetRobotY(),ballLoc), false);
		roboMotor.rotateTo(ballLoc);
		while(!mainSC.BallInFront() && RobotMoving() && searchForIR){

			if(ballIRInvalid){
				// New ball direction found -- return for main to handle
				if(mainSC.GetBallDirection() != -1){
					return false;
				}
			}
			System.out.println("HEADING: " + this.GetRobotHeading());
		}
		StopMotion();
		if(mainSC.BallInFront()){
			return true;
		}
		else
			return false;
	}
	
	
	// Go to the ball -- only if it is in front of the robot
	public boolean GotoBall(){
		//movePilot.setAngularSpeed(5);
		movePilot.setLinearSpeed(5);
		
		System.out.println("Start Goto");
		if(!mainSC.BallInFront()){
			return false;
		}
		else{ // Assumed that the ball is in front at this point -- good to go forward to it
			StartMotionForward(10);
			while((mainSC.BallInFront() && !mainSC.BallClose())){
				Delay.msDelay(50);
			}
			StopMotion();
			if(mainSC.BallClose()){
				System.out.println("Stop Goto -- Ball Close");
				// Only for Ball remains in front after goto ball violation testing
				if(TRIGGER_BALL_CLOSE_AT_GOTO_LTL_VIOLATION){
					System.out.println("Attempt LTL Violation NOW");
					Delay.msDelay(3000);
					System.out.println("Returning Goto");
				}
				
				// Ball close -- but this can ignore that for violation testing
				// true => normal behavior
				if(!TRIGGER_STOP_AT_BALL_LTL_VIOLATION)
					return true;
				else
					return false;
			}
			else{
				System.out.println("Stop Goto -- Ball Not Close");
				return false;
			}
		}
		
	}
	
	// Handle turn to ball and goto ball
	public boolean FindAndGrabBall(){
		boolean ballGrabbable = false;
		boolean ballInFront = false;
		int gotoTry = 0;
		
		while(!ballGrabbable && gotoTry < MAX_GOTO_TRY){
			// If the ball is in front of the robot -- goto it
			if(ballInFront){
				System.out.println("ball in front -- GOTO");
				ballGrabbable = GotoBall();
				ballInFront = mainSC.BallInFront();
				System.out.println("BIF: "+ ballInFront);
				gotoTry++;
			}
			
			// Check if the ball essentially moved
			if(!ballInFront || !ballGrabbable || !mainSC.BallClose()){
				System.out.println("Ball not in front -- after GOTO");
				ballInFront = this.TurnToBall();
				ballGrabbable = false;
			}
		}
		
		return ballGrabbable;
	}
	
	
	// Kick the ball and then return the speeds to original
	public void KickBall(int oldArmPower,int newArmPower, int oldRobotSpeed,int newRobotSpeed, int armDelay, int forwardDelay){
		arm.setPower(newArmPower);
		movePilot.setLinearSpeed(newRobotSpeed);
		movePilot.setAngularSpeed(newRobotSpeed);
		//baseMC.forward();
		this.StartMotionForward(newRobotSpeed);
		Delay.msDelay(forwardDelay);
		arm.backward();
		Delay.msDelay(armDelay);
		arm.forward();
		Delay.msDelay(armDelay);
		
		// Restore old speeds
		roboMotor.stop();
		arm.setPower(oldArmPower);
		movePilot.setLinearSpeed(oldRobotSpeed);
		movePilot.setAngularSpeed(oldRobotSpeed);
	}
	
	
	public boolean InGoalRange(){
		float distToGoalPoint = (float) Math.sqrt(
				Math.pow(SoccerGlobals.GOAL_LOCATION.getX() - this.GetRobotX(), 2) +
	            Math.pow(SoccerGlobals.GOAL_LOCATION.getY() - this.GetRobotY(), 2) );
		
		System.out.println("Goal Range: "+ distToGoalPoint);
		if(distToGoalPoint <= SoccerGlobals.GOAL_RANGE_THRESHOLD && mainSC.BallInFront()){
			return true;
		}
		else
			return false;
	}
	
	
	public boolean KickAtGoal(){
		// Setup a goal kick if the robot is close enough to the goal
		// and the robot still has the ball
		if(InGoalRange()){
			boolean goalHitStatus = false;
			System.out.println("In Goal Range");
			
			
			
			// Kick the ball to the goal if the robot has the ball 
			if(TRIGGER_KICKABLE_LTL_VIOLATION || mainSC.BallKickable()){
				if(TRIGGER_KICKABLE_LTL_VIOLATION){
					System.out.println("Attempt Kickable LTL VIOLATION -- NOW");
					Delay.msDelay(3000);
				}
				KickBall(35,100,40,1000,200,700);
				goalHitStatus = true;
				System.out.println("Kicking at Goal");
			}
			else{
				System.out.println("Ball out of robot range");
				goalHitStatus = false;
			}
			
			// Stop the robot and reset speed
			
			movePilot.setLinearSpeed(40);
			movePilot.setAngularSpeed(40);
			arm.setPower(40);
			return goalHitStatus;
		}
		else
			return false;
	}
	
	
}

