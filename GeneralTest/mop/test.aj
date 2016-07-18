import base.*;
public aspect test{
	pointcut initPc(TestParent tp):call(void TestParent.ParentChangeVal())&&target(tp);
	pointcut otherPc(TestParent tp):cflow(initPc(tp))&&set(float ChildTest.val);
	//pointcut otherPc(ChildTest ct): set(float ChildTest.val)&&target(ct);

	
	
	
	before(TestParent tp):initPc(tp){
		System.out.println("test1");
	}
	
	before(TestParent tp):otherPc(tp){
		System.out.println("test2");
		System.out.println("test : "+tp.otherVal);
	}
}