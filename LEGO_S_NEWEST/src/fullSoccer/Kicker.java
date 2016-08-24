package fullSoccer;
import lejos.hardware.motor.EV3LargeRegulatedMotor;
import lejos.hardware.port.MotorPort;
import lejos.hardware.port.SensorPort;
import lejos.robotics.navigation.Waypoint;
import lejos.utility.Delay;

public class Kicker {
	private MotionControl mainMC;
	private SensorControl mainSC;
	private boolean simEnabled = false;
	private final int MAX_GOTO_TRY = 50;	// robot going to ball tries
	
	
	public Kicker(){
		mainSC = new SensorControl(SensorPort.S2, SensorPort.S3, SensorPort.S4,simEnabled);
		mainMC = new MotionControl(MotorPort.A, MotorPort.D, MotorPort.C,simEnabled);
	}
	
	/* Full soccer game
	 * Preconditions: 
	 *	1. motion controller and sensor controller initialized
	 *	2. ball is on the board and turned on
	 * Postconditions:
	 *	1. The ball has been kicked to the goal
	 */
	public void play(){
		boolean ballKickedToGoal = false;
		//Wonder();
		while(!ballKickedToGoal){
			// The ball was found, bring it to the goal
			if(wonder()){
				System.out.println("Wonder Worked");
				// If the robot is in the goal range with the ball -- kick the ball to the goal
				if(gotoGoal(true) && mainMC.inGoalRange())
					ballKickedToGoal = kickAtGoal();
				//mainMC.StartMotionForward();
				//mainMC.KickBall();
			}
			System.out.println("Goal Shot: " + ballKickedToGoal);
		}
		//System.out.println("Goal Shot: " + GotoGoal(true));
		//mainMC.DribbleBall();
		//System.out.println(getBallDirection());
		
		
		//!!!TESTING!!!
			//mainSC.getAllIrSig();
			//System.out.println("ENDING");
			//Delay.msDelay(5000);
			//while(true)
			// !!!Ball in front after goto ball Direct TEST!!!
			/*gotoBall();
			ballInFront(true);
			System.out.println("Try Goto Again");
			Delay.msDelay(2000);
			gotoBall();
			ballInFront(true);*/
			
			//!!!Has Ball At Kick Test!!!
			/*System.out.println("Ball Kick TEST");
			Delay.msDelay(2000);
			this.ballKickable(true);
			this.ballInFront(true);
			this.kickBall(20, 100, 20, 100, 200, 1000);*/
			
			// Constructor error test
			//mainSC = new SensorControl(SensorPort.S2, SensorPort.S3, SensorPort.S4,true);
		
			// Goto LTL test -- stop calling goto after the ball is already in reach
			/*while(true)
				this.gotoBall();*/
			// BIF TEST
			//mainSC.getAllIrSig();
			// Goto Goal after successful wonder
				/*wonder();
				kickBall(20, 100, 20, 100, 200, 1000);
				gotoGoal(true);*/
			//ballInFront(true);
			// Wonder to gotoball state test
				//wonder();
				//ballInFront(true, null);
				
				/*this.turnToBall();
				this.gotoBall();*/
				/*mainSC.getAllIrSig();
				mainSC.fetchSonarVal();
				System.out.println("Sonar: "+mainSC.getLastSonar()+" , MOD: "+mainSC.getLastModIR()+" , UNMOD: "+mainSC.getLastUnModIR());
				System.out.println(ballInFront(true, null));*/
	}
	
	
	
	/* Head to the goal -- kick the ball to the goal if with ball
	 * Preconditions: 
	 *	1. motion controller and sensor controller initialized
	 *	2. if with ball => ball is in front
	 * Postconditions:
	 * 	Return true
	 * 		1. The ball was kicked to the goal -- if with ball
	 * 		2. The robot was in range of the goal
	 *  Return false
	 *  	1. The ball was lost at some point in going to the goal
	 */
	public boolean gotoGoal(boolean withBall){
		return gotoWaypoint(new Waypoint(SoccerGlobals.GOAL_LOCATION.getX(),SoccerGlobals.GOAL_LOCATION.getY()), withBall);
		
	}
	
	
	// motion controller getter
	public MotionControl getMotionControl(){
		return mainMC;
	}
	// sensor controller getter
	public SensorControl getSensorControl(){
		return mainSC;
	}
	
