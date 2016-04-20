import globals.SoccerGlobals;
import lejos.hardware.motor.EV3LargeRegulatedMotor;
import lejos.hardware.port.MotorPort;
import lejos.hardware.port.SensorPort;
import lejos.robotics.navigation.Waypoint;

public class Kicker {
	private MotionControl mainMC;
	private SensorControl mainSC;
	
	
	public Kicker(){
		mainSC = new SensorControl(SensorPort.S2, SensorPort.S3);
		mainMC = new MotionControl(new EV3LargeRegulatedMotor(MotorPort.A), new EV3LargeRegulatedMotor(MotorPort.D), mainSC);
	}
	
	// Look around for the ball
	private boolean Wonder(){
		return mainMC.FindAndGrabBall();
	}
	
	private boolean GotoGoal(){
		mainMC.GotoWaypoint(new Waypoint((54*.775),(-42*.775)), true);
		return true;
	}
	
	public void Play(){
		// The ball was found, bring it to the goal
		if(Wonder()){
			GotoGoal();
			mainMC.StartMotionForward();
			mainMC.KickBall();
		}
		GotoGoal();
		//mainMC.DribbleBall();
	}
}
