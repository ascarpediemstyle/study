package com.example.blackjack;

public class CardsManager {
	
	public enum Suit{
		SPADES(0,"spade"),
		HARTS(1,"hart"),
		DIAMONDS(2,"diamond"),
		CLUBS(3,"club")
		;
		
		private int _num;
		private String _name;
		private Suit(int num,String name){
			_num = num;
			_name = name;
		}
		
		@Override
		public String toString(){
			return _name;
		}
		
		public int getNum(){
			return _num;
		}		
	}
	
	public static Suit getSuit(int num){
		int i = num / 13;
		for(Suit suit : Suit.values()){
			if(i==suit.getNum()){
				return suit;
			}
		}
		return null;
	}
	
	public static int getNumber(int num){
		int i = num % 13;
		if(i==0){
			i = 13;
		}
		return i;
	}
	
	public static int getRank(int num){
		int rank = num;
		if(num > 10){
			rank = 10;
		}
		if(num == 1){
			rank = 10;
		}
		return rank;		
	}
	

}
