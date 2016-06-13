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
		mainSC = new SensorControl(SensorPort.S2, SensorPort.S3, SensorPort.S4,simEnabled);
		mainMC = new MotionControl(new EV3LargeRegulatedMotor(MotorPort.A), new EV3LargeRegulatedMotor(MotorPort.D), mainSC,simEnabled);
	}
	
	/* Look around for the ball
	 * Preconditions: 
	 *	1. The ball is turned on and is reachable by the robot
	 * Postconditions:
	 * 	Return true
	 * 		1. The ball is now within the robot's arms
	 *  Return false
	 *  	1. The ball is not with the robot
	 *  		1.1. It is possible that robot goes to fast at goto and overshoots tries
	 *  		1.2. OR the ball was moved too many times during goto
	 */
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
	public boolean GotoGoal(boolean withBall){
		return mainMC.GotoWaypoint(new Waypoint(SoccerGlobals.GOAL_LOCATION.getX(),SoccerGlobals.GOAL_LOCATION.getY()), withBall);
		
	}
	
	
	// motion controller getter
	public MotionControl GetMotionControl(){
		return mainMC;
	}
	// sensor controller getter
	public SensorControl GetSensorControl(){
		return mainSC;
	}
	
	// NOTE: Might not be needed
	public void InitIR(){
		mainSC.GetAllIrSig();
	}
	
	
	/* Full soccer game
	 * Preconditions: 
	 *	1. motion controller and sensor controller initialized
	 *	2. ball is on the board and turned on
	 * Postconditions:
	 *	1. The ball has been kicked to the goal
	 */
	public void Play(){
		boolean ballKickedToGoal = false;
		//Wonder();
		while(!ballKickedToGoal){
			// The ball was found, bring it to the goal
			if(Wonder()){
				System.out.println("Wonder Worked");
				// If the robot is in the goal range with the ball -- kick the ball to the goal
				if(GotoGoal(true) && mainMC.InGoalRange())
					ballKickedToGoal = mainMC.KickAtGoal();
				//mainMC.StartMotionForward();
				//mainMC.KickBall();
			}
			System.out.println("Goal Shot: " + ballKickedToGoal);
		}
		//System.out.println("Goal Shot: " + GotoGoal(true));
		//mainMC.DribbleBall();
		System.out.println(mainSC.GetBallDirection());
	}
}
