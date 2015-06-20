class Renderer{
	World world;

	float
		Y_SCALE,
		Y_CENTER,
		RESOLUTION;

	Renderer(World world, float y_scale, float y_center, float resolution){
		this.world = world;

		this.Y_SCALE = y_scale;
		this.Y_CENTER = y_center;
		this.RESOLUTION = resolution;
	}

	void rayCast(Camera camera){
		loadPixels();

	// iterate through each column, a.k.a along the x axis of the screen
		for(int column=0; column<width; column+=this.RESOLUTION){
			float
				alpha = map(column, 0, width, camera.ALPHA - camera.FOV*.5, camera.ALPHA + camera.FOV*.5),
				theta = radians(alpha);
			int depth = int(camera.DEPTH);

	// go along one ray
			int max_alt = 0, py_voxel = 0;
			// step size on the ray depending on the depth :
			// bigger step size in the distance, to increase FPS
			// @see "Variable Step Size" http://www.flipcode.com/archives/Realtime_Voxel_Landscape_Engines-Part_4_Level_of_Detail_and_Optimisation.shtml
			for(int r=0; r<depth; r+=map(r, 0, depth, 1, 10)){
				//get the position of the voxel on the ray, and its altitude value
				int
					x_map = int(camera.POSITION.x + sin(theta)*r),
					y_map = int(camera.POSITION.y + cos(theta)*r),
					alt = this.world.map.getAltitude(x_map,y_map);

				// calculate the position of the voxel on screen
				// int(y_voxel) is much more faster than float(y_voxel)
				// because it's avoiding subpixels drawing
				// @see wave surfing equation http://www.flipcode.com/archives/Realtime_Voxel_Landscape_Engines-Part_2_Rendering_the_Landscapes_Structure.shtml
				int y_voxel = int( (alt - camera.POSITION.z+camera.FRONT_TILT) * (this.Y_SCALE/r) + this.Y_CENTER - camera.FRONT_TILT );

				// wave surfing, @see http://www.flipcode.com/archives/Realtime_Voxel_Landscape_Engines-Part_2_Rendering_the_Landscapes_Structure.shtml
				if(y_voxel>max_alt){
					// color computation based on depth
					// (previously with pow(r,3), but slower than actual method)
					color c = this.world.map.getColor(x_map,y_map);
					color c_far = lerpColor(c, color(228, 237, 238), map( sq(r), 0, sq(depth), 0, map( r, 0, depth, .25, .75)));

					// draw optimisation, faster than
					// strokeWeight(this.RESOLUTION); stroke(c_far); strokeCap(SQUARE);
					// line(column, height - py_voxel, column, height - y_voxel);
					for(int y=constrain(height - py_voxel, 0, height-1); y>constrain(height - y_voxel, 0, height-1); y--){
						for(int x=column; x<column+this.RESOLUTION; x++){
							pixels[y*width+constrain(x,0,width-1)] = c_far;
						}
					}
					max_alt = py_voxel = y_voxel;
				}
			}
		}
		updatePixels();
	}
}