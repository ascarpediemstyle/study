package com.example.marubatsu;

import com.example.marubatsu.Player.TypeDef;


public class GameManager {

	public int[] _boardAry;
	
	private OnComPlayEventListener _comPlayEventListener;
	public void setComPlayEventListener(OnComPlayEventListener comPlayEventListener) {
		_comPlayEventListener = comPlayEventListener;	}
	private Player _currentPlayer;
	
	Player _player1;
	Player _player2;
	
	public GameManager(){
		reflesh();
	}
	
	public void initPlayer(){
		_player1 = new Player(1,TypeDef.Player);
		_player2 = new Player(2,TypeDef.Com);
	}
	
	public void reflesh(){
		_boardAry = new int[]{-1,-1,-1,-1,-1,-1,-1,-1,-1};		
		initPlayer();
		_currentPlayer = _player1;
	}
	
	public void changeCurrentPlayer(){
		if(_currentPlayer.equals(_player1)){
			_currentPlayer = _player2;
		}else{
			_currentPlayer = _player1;
		}		
	}
	
	public void changeBoard(int cellNumber){
		int num = _currentPlayer.equals(_player1) ? 1:2;
		_boardAry[cellNumber] = num;
	}
	
	public int getCellResouceId(int cellNumber){		
		int num = _boardAry[cellNumber];
		int resId = -1;
		if(num==_player1.ID){
			resId = getPlayerResourceId(_player1);
		}
		else if(num==_player2.ID){
			resId = getPlayerResourceId(_player2);
		}		
		return resId;
	}
	
	public int getCurrentPlayerResourceId(){
		return getPlayerResourceId(_currentPlayer);
	}
	
	public int getPlayerResourceId(Player player){
		if(player.equals(_player1)){
			return R.drawable.maru;
		}else{
			return R.drawable.batsu;
		}
	}
	
	public boolean isFinish(){
		for(int i=0;i<_boardAry.length;++i){
			int num = _boardAry[i];
			if(num==-1){
				return false;
			}
		}
		return true;
	}
	
	public boolean isEmptyBoard(int cellNumber){
		return _boardAry[cellNumber]==-1;
	}
	
	public boolean isComTurn(){
		return (_currentPlayer.getPlayerType() == TypeDef.Com);			
	}	
	
	public void doComPlay(){
		_comPlayEventListener.onEvent();		
	}
}
