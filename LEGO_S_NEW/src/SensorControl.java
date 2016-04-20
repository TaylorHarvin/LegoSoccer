import globals.SoccerGlobals;
import lejos.hardware.motor.EV3MediumRegulatedMotor;
import lejos.hardware.port.Port;
import lejos.hardware.sensor.EV3UltrasonicSensor;
import lejos.hardware.sensor.HiTechnicIRSeekerV2;
import lejos.robotics.SampleProvider;
import lejos.utility.Delay;


public class SensorControl {
	private EV3UltrasonicSensor sonarSensor;	// Actual Sonar sensor
	private HiTechnicIRSeekerV2 irSensor;		// Actual IR Seeker
	private SampleProvider irSeekModeMod;		// Gets value for modulated IR
	private SampleProvider irSeekModeUnMod;		// Gets value for unmodulated IR
	private SampleProvider distMode;			// Gets value for sonar
	private float[] distanceSample;				// The actual sonar value -- RAW
	private float[] irSample;					// The actual IR value -- RAW
	private final float BALL_SONAR_DIST_GRAB = (float) 0.08;	// Sonar value threshold for grabbing the ball
	
	public SensorControl(Port sonarPort, Port irPort){
		sonarSensor = new EV3UltrasonicSensor(sonarPort);
		irSensor = new HiTechnicIRSeekerV2(irPort);
		distMode = sonarSensor.getDistanceMode();
		distanceSample = new float[distMode.sampleSize()];
		irSeekModeMod = irSensor.getModulatedMode();
		irSeekModeUnMod = irSensor.getUnmodulatedMode();
		irSample = new float[irSeekModeMod.sampleSize()];
	}
	
	
	// Get the ball angle relative to the robot
	public float fetchAngleVal(boolean modulated){
		if(modulated)
			irSeekModeMod.fetchSample(irSample, 0);
		else
			irSeekModeUnMod.fetchSample(irSample, 0);
		//System.out.println(irSample[0]);
		Delay.msDelay(50);
		return irSample[0];
	}
	
	public float GetBallDirection(){
		float avgDir = 0;
		int used = 0;
		float[] irVals = new float[2];
		fetchSonarVal();
		irVals = getAllIrSig();
		if(!Float.isNaN(irVals[0])){
			avgDir += irVals[0];
			used++;
		}
		if(!Float.isNaN(irVals[1])){
			avgDir += irVals[1];
			used++;
		}
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
	
	// Get the ball distance value relative to the robot
	public float fetchSonarVal(){
		distMode.fetchSample(distanceSample, 0);
		//System.out.println(distanceSample[0]);
		Delay.msDelay(50);
		return distanceSample[0];
	}
	
	public float[] getAllIrSig(){
		float[] vals = new float[2];
		float ballDirMod = fetchAngleVal(true);
		float ballDirUnMod = fetchAngleVal(false);
		vals[0] = ballDirMod;
		vals[1] = ballDirUnMod;
		return vals;
	}
	
	
	public boolean BallClose(){
		float sonar = 0;
		sonar = fetchSonarVal();
		if(sonar < BALL_SONAR_DIST_GRAB)
			return true;
		else
			return false;
	}
	
	public boolean BallInFront(){
		boolean ballFound = false;
		float sonar = 0;
		sonar = fetchSonarVal();
		if(sonar < BALL_SONAR_DIST_GRAB)
			return true;
		boolean modInFront = false;
		boolean unModInFront = false;
		boolean unModInRange = false;
		boolean modInRange = false;
		float[] vals = getAllIrSig();
		float ballDirMod = vals[0];
		float ballDirUnMod = vals[1];

		
		if(!Float.isNaN((ballDirMod))){
			if(ballDirMod == 0){
				modInFront = true;
			}
			/*else if(ballDirMod >= 0 && ballDirMod <= 30){
				modInRange = true;
			}*/
		}
			
		if(!Float.isNaN(ballDirUnMod)){
			if(ballDirUnMod == 0){
				unModInFront = true;
			}
			/*else if(ballDirUnMod >= 0 && ballDirUnMod <= 30){
				unModInRange = true;
			}*/
		}
		if((modInFront || unModInFront || sonar < SoccerGlobals.SONAR_OBJECT_SEEN) /*|| (modInFront && unModInRange)||(unModInFront && modInRange)*/)
			ballFound = true;
		//System.out.println(ballFound);
		return ballFound;
	}
	
	
	
}
