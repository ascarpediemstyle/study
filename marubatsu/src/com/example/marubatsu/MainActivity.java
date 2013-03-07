package com.example.marubatsu;


import android.os.Bundle;
import android.R.integer;
import android.app.Activity;
import android.view.Menu;
import android.view.MotionEvent;
import android.view.View;
import android.widget.ImageView;
import android.widget.TableLayout;
import android.widget.TableRow;


public class MainActivity extends Activity implements View.OnClickListener,OnComPlayEventListener{
	
	private static GameManager _gameManager;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);	
		
		setContentView(R.layout.activity_main);	
		_gameManager = new GameManager();	
		_gameManager.setComPlayEventListener(this);
	}

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		// Inflate the menu; this adds items to the action bar if it is present.
		getMenuInflater().inflate(R.menu.activity_main, menu);
		return true;
	}	

	@Override
	public void onClick(View view) {
		// TODO Auto-generated method stub
		
	}
	
	public static GameManager getGameManager(){
		return _gameManager;
	}

	@Override
	public void onEvent() {
		int num = ComPlayer.getNextCellNumber();
		setImage(R.id.imgv1,num);
		setImage(R.id.imgv2,num);
		setImage(R.id.imgv3,num);
		setImage(R.id.imgv4,num);
		setImage(R.id.imgv5,num);
		setImage(R.id.imgv6,num);
		setImage(R.id.imgv7,num);
		setImage(R.id.imgv8,num);
		_gameManager.changeBoard(num);		
		_gameManager.changeCurrentPlayer();		
	}
	
	private void setImage(int resId,int num){
		CellImageView view = (CellImageView)findViewById(resId);
		if(view.CellNumber == num){
			view.setImageResource(_gameManager.getCurrentPlayerResourceId());
		}
	}
	
	public void btnResetOnClick(){
		_gameManager.reflesh();
	}

}
