package fullSoccer;
import lejos.hardware.DeviceException;
import lejos.hardware.motor.EV3LargeRegulatedMotor;
import lejos.hardware.motor.UnregulatedMotor;
import lejos.hardware.port.MotorPort;
import lejos.hardware.port.Port;
//import lejos.robotics.DirectionFinder;
//import lejos.robotics.DirectionFinderAdapter;
import lejos.robotics.RegulatedMotor;
import lejos.robotics.chassis.Chassis;
import lejos.robotics.chassis.Wheel;
import lejos.robotics.chassis.WheeledChassis;
//import lejos.robotics.localization.CompassPoseProvider;
import lejos.robotics.localization.PoseProvider;
import lejos.robotics.navigation.MoveController;
import lejos.robotics.navigation.MovePilot;
import lejos.robotics.navigation.Navigator;
import lejos.robotics.navigation.Waypoint;
import lejos.utility.Delay;

public class MotionControl {
	private MovePilot movePilot;			// handles base properties for the navigator
	public Navigator roboMotor;				// Grid navigation handler
	PoseProvider posProv;					// provides the robot's position in waypoint terms
	MoveController baseMC;					// direct motor control -- NOTE: MAY BE REMOVED
	//private CompassPoseProvider compassProv;// compass
	private RegulatedMotor leftMotor;
	private RegulatedMotor rightMotor;
	private UnregulatedMotor arm;			// robot kicking arm
	
	public enum Dir  {FORWARD,BACKWARD};
	
	
	/*  Constructor for the motion controller
	 *	Preconditions: 
	 *		1. left and right motors are initialized
	 *		2. sensor controller is initialized
	 *	Postconditions:
	 *		1. Navigator initialized with the correct dimentions
	 *		2. Position provider initialized
	 */
	public MotionControl(Port lMotorPort, Port rMotorPort,Port armPort, boolean simEnabled){
		// !!!NOTE: DIMS MAY BE WRONG FOR WHEEL!!!
		//float wheelDiam = 3.348;
		if(!simEnabled){
			float wheelDiam = (float) /*3.3*/4.746;
			float trackWidth = (float) 6.6 /*7.6*/;
			
			try{
				if(leftMotor == null && rightMotor == null && arm == null){
					leftMotor = new EV3LargeRegulatedMotor(lMotorPort);
					rightMotor = new EV3LargeRegulatedMotor(rMotorPort);
					arm = new UnregulatedMotor(armPort);
				}
				else{
					System.out.println("MotionControl ports already in use!");
				}
			}
			catch(DeviceException portError){
				System.out.println("Motion ports already setup!");
				System.out.println("Closing MotionControl Setup");
				return;
			}
			
			
			
			Wheel wheel1 = WheeledChassis.modelWheel(leftMotor, wheelDiam).offset(-1*trackWidth);
			Wheel wheel2 = WheeledChassis.modelWheel(rightMotor, wheelDiam /*1.62*/).offset(trackWidth);
			Chassis chassis = new WheeledChassis(new Wheel[] { wheel1, wheel2 }, WheeledChassis.TYPE_DIFFERENTIAL);
			movePilot = new MovePilot(chassis);
			roboMotor = new Navigator(movePilot);

			//DirectionFinderAdapter df = new DirectionFinderAdapter(mainSC.compassSP);
			
			//compassProv = new CompassPoseProvider(movePilot,df);
			//roboMotor.setPoseProvider(compassProv);
			
			posProv = roboMotor.getPoseProvider();
			
			baseMC = roboMotor.getMoveController();
			
			// Set the start speeds of motors
			movePilot.setAngularSpeed(10);
			arm.setPower(40);
		}
		else{
			
		}
	}
	
	public boolean robotTurning(){
		float leftMotorSpeed = leftMotor.getRotationSpeed();
		float rightMotorSpeed = rightMotor.getRotationSpeed();
		
		if(leftMotorSpeed > 0 && rightMotorSpeed < 0)
			return true;
		else if(leftMotorSpeed < 0 && rightMotorSpeed > 0)
			return true;
		else
			return false;
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
	public boolean robotMoving(){
		return roboMotor.isMoving();
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
	public float getRobotHeading(){
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
	public float getRobotX(){
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
	public float getRobotY(){
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
	public void startMotionForward(int speed){
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
	public void stopMotion(){
		//baseMC.stop();
		roboMotor.stop();
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
	public boolean inGoalRange(){
		float distToGoalPoint = (float) Math.sqrt(
				Math.pow(SoccerGlobals.GOAL_LOCATION.getX() - this.getRobotX(), 2) +
	            Math.pow(SoccerGlobals.GOAL_LOCATION.getY() - this.getRobotY(), 2) );
		
		System.out.println("Goal Range: "+ distToGoalPoint);
		if(distToGoalPoint <= SoccerGlobals.GOAL_RANGE_THRESHOLD){
			return true;
		}
		else
			return false;
	}
	
	public void setArmPower(int newArmPower){
		arm.setPower(newArmPower);
	}
	
	public void setLinearSpeed(int newLinearSpeed){
		movePilot.setLinearSpeed(newLinearSpeed);
	}
	
	
	public void setAngularSpeed(int newAngularSpeed){
		movePilot.setAngularSpeed(newAngularSpeed);
	}
	
	public void openArm(int armDelay){
		arm.backward();
		Delay.msDelay(armDelay);
	}
	
	public void closeArm(int armDelay){
		arm.forward();
		Delay.msDelay(armDelay);
	}
	
	public void turnRobot(float newHeading){
		roboMotor.rotateTo(newHeading);
	}
	
	public void moveTo(Waypoint destination){
		roboMotor.clearPath();			// Ensure that no other waypoints exist
		roboMotor.goTo(destination);
	}
	
}