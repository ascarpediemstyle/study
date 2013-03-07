package com.example.blackjack;

import java.util.ArrayList;

public class Player {
	public String Name;
	ArrayList<Card> _cards;
	private boolean _hasStand;	
	
	public Player(String name){
		Name = name;
		_cards = new ArrayList<Card>();
		_hasStand = false;
	}
	
	public void Stand(){
		_hasStand = true;
	}
	
	public boolean Standed(){
		return _hasStand;
	}
	
	public void AddCard(Card card){
		_cards.add(card);
	}
	
	public int getTotal(){
		int sum = 0;
		for(Card card : _cards){
			sum += card.getRank();
			if(sum > 21 && card.isAce()){
				sum -= 9;
			}
		}
		return sum;
	}
	
	public String getCardsString(){
		String str = "";
		for(Card card : _cards){
			str += card.toDisplayString();
			str += "\n";
		}
		
		return str;
	}

}
