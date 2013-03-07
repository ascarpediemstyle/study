package com.example.blackjack;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

public class DBHelper extends SQLiteOpenHelper  {	

	private final static String DB_FILE_NAME = "blackjack.db";
	private final static int DB_VERSION = 1;
	
	public DBHelper(Context context){
		super(context,DB_FILE_NAME,null,DB_VERSION);
	}
	@Override
	public void onCreate(SQLiteDatabase db) {
		StringBuilder sql = new StringBuilder();
		sql.append(String.format("CREATE TABLE IF NOT EXISTS %s(",WinOddsTbl.TABLE_NAME));
		sql.append(String.format("%s number primary key,%s number)",WinOddsTbl.ID.Name,WinOddsTbl.ODDS.Name));
		db.execSQL(sql.toString());		
	}

	@Override
	public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
		
		
	}

}