package SimpleSoccer;

import lejos.hardware.Button;
import lejos.hardware.port.Port;
import lejos.hardware.port.SensorPort;
import lejos.hardware.port.UARTPort;
import lejos.hardware.sensor.EV3IRSensor;
import lejos.robotics.SampleProvider;
import lejos.utility.Delay;

public class BallFinder {
	EV3IRSensor irSensor;
	SampleProvider distance;
	float[] sample;
	public SoccerMotorMotion roboMotor;
	
	public BallFinder(Port s1, SoccerMotorMotion newRoboMotor){
		irSensor = new EV3IRSensor(s1);
		distance= irSensor.getMode("Distance");
		sample = new float[distance.sampleSize()];
		roboMotor = newRoboMotor;
	}
	
	public void start(){
		Boolean keepChecking = true;
		roboMotor.goForward(roboMotor.MEDIUM);
		do{
			distance.fetchSample(sample, 0);
			System.out.println(sample[0]);
			Delay.msDelay(50);
			if(Button.ENTER.isDown())
				keepChecking = false;
		}while(keepChecking && sample[0] > 7);
		roboMotor.goBackward(roboMotor.SLOW);
		Delay.msDelay(1000);
		roboMotor.goForward(roboMotor.FAST);
		Delay.msDelay(1000);
		roboMotor.hitBall();
		System.out.println("Done");
		roboMotor.stop();
		Delay.msDelay(10000);
		
	}
}
