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
	
	public Kicker(){
		mainSC = new SensorControl(SensorPort.S2, SensorPort.S3, SensorPort.S3,simEnabled);
		mainMC = new MotionControl(new EV3LargeRegulatedMotor(MotorPort.A), new EV3LargeRegulatedMotor(MotorPort.D), mainSC,simEnabled);
	}
	
	// Look around for the ball
	public boolean Wonder(){
		/*boolean ballInFront = mainMC.GotoBall();
		while(!ballInFront){
			System.out.println("GOTO RES 1: "+ ballInFront);
			System.out.println("Turn RES 1: "+mainMC.TurnToBall());
			ballInFront = mainMC.GotoBall();
			System.out.println("Turn RES 2: "+mainMC.TurnToBall());
			ballInFront = mainMC.GotoBall();
			System.out.println("GOTO RES 2: "+ ballInFront);
			System.out.println("Turn RES 3: "+mainMC.TurnToBall());
			ballInFront = mainMC.GotoBall();
			System.out.println("GOTO RES 3: "+ ballInFront);
					
		}*/
		
		return mainMC.FindAndGrabBall();
		//return true;
	}
	
	public boolean GotoGoal(boolean withBall){
		return mainMC.GotoWaypoint(new Waypoint(SoccerGlobals.GOAL_LOCATION.getX(),SoccerGlobals.GOAL_LOCATION.getY()), withBall);
		
	}
	
	public void Play(){
		boolean ballKickedToGoal = false;
		boolean triggerLTLViolation = true;
		//Wonder();
		while(!ballKickedToGoal){
			// The ball was found, bring it to the goal
			if(Wonder()){
				System.out.println("Wonder Worked");
				if(!triggerLTLViolation)
					ballKickedToGoal = GotoGoal(true);
				else
					ballKickedToGoal = true;
				//mainMC.StartMotionForward();
				//mainMC.KickBall();
			}
			System.out.println("Goal Shot: " + ballKickedToGoal);
		}
		//System.out.println("Goal Shot: " + GotoGoal(true));
		//mainMC.DribbleBall();
		System.out.println(mainSC.GetBallDirection());
	}
	
	// PURE TEST
	/*public void Play(){
		GotoGoal(false);
		//while(mainMC.RobotMoving()){}
		//mainMC.GotoWaypoint(new Waypoint((150),(0)), false);
		while(mainMC.RobotMoving()){}
	}*/
	
}