	// set the main motion controller
	public void setMotionControl(MotionControl newMC){
		mainMC = newMC;
	}
	
	
	// set the main sensor controller
	public void setSensorControl(SensorControl newSC){
		mainSC = newSC;
	}
	
	
	//***********************SENSOR CONTROL PARTS*******************
	/*	Averages the IR reads of the robot in relation to the ball signal
	 *	Preconditions: 
	 *		1. IR Seeker is initialized to the correct port
	 *		2. IR Seeker is functioning properly
	 *	Postconditions:
	 *		1. Returns averaged ball IR signal -- from mod and Un-Mod
	 *		1.1. Returns -1 (invalid) if both IR signals are invalid
	 */
	public float getBallDirection(){
		float avgDir = 0;	// Average reading from both IR signals
		int used = 0;		// Number of valid IR signal readings (max of 2)
		
		// Average both the Mod and Un-Mod
		if(mainSC.getAllIrSig()){
			// Add modulated IR to average
			if(!Float.isNaN(mainSC.getLastModIR())){
				avgDir += mainSC.getLastModIR();
				used++;
			}
			
			// Add un-modulated IR to average 
			if(!Float.isNaN(mainSC.getLastUnModIR())){
				avgDir += mainSC.getLastUnModIR();
				used++;
			}
			
			// If at least one IR is valid, return the average
			if(used > 0){
				avgDir = (avgDir/used)*-1;
				System.out.println(avgDir);
				return avgDir;
			}
			else{
				System.out.println("Invalid IR");
				return -1;
			}
		}
		else
			return -1;
		
	}
	
	
	
	/*	Tells if the ball is fully in the robot's arms
	 *	Preconditions: 
	 *		1. sonar is working
	 *	Postconditions:
	 *		1. Returns true
	 *			1.1. Ball is fully in the robot's arms
	 *				 and is as close to the robot's sonar as possible
	 *			1.1.1. OR another object is somehow in the robot's arm-span
	 *					-- IR could help check
	 *		2. Returns false
	 *			2.1. The ball is not within a the robot's arm-span (not in between the arms)
	 *				 and is as close to the robot's sonar as possible
	 *			2.1.1. OR sonar failed
	 */
	public boolean ballClose(boolean rePingSensor){
		boolean sonarSuccess = false;
		float sonarVal = -1;
		if(rePingSensor){
			sonarSuccess = mainSC.fetchSonarVal();
		}
		else{
			sonarSuccess = true;
		}
		sonarVal = mainSC.getLastSonar();
		// Check if sonar worked and grabbed sonar value
		if(sonarSuccess){
			// Check if the distance of an object is within the kick-able threshold
			if(sonarVal < SoccerGlobals.BALL_SONAR_DIST_GRAB)
				return true;
		}
		return false;
	}
	
	
	
	/*	Tells if the ball is close enough for a full kick
	 *	Preconditions: 
	 *		1. sonar is working
	 *		2. in general, the robot is assumed to be moving forward
	 *		   to generate more power to the kick
	 *	Postconditions:
	 *		1. Returns true
	 *			1.1. Ball is close enough for a full kick
	 *			1.1.1. OR another object is somehow in the robot's arm-span
	 *					-- IR could help check
	 *		2. Returns false
	 *			2.1. The ball is not within a the robot's arm-span (not in between the arms)
	 *			2.1.1. OR sonar failed
	 */
	public boolean ballKickable(boolean rePingSensor){
		boolean sonarSuccess = false;
		float sonarVal = -1;
		if(rePingSensor){
			sonarSuccess = mainSC.fetchSonarVal();
		}
		else{
			sonarSuccess = true;
		}
		sonarVal = mainSC.getLastSonar();
		// Check if sonar worked and grabbed sonar value
		if(sonarSuccess){
			// Check if the distance of an object is within the kick-able threshold
			if(sonarVal < SoccerGlobals.SONAR_OBJECT_KICKABLE)
				return true;
		}
		return false;
	}
	
	
	
