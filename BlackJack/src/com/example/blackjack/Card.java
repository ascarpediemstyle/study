package com.example.blackjack;

import com.example.blackjack.CardsManager.Suit;

public class Card {
	private final Suit _suit;	
	private final int _rank;
	private final int _number;
	private final int _originalNum;
	
	public Suit getSuit(){
		return _suit;
	}
	public int getNumber(){
		return _number;
	}
	public int getRank(){
		return _rank;
	}	
	
	public Card(int originalNum){
		_originalNum = originalNum;
		_suit = CardsManager.getSuit(_originalNum);
		_number = CardsManager.getNumber(_originalNum);
		_rank = CardsManager.getRank(_number);
	}
	
	public String toDisplayString(){
		String s = String.format("%s  %s", _suit.toString(),_number);
		return s;
	}
	
	public boolean isAce(){
		return (_number == 1);	
	}

}
