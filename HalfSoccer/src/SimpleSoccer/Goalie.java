package SimpleSoccer;

import lejos.hardware.Button;
import lejos.hardware.motor.EV3LargeRegulatedMotor;
import lejos.hardware.port.MotorPort;
import lejos.hardware.port.SensorPort;
import lejos.robotics.SampleProvider;
import lejos.robotics.filter.MeanFilter;
import lejos.utility.Delay;
import lejos.hardware.sensor.*;

public class Goalie {
	public SoccerMotorMotion roboMotor;
	public HiTechnicCompass mainCompass;
	public final SensorMode baseDir;
	public float [] vals;
	public SampleProvider averageDir;
	public float baseDirVal = 0;
	public BallFinder ballFinder;
	
	//public EV3LargeRegulatedMotor a;
	
	
	public Goalie(){
		roboMotor = new SoccerMotorMotion(MotorPort.B,MotorPort.C, MotorPort.A);
		System.out.println("Press Enter for Direction");
		Button.ENTER.waitForPress();
		mainCompass = new HiTechnicCompass(SensorPort.S3);
		baseDir = mainCompass.getCompassMode();
		//baseDir.fetchSample(vals, 0);
		//System.out.println(vals[0]);
		averageDir = new MeanFilter(baseDir,5);
		vals = new float[averageDir.sampleSize()];
		averageDir.fetchSample(vals, 0);
		setBaseDirection();
		
	}
	
	public void setBaseDirection(){
		/*System.out.println("Hit Enter\nfor Direction");
		Button.waitForAnyPress();
		averageDir.fetchSample(vals, 0);
		baseDirVal = vals[0];
		if(baseDirVal+120 > 360){
			baseDirVal -= 360;
		}*/
		
		ballFinder = new BallFinder(SensorPort.S1, roboMotor);
		ballFinder.start();
	}
	
	
	public void start(){
		/*//Delay.msDelay(1500);
		Boolean keep_looking = true;
		setBaseDirection();
		roboMotor.turnLeft(SoccerMotorMotion.MEDIUM);
		
		
		averageDir.fetchSample(vals, 0);
		baseDirVal = (float) Math.toRadians(vals[0]);
		float baseDirLeft = baseDirVal + 120;
		
		float baseDirRight = baseDirVal - 120;
		
		do{
			averageDir.fetchSample(vals, 0);
			
			System.out.println(vals[0]);
			Delay.msDelay(50);
			if(Button.ENTER.isDown())
				keep_looking = false;
			if(vals[0] < 0){
				
			}
		}while(vals[0] < baseDirLeft && keep_looking);
		
		//roboMotor.stop();
		keep_looking = true;
		do{
			averageDir.fetchSample(vals, 0);
			roboMotor.turnRight(SoccerMotorMotion.MEDIUM);
			System.out.println(vals[0]);
			Delay.msDelay(50);
			if(Button.ENTER.isDown())
				keep_looking = false;
		}while(vals[0] > baseDirVal && keep_looking);
		// Turn 90 degrees left
		roboMotor.stop();
		System.out.println("done");
		System.out.println(baseDirVal);
		Delay.msDelay(10000);
		//roboMotor.stop();*/
	}
}
