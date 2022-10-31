package com.herbmall.test;

/*
 싱글톤 패턴(SingleTon)
  - 인스턴스를 하나만 생성해서 사용하는 패턴
  - 인스턴스의 개수를 하나로 제한하는 패턴
 */
public class Person {
	/*
	 [1] 생성자를 private로 => new연산자를 사용하여, 객체 생성 불가
	 [2] static get 메서드 만들기
	 [3] static 변수 만들기 (클래스 차원에서 하나만 만들어져서 모든 객체가 공유)
	 	- 멤버변수로 Person을 담을 수 있는 instance 변수를 만든다
	 	- static으로 지저앻서 한 개만 만들어지게 한다
	 */
	
	//static변수
	private static Person instance;
	
	//private 생성자
	private Person() {
		
	}
	
	//static get메서드
	public static Person getInstance() {
		if(instance==null) {
			instance=new Person();
		}
		return instance;
	}
	
	public void showInfo() {
		System.out.println("Person의 메서드");
	}
}
