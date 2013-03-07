package com.example.marubatsu;

public class Player {
	
	public enum TypeDef{
		Player,
		Com,
	};
	
	public int ID;
	private TypeDef _playerType;
	public TypeDef getPlayerType() {
		return _playerType;
	}
	
	
	public Player(int id,TypeDef playerType){
		ID = id;
		_playerType = playerType;
	}
	
	@Override
	public boolean equals(Object obj){
		return ((Player)obj).ID == this.ID;		
	}



}
