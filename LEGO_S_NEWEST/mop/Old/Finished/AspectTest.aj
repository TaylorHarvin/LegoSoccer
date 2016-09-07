import java.io.*;
import java.util.*;
import fullSoccer.*;
public aspect AspectTest{
	public AspectTest(){
	}


	pointcut BallInFrontAtGotoBall_gotoball() : (call(public boolean GotoBall()));
	before () : BallInFrontAtGotoBall_gotoball() {
	}

	pointcut BallInFrontAtGotoBall_ballinfronttrue() : (call(public boolean BallInFront()));
	after () returning (boolean res) : BallInFrontAtGotoBall_ballinfronttrue() {
	}

}