	/*	Tells if the ball is in front of the robot
	 *	Preconditions: 
	 *		1. sonar and ir sensors are initialized and matched with correct ports
	 *		2. sonar and ir sensors are working
	 *	Postconditions:
	 *		1. Returns true (ball or object is aligned with the front of the robot)
	 *			1.1. Sonar says object is in the arms of the robot (not guaranteed to be the ball)
	 *			1.1.1. OR modulated IR or Unmodulated IR reads as 0
	 *		2. Returns false
	 *			2.1. Ball is out of range of the sonar
	 *			2.2. ball is either at an angle greater than 30 degrees from the front of the robot
	 *				 or the ball is not emitting a signal
	 *
	 */
	public boolean ballInFront(boolean rePingSensors){
		System.out.println("Ball In Front Ping?: "+rePingSensors);
		boolean sonarSuccess = false;
		boolean irSuccess = false;
		float sonarRead = -1;
		float irModRead = -1;
		float irUnModRead = -1;
		
		//************** Re-Ping Sensors if requested **************************//
		if(rePingSensors){
			//if(!Float.isNaN(mainSC.getLastSonar()))
			sonarSuccess = mainSC.fetchSonarVal();
			//if(!Float.isNaN(mainSC.getLastModIR()) || !Float.isNaN(mainSC.getLastUnModIR()))
			irSuccess = mainSC.getAllIrSig();
			
		}
		else{
			sonarSuccess = true;
			irSuccess = true;
		}
		sonarRead = mainSC.getLastSonar();
		irModRead = mainSC.getLastModIR();
		irUnModRead = mainSC.getLastUnModIR();
		
		
		
		
		
		//************** Sonar Check **************************//
		if(sonarSuccess){
			if(sonarRead < SoccerGlobals.BALL_SONAR_DIST_GRAB){
				System.out.println("Ball In Grab Dist: "+ mainSC.getLastSonar());
				return true;
			}
			System.out.println("Ball in Front Dist: "+ mainSC.getLastSonar());
		}
		
		
		//************** IR Check******************************//
		if(irSuccess){
			//************** IR Check -- Modulated*****************//
			if(!Float.isNaN((irModRead))){
				if(irModRead == 0){
					return true;
				}
			}
			
			//************** IR Check -- UnModulated***************//
			if(!Float.isNaN(irUnModRead)){
				if(irUnModRead == 0){
					return true;
				}
			}
		}
		return false;
	}
	
	
	//**************************MOTION CONTROL PARTS********************
	/*  Dribble ball -- slight tap moving forward assumed
	 *	Preconditions: 
	 *		1. Robot is moving forward
	 *		2. Ball is close enough to the robot for a dribble
	 *	Postconditions:
	 *		1. Taps the ball
	 */
	public void dribbleBall(){
		System.out.println("Dribble Ball");
		mainMC.openArm(200);
		mainMC.closeArm(200);
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
	public boolean gotoWaypoint(Waypoint destination, boolean withBall){
		//roboMotor.addWaypoint(destination);
		//roboMotor.followPath();
		mainMC.moveTo(destination);
		//roboMotor.goTo((float)destination.getX(), (float)destination.getY(), (float)destination.getHeading());
		float prevHeading = -1;			// Robot direction -- previous
		float currHeading = -1;			// Robot direction -- current
		boolean dribbleReady = false;
		
		// Allow the motion controller to determine full actions while going to waypoint
		if(withBall){
			//float distToGoalPoint = 9999;
			System.out.println("GOING TO GOAL");
			currHeading = mainMC.getRobotHeading();
			prevHeading = 9999;
			
			mainMC.setArmPower(0); // prevent an accidental dribble on the first move
			
			while(mainMC.robotMoving() && ballInFront(true)){
				
				currHeading = mainMC.getRobotHeading();
				
				// Only dribble the ball if the robot is moving forward
				// and the ball is close enough to dribble the ball
				if((Math.abs(Math.abs(prevHeading)-Math.abs(currHeading)) < 0.05) && (ballKickable(true))){
					// Setup dribble speeds
					if(!dribbleReady){
						System.out.println("Dribble Ready");
						mainMC.setArmPower(35);
						mainMC.setLinearSpeed(8);
						mainMC.setAngularSpeed(8);
						dribbleReady = true;
					}
					dribbleBall();
				}
				
				prevHeading = currHeading;
				if(mainMC.inGoalRange())
					return true;
				
			}
			mainMC.stopMotion();
		}
		else
			return true;
		
		
		return false;
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
	public boolean turnToBall(){
		float ballDir = getBallDirection();	// Current IR read
		float ballLoc = 0;							// Current ball angle in relation to the robot heading
		boolean ballIRInvalid = false;				// Recovery flag for an invalid current IR -- tell it to do 180 degree turn				
		
		if(ballDir != -1)
			ballLoc = mainMC.getRobotHeading()+ballDir;
		else{
			ballLoc = mainMC.getRobotHeading()+ 180;
			ballIRInvalid = true;
			System.out.println("Ball IR not found -- 180");
		}
		System.out.println("Init Heading: "+mainMC.getRobotHeading());
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
		mainMC.turnRobot(ballLoc);
		// Keep turning until the ball is in front of the robot or the robot hit it's original turn-to-point
		while(!ballInFront(true) && mainMC.robotMoving()){

			if(ballIRInvalid){
				// New ball direction found -- return for main to handle
				if(getBallDirection() != -1){
					return false;
				}
			}
			System.out.println("HEADING: " + mainMC.getRobotHeading());
		}
		mainMC.stopMotion();
		if(ballInFront(true)){
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
	public boolean gotoBall(){
		//movePilot.setAngularSpeed(5);
		mainMC.setLinearSpeed(10);
		System.out.println("Start Goto");
		if(!ballInFront(true)){
			return false;
		}
		else{ // Assumed that the ball is in front at this point -- good to go forward to it
			mainMC.startMotionForward(10);
			while((ballInFront(true) && !ballClose(true))){
				Delay.msDelay(50);
			}
			mainMC.stopMotion();
			if(ballClose(true)){
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
	public boolean wonder(){
		boolean ballGrabbable = false;	// Flag for the ball within the robot's arms
		boolean ballInFront = ballInFront(true);	// Flag for ball in front of the robot
		int gotoTry = 0;				// Count for ball grab attempts
		
		// Try to turn to the ball and goto it
		while(!ballGrabbable && gotoTry < MAX_GOTO_TRY){
			// If the ball is in front of the robot -- goto it
			if(ballInFront){
				System.out.println("ball in front -- GOTO");
				ballGrabbable = gotoBall();
				ballInFront = ballInFront(true);
				System.out.println("BIF: "+ ballInFront);
				gotoTry++;
			}
			
			// Check if the ball essentially moved
			if(!ballInFront || !ballGrabbable || !ballClose(true)){
				System.out.println("Ball not in front -- after GOTO");
				ballInFront = this.turnToBall();
				ballGrabbable = false;
			}
		}
		System.out.println("END WONDER");
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
	public void kickBall(int oldArmPower,int newArmPower, int oldRobotSpeed,int newRobotSpeed, int armDelay, int forwardDelay){
		System.out.println("Kicking");
		mainMC.setArmPower(newArmPower);
		mainMC.setLinearSpeed(newRobotSpeed);
		mainMC.setAngularSpeed(newRobotSpeed);
		
		//baseMC.forward();
		mainMC.startMotionForward(newRobotSpeed);
		Delay.msDelay(forwardDelay);
		mainMC.openArm(armDelay);
		mainMC.closeArm(armDelay);
		mainMC.stopMotion();
		
		// Restore old speeds
		mainMC.setArmPower(oldArmPower);
		mainMC.setLinearSpeed(oldRobotSpeed);
		mainMC.setAngularSpeed(oldRobotSpeed);
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
	public boolean kickAtGoal(){
		// Setup a goal kick if the robot is close enough to the goal
		// and the robot still has the ball
		if(mainMC.inGoalRange()){
			boolean goalHitStatus = false;
			System.out.println("In Goal Range");
			
			// Kick the ball to the goal if the robot has the ball 
			if(ballKickable(true)){
				kickBall(35,100,40,1000,200,700);
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
