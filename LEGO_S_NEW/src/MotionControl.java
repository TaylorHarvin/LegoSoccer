import lejos.hardware.motor.Motor;
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
	private CompassPoseProvider compassProv;
	private MovePilot movePilot;
	private Navigator roboMotor;			// Grid navigation handler
	PoseProvider posProv;
	SensorControl mainSC;
	MoveController baseMC;
	
	
	public MotionControl(RegulatedMotor leftMotor, RegulatedMotor rightMotor, SensorControl sc){
		// !!!NOTE: DIMS MAY BE WRONG FOR WHEEL!!!
		//float wheelDiam = 3.348;
		float wheelDiam = (float) 3.3;
		Wheel wheel1 = WheeledChassis.modelWheel(leftMotor, wheelDiam).offset(-7.6);
		Wheel wheel2 = WheeledChassis.modelWheel(rightMotor, 3.348 /*1.62*/).offset(7.6);
		Chassis chassis = new WheeledChassis(new Wheel[] { wheel1, wheel2 }, WheeledChassis.TYPE_DIFFERENTIAL);
		movePilot = new MovePilot(chassis);
		movePilot.setAngularSpeed(20);
		roboMotor = new Navigator(movePilot);
		posProv = roboMotor.getPoseProvider();
		mainSC = sc;
		
		baseMC = roboMotor.getMoveController();
	}
	
	public boolean GotoWaypoint(Waypoint destination, boolean fullControl){
		roboMotor.goTo(destination);
		// Allow the motion controller to determine full actions while going to waypoint
		if(fullControl){
			while(roboMotor.isMoving()){
				Delay.msDelay(50);
			}
		}
		return true;
	}
	
	public float GetRobotHeading(){
		return posProv.getPose().getHeading();
	}
	
	public float GetRobotX(){
		return posProv.getPose().getX();
	}
	
	
	public float GetRobotY(){
		return posProv.getPose().getY();
	}
	
	
	public void StartMotionForward(){
		baseMC.setLinearAcceleration(20);
		baseMC.forward();
	}
	
	public void StopMotion(){
		baseMC.stop();
	}
	
	
	public boolean TurnToBall(){
		float ballLoc = this.GetRobotHeading()+mainSC.GetBallDirection();
		System.out.println("Init Heading: "+this.GetRobotHeading());
		if(ballLoc > 180){
			ballLoc = ballLoc -180;
		}
		else if(ballLoc < -180){
			ballLoc = ballLoc + 180;
		}
		System.out.println("Final: " + ballLoc);
		this.GotoWaypoint(new Waypoint(this.GetRobotX(),this.GetRobotY(),ballLoc), true);
		while(!mainSC.BallInFront() && roboMotor.isMoving()){
			Delay.msDelay(50);
		}
		if(mainSC.BallInFront())
			return true;
		else
			return false;
	}
	
	
	public boolean GotoBall(){
		System.out.println("Start Goto");
		if(!mainSC.BallInFront()){
			return false;
		}
		else{ // Assumed that the ball is in front at this point -- good to go forward to it
			StartMotionForward();
			while((mainSC.BallInFront() && !mainSC.BallClose())){
				Delay.msDelay(50);
			}
			StopMotion();
			if(mainSC.BallClose()){
				System.out.println("Stop Goto");
				return true;
			}
			else{
				System.out.println("Stop Goto");
				return false;
			}
		}
		
	}
	
	public boolean FindAndGrabBall(){
		boolean ballGrabbable = false;
		boolean ballInFront = false;
		while(!ballGrabbable){
			// If the ball is in front of the robot -- goto it
			if(ballInFront)
				ballGrabbable = GotoBall();
			//
			if(!ballGrabbable)
				ballInFront = this.TurnToBall();
		}
		
		return true;
	}
	
}

