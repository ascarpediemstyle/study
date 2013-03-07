package com.example.marubatsu;

import java.util.Map;

import android.R.integer;
import android.content.Context;
import android.widget.ImageView;
import android.util.AttributeSet;
import android.view.MotionEvent;
import android.view.View;


public class CellImageView extends ImageView implements View.OnClickListener,View.OnHoverListener {

	public int CellNumber = -1;	
		
	public CellImageView(Context context) {
		this(context,null);
		
	}
	public CellImageView(Context context, AttributeSet attrs){
		super(context, attrs);
		
		// TODO Auto-generated constructor stub
		this.setImageResource(R.drawable.empty);
		this.setOnClickListener(this);
		this.setOnHoverListener(this);
		
		CellNumber = attrs.getAttributeIntValue(null, "cellNumber", -1);
	
	}
	public CellImageView(Context context, AttributeSet attrs, Map inflateParams){
		this(context,attrs);		
	}	

	@Override
	public void onClick(View view) {
		// TODO Auto-generated method stub		
		if(view.equals(this)){			
			GameManager manager = MainActivity.getGameManager();		
			
			
			if(!manager.isEmptyBoard(this.CellNumber)){
				return;
			}
			
			int resId = manager.getCurrentPlayerResourceId();
			this.setImageResource(resId);
			manager.changeCurrentPlayer();
			manager.changeBoard(this.CellNumber);
			
			if(!manager.isFinish()){
				manager.doComPlay();
			}
		}
	}

	@Override
	public boolean onHover(View view, MotionEvent event) {
		// TODO Auto-generated method stub				
        switch (event.getAction()) {
            case MotionEvent.ACTION_HOVER_ENTER:
            	if(view == this){        			
        			this.setImageResource(R.drawable.select);
        		}
                break;
            case MotionEvent.ACTION_HOVER_MOVE:
                
                break;
            case MotionEvent.ACTION_HOVER_EXIT:
            	if(view == this){        			
        			this.setImageResource(R.drawable.empty);
        		}
                break;
        }
        return true;
		
	}
	
	

}
