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
	public SensorControl mainSC;			// handles all sensor value pulls
	MoveController baseMC;					// direct motor control -- NOTE: MAY BE REMOVED
	private CompassPoseProvider compassProv;// compass
	
	
	
	/*  Constructor for the motion controller
	 *	Preconditions: 
	 *		1. left and right motors are initialized
	 *		2. sensor controller is initialized
	 *	Postconditions:
	 *		1. Returns true
	 *			1. Navigator initialized with the correct dimentions
	 *			2. Position provider initialized
	 */
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
			//DirectionFinderAdapter df = new DirectionFinderAdapter(mainSC.compassSP);
			
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
	
	/*  Dribble ball -- slight tap moving forward assumed
	 *	Preconditions: 
	 *		1. Robot is moving forward
	 *		2. Ball is close enough to the robot for a dribble
	 *	Postconditions:
	 *		1. Taps the ball
	 */
	public void DribbleBall(){
		System.out.println("Dribble Ball");
		arm.backward();
		Delay.msDelay(200);
		arm.forward();
		Delay.msDelay(200);
	}
	
	
	
	/*  Tells if the main motors are moving
	 *	Preconditions: 
	 *		1. roboMotor is initialized
	 *		2. Motors are functioning
	 *	Postconditions:
	 *		1. Returns true
	 *			1.1. The robot is moving
	 *		2. Returns false
	 *			2.1. The robot is not moving
	 */
	public boolean RobotMoving(){
		return roboMotor.isMoving();
	}
	
	
	/*  The robot moves to a given point (if to the goal -- then it dribbles the ball)
	 *	Preconditions: 
	 *		1. If withBall => Ball is in front of the robot
	 *		2. Destination within the field area
	 *		3. All sensors and motors are properly functioning
	 *	Postconditions:
	 *		1. Returns true
	 *			1.1. The robot has the ball in it's arms
	 *		2. Returns false
	 *			2.1. The ball was moved.
	 *			2.2. OR The ball angle read was originally incorrect
	 *			2.3. OR The robot hit (NOT KICK) the ball enough to make it loose the ball
	 */
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
				if((Math.abs(Math.abs(prevHeading)-Math.abs(currHeading)) < 0.05) && (mainSC.BallKickable())){
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
				if(InGoalRange())
					return true;
				
			}
			roboMotor.stop();
		}
		else
			return true;
		
		
		return false;
	}
	
	/* Returns the current heading of the robot
	 * Note -- it is sometimes invalid
	 *	Preconditions: 
	 *		1. Position provider (posProv) initialized
	 *		2. All prior positions reported have been valid
	 *	Postconditions:
	 *		Returns
	 *			1. The heading of the robot (in degrees)
	 */
	public float GetRobotHeading(){
		return posProv.getPose().getHeading();
	}
	
	
	/* Returns the current x position of the robot
	 * Note -- it is sometimes invalid
	 *	Preconditions: 
	 *		1. Position provider (posProv) initialized
	 *		2. All prior positions reported have been valid
	 *	Postconditions:
	 *		Returns
	 *			1. The X position of the robot on the grid
	 */
	public float GetRobotX(){
		return posProv.getPose().getX();
	}
	
	
	/* Returns the current y position of the robot
	 * Note -- it is sometimes invalid
	 *	Preconditions: 
	 *		1. Position provider (posProv) initialized
	 *		2. All prior positions reported have been valid
	 *	Postconditions:
	 *		Returns
	 *			1. The Y position of the robot on the grid
	 */
	public float GetRobotY(){
		return posProv.getPose().getY();
	}
	
	
	
	/* Basic forward motion of the robot at the given speed
	 * NOTE: this overrides the Navigator API
	 *		 it is possible that this causes issues with positioning
	 *	Preconditions: 
	 *		1. Given speed is valid
	 *	Postconditions:
	 *		1. Main motors are set at the same speed
	 *		2. Main motors are moving in the forward direction
	 */
	public void StartMotionForward(int speed){
		//movePilot.setLinearAcceleration(speed);
		movePilot.setLinearSpeed(speed);
		movePilot.forward();
	}
	
	
	/* Halt all motor motion
	 * NOTE: this overrides the Navigator API
	 *		 it is possible that this causes issues with positioning
	 *	Preconditions: 
	 *		1. Main motors moving
	 *	Postconditions:
	 *		1. Main motors stop
	 */
	public void StopMotion(){
		//baseMC.stop();
		this.movePilot.stop();
	}
	
	
	
	
	/* Turn the robot towards the ball
	 * NOTE: it will fail if the ball moves at all or the 
	 * original IR sensor value may be inaccurate
	 *	Preconditions: 
	 *		1. IR is valid
	 *		2. All motors are functioning properly
	 *	Postconditions:
	 *		1. Returns true
	 *			1.1. The ball is in front of the robot
	 *		2. Returns false
	 *			2.1. The ball is not in front of the robot
	 *				2.1.1. The ball was probably moved
	 */
	public boolean TurnToBall(){
		float ballDir = mainSC.GetBallDirection();	// Current IR read
		float ballLoc = 0;							// Current ball angle in relation to the robot heading
		boolean ballIRInvalid = false;				// Recovery flag for an invalid current IR -- tell it to do 180 degree turn				
		
		if(ballDir != -1)
			ballLoc = this.GetRobotHeading()+ballDir;
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
		
		// Keep turning until the ball is in front of the robot or the robot hit it's original turn-to-point
		while(!mainSC.BallInFront() && RobotMoving()){

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
	
	

	/*	Go to the ball -- only if it is in front of the robot
	 *	Preconditions: 
	 *		1. Ball is in front of the robot
	 *		2. All sensors and motors are properly functioning
	 *	Postconditions:
	 *		1. Returns true
	 *			1.1. The robot has the ball in it's arms
	 *		2. Returns false
	 *			2.1. The ball was moved.
	 *			2.2. OR The ball angle read was originally incorrect
	 *			2.3. OR The robot hit (NOT KICK) the ball enough to make it loose the ball
	 */
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
				return true;
			}
			else{
				System.out.println("Stop Goto -- Ball Not Close");
				return false;
			}
		}
		
	}
	
	
	/*	Handle turn to ball and goto ball
	 *	Preconditions: 
	 *		1. Ball is turned on
	 *		2. All motors and sensors initiated and functioning
	 *		3. Motors set to a reasonable speed
	 *	Postconditions:
	 *		1. Returns true
	 *			1.1. The robot has the ball in it's arms
	 *		2. Returns false
	 *			2.1. The ball was never found by the robot.
	 *			2.2. OR The robot's speed is too fast to successfully goto the ball
	 */
	public boolean FindAndGrabBall(){
		boolean ballGrabbable = false;	// Flag for the ball within the robot's arms
		boolean ballInFront = false;	// Flag for ball in front of the robot
		int gotoTry = 0;				// Count for ball grab attempts
		
		// Try to turn to the ball and goto it
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
	
	
	/*	Kick the ball and then return the speeds to original
	 *	Preconditions: 
	 *		1. The ball is kickable
	 *		2. All motors are connected and functioning
	 *		3. Valid speeds given
	 *		4. Valid power given
	 *		5. Delay given does not exceed an unrealistic value
	 *	Postconditions:
	 *		1. The ball has been kicked
	 *		2. Original motor speeds and power are reset back the original
	 */
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
	
	
	
	
	/*	Check if the robot is close enough to the goal for a proper kick
	 *	Preconditions: 
	 *		1. The robot's position tracking up to this point has been accurate 
	 *	Postconditions:
	 *		1. Returns true
	 *			1.1. The robot is within a specified goal range threshold
	 *		2. Returns false
	 *			2.1. The robot is within a specified goal range threshold
	 *
	 */
	public boolean InGoalRange(){
		float distToGoalPoint = (float) Math.sqrt(
				Math.pow(SoccerGlobals.GOAL_LOCATION.getX() - this.GetRobotX(), 2) +
	            Math.pow(SoccerGlobals.GOAL_LOCATION.getY() - this.GetRobotY(), 2) );
		
		System.out.println("Goal Range: "+ distToGoalPoint);
		if(distToGoalPoint <= SoccerGlobals.GOAL_RANGE_THRESHOLD){
			return true;
		}
		else
			return false;
	}
	
	
	
	
	
	/*	Performs a full kick of the ball towards the goal
	 *	Preconditions: 
	 *		1. The robot is within range of the goal
	 *		2. The ball is within kickable range from the robot
	 *			2.1. The ball should be somewhere in the robot's arms
	 *	Postconditions:
	 *		1. Returns true
	 *			1.1. Ball is kicked towards the goal.
	 *			1.2. Ball is now rolling towards the goal
	 *		2. Returns false
	 *			2.1. The robot is not in the range of the goal
	 *			2.2. OR The ball was not in kickable range from the robot
	 *
	 */
	public boolean KickAtGoal(){
		// Setup a goal kick if the robot is close enough to the goal
		// and the robot still has the ball
		if(InGoalRange()){
			boolean goalHitStatus = false;
			System.out.println("In Goal Range");
			
			// Kick the ball to the goal if the robot has the ball 
			if(mainSC.BallKickable()){
				KickBall(35,100,40,1000,200,700);
				goalHitStatus = true;
				System.out.println("Kicking at Goal");
			}
			else{
				System.out.println("Ball out of robot range");
				goalHitStatus = false;
			}
			return goalHitStatus;
		}
		else
			return false;
	}
	
	
}

