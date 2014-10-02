/*
 * Main.eq
 * Generated by Eqela Studio 2.0b7.4
 */

public class Main : SEScene
{
	SESprite bg;
	SESprite fg;
	SESprite text;
	bool move_right = true;
	bool move_left = false;
	bool move_down = true;
	bool move_up= false;
	int speed = 50;
	double rotation=0;
	String display;
	int bounce = 0;
	
	public void initialize(SEResourceCache rsc)
	{
		base.initialize(rsc);
		bg = add_sprite_for_color(Color.instance("white"),get_scene_width(),get_scene_height());
		bg.move(0,0);
	//	fg = add_sprite_for_color(Color.instance("green"),get_scene_width()*0.1,get_scene_height()*0.1);
	//	fg.move(100,100);
		rsc.prepare_font("myfont", "arial bold color=black", 40);
		display = "BOUNCES = %d".printf().add(Primitive.for_integer(bounce)).to_string();
		text = add_sprite_for_text(display, "myfont");
		text.move(0, get_scene_height()-text.get_height());
		rsc.prepare_image("myimage", "bow_pink", get_scene_width()*0.1);
		fg = add_sprite_for_image(SEImage.for_resource("myimage"));
		fg.move(100,100);
		
	}

	public void update(TimeVal now, double delta)
	{
		base.update(now,delta);
		speed += 100;
		rotation += MathConstant.M_PI_4/4;
		fg.set_rotation(rotation);
		
		if(move_right)
		{
			fg.move(fg.get_x()+delta*speed,fg.get_y());
			
			if(fg.get_x()+fg.get_width() > get_scene_width())
			{
				speed = 100;
				bounce++;
				text.set_text("BOUNCES = %d".printf().add(Primitive.for_integer(bounce)).to_string());
				move_right = false;
				move_left = true;
			}
		}
		
		if(move_left)
		{
			fg.move(fg.get_x()-delta*speed,fg.get_y());
			if(fg.get_x() < 0)
			{
				speed = 100;
				bounce++;
				text.set_text("BOUNCES = %d".printf().add(Primitive.for_integer(bounce)).to_string());
				move_right = true;
				move_left = false;
			}
		}

		if(move_down)
		{
			fg.move(fg.get_x(),fg.get_y()+delta*speed);
			
			if(fg.get_y()+fg.get_height() > get_scene_height())
			{
				speed = 100;
				bounce++;
				text.set_text("BOUNCES = %d".printf().add(Primitive.for_integer(bounce)).to_string());
				move_down = false;
				move_up = true;
			}
		}
		
		if(move_up)
		{
			fg.move(fg.get_x(),fg.get_y()-delta*speed);
			if(fg.get_y() < 0)
			{
				speed = 100;
				bounce++;
				text.set_text("BOUNCES = %d".printf().add(Primitive.for_integer(bounce)).to_string());
				move_down = true;
				move_up = false;
			}
		}
		
	}// end of update

	public void set_rotation(double angle)
	{
		rotation = angle;
	}

	public double get_rotation()
	{
		return(rotation);
	}

	public void cleanup()
	{
		base.cleanup();
		SESprite.remove(fg);
		SESprite.remove(bg);
		SESprite.remove(text);
	}

	
}
