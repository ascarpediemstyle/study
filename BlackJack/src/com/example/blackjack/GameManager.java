package com.example.blackjack;

import java.util.ArrayList;
import java.util.Random;

import android.content.ContentValues;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;

public class GameManager {

	private SQLiteDatabase _db;
	private ArrayList<Integer> _cards;
	
	public Player Player1;
	public Player DealerPlayer;
	
	public GameManager(SQLiteDatabase db){
		_db = db;
		initCards();
		shuffleCards();
		DealerPlayer = new Player("dealer");
		Player1 = new Player("me");
	}
	
	private void initCards(){
		_cards = new ArrayList<Integer>();
		for(int i=1;i<53;++i){
			_cards.add(i);
		}
	}
	
	public void dealToPlayer1(){
		deal(Player1);
	}
	
	public void dealToDealer(){
		deal(DealerPlayer);		
	}		
	
	private void deal(Player player){
		Card card = getCard();
		player.AddCard(card);
	}
	
	private Card getCard(){
		if(_cards.size()!=0){
			int num = _cards.get(0);
			_cards.remove(0);
			return new Card(num);
		}
		else
		{
			return null;
		}		
	}
	
	private boolean bursted(Player player){
		int n = player.getTotal();
		return (n > 21);
	}
	
	private void shuffleCards(){
		Random random = new Random();
		
		for(int i=0;i<1000;++i){
			int left = random.nextInt(_cards.size());
			int right = random.nextInt(_cards.size());
			
			int swap = _cards.get(left);
			_cards.set(left, _cards.get(right));
			_cards.set(right,swap);
		}
	}
	
	private void updateWinodds(int id,int odds) throws Exception{
    	ContentValues values = new ContentValues();
    	values.put(WinOddsTbl.ID.Name, "0");
    	values.put(WinOddsTbl.ODDS.Name, odds);
    	int colNum = _db.update(WinOddsTbl.TABLE_NAME, values, null, null);
    	if(colNum==0){
    		_db.insert(WinOddsTbl.TABLE_NAME,"",values);
    	}
    }
	
	private double readWinOdds(int targetId) throws Exception{
    	Cursor c = _db.query(WinOddsTbl.TABLE_NAME,new String[]{WinOddsTbl.ID.Name,WinOddsTbl.ODDS.Name},"",null,null,null,null);  	
    	
    	if(c.getCount() == 0) return 0.5;    	
    	
    	while(c.moveToNext()){
    		int id = c.getInt(WinOddsTbl.ID.No);
    		if(id==targetId){
    			double odds = c.getDouble(WinOddsTbl.ODDS.No);
    			return odds;
    		}    		
    	}
    	return 0.5;
    }
	
}
