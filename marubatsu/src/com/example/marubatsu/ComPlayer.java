package com.example.marubatsu;

import java.util.Random;

public class ComPlayer {

	private static Random _random = new Random();
	public ComPlayer() {
		// TODO Auto-generated constructor stub
	}
	
	public static int getNextCellNumber(){
		GameManager manager = MainActivity.getGameManager();
		int number = _random.nextInt(9);
		if(!manager.isEmptyBoard(number)){
			number = getNextCellNumber();
		}
		return number;
	}	
}
