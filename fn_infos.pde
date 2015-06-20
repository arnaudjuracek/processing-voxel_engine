void infos(){
	fill(0);
	if(toggle_infos){
		textAlign(LEFT, TOP);
		text(
			"Map #"+world.map.INDEX
			+"\n"
			+"\nCamera :"
			+"\n  position : "+int(world.camera.POSITION.x)+" ; "+int(world.camera.POSITION.y)+" ; "+int(world.camera.POSITION.z)
			+"\n  alpha : "+int(world.camera.ALPHA)
			+"\n  front_tilt : "+int(world.camera.FRONT_TILT)
			+"\n  side_tilt : "+int(world.camera.SIDE_TILT)
			+"\n  FOV : "+int(world.camera.FOV)
			+"\n"
			+"\nRenderer :"
			+"\n  y_scale : "+int(world.renderer.Y_SCALE)
			+"\n  y_center : "+int(world.renderer.Y_CENTER)
			+"\n  resolution : "+int(world.renderer.RESOLUTION)
			, 10, 10);
	}
	textAlign(RIGHT, TOP);
	text(int(frameRate)+" fps", width - 10, 10);
}