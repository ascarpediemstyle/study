package com.example.blackjack;

import com.example.blackjack.DBHelper;

import android.os.Bundle;
import android.app.Activity;
import android.view.Menu;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.EditText;
import android.database.sqlite.SQLiteDatabase;

public class MainActivity extends Activity implements OnClickListener {

	private GameManager _gameManager;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.activity_main);
		
		DBHelper dbHelper = new DBHelper(this);
		SQLiteDatabase db = dbHelper.getWritableDatabase();
		
		_gameManager = new GameManager(db);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.activity_main, menu);
		return true;
	}

	@Override
	public void onClick(View currentView) {
		// TODO Auto-generated method stub
		Button startButton = (Button)findViewById(R.id.btnStart);
		Button moreButton = (Button)findViewById(R.id.btnMore);
		Button standButton = (Button)findViewById(R.id.btnStand);
		if(currentView==startButton){
			_gameManager.dealToPlayer1();
			_gameManager.dealToDealer();
			_gameManager.dealToPlayer1();
			_gameManager.dealToDealer();
		}
		
		if(currentView==moreButton){
			_gameManager.dealToPlayer1();
		}
		
		if(currentView==standButton){
			_gameManager.Player1.Stand();
		}
		
		disp();
	}
	
	private void disp(){
		String str1 = _gameManager.Player1.getCardsString();
		EditText e1 = (EditText)findViewById(R.id.edtxtPlayer1);
		e1.setText(str1);
		
		String str2 = _gameManager.DealerPlayer.getCardsString();
		EditText e2 = (EditText)findViewById(R.id.edtxtDealer);
		e2.setText(str2);
	}

}
