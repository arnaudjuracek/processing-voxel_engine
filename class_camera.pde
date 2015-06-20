class Camera{
	World world;
	PVector POSITION = new PVector(0,0,0);
	float
		ALPHA,
		DEPTH,
		FOV,
		FRONT_TILT,
		SIDE_TILT;
	boolean WALKING;

	Camera(World world, PVector position, float alpha, float dist, float fov, boolean walking){
		this.world = world;
		this.POSITION = position;
		this.ALPHA = alpha;
		this.DEPTH = dist;
		this.FOV = fov;
		this.FRONT_TILT = 0;
		this.SIDE_TILT = 0;
		this.WALKING = walking;
	}

	void rotate(float a){ this.ALPHA += a; }
	void up(float n){ this.POSITION.z += n; }
	void front_tilt(float t){ this.FRONT_TILT = t; }
	void side_tilt(float t){ this.SIDE_TILT = t; }
	void forward(float n){
		this.POSITION.x = this.POSITION.x + sin(radians(this.ALPHA))*n;
		this.POSITION.y = this.POSITION.y + cos(radians(this.ALPHA))*n;
	}

	void walk(){
		float theta = radians(this.ALPHA);
		int
			x_map = int( this.POSITION.x + sin(theta) ),
			y_map = int( this.POSITION.y + cos(theta) ),
			alt = this.world.map.getAltitude(x_map,y_map),
			x_map_2 = int( this.POSITION.x + sin(theta)*2),
			y_map_2 = int( this.POSITION.y + cos(theta)*2),
			alt_2 = this.world.map.getAltitude(x_map_2,y_map_2);

		this.POSITION.z = alt + 50;
		this.FRONT_TILT = map(alt_2 - alt, -height, height, -100, 100);
	}

	void warp(){
		if(this.POSITION.x < 0) this.POSITION.x = this.world.map.WIDTH;
		if(this.POSITION.x > this.world.map.WIDTH) this.POSITION.x = 0;
		if(this.POSITION.y < 0) this.POSITION.y = this.world.map.HEIGHT;
		if(this.POSITION.y > this.world.map.HEIGHT) this.POSITION.y = 0;
	}

	void draw(){
		this.warp();
		strokeWeight(10);
		stroke(255,255,0);
		point(this.POSITION.x, this.POSITION.y);

		strokeWeight(1);

		for(float alpha = this.ALPHA - this.FOV*.5; alpha <= this.ALPHA + this.FOV*.5; alpha++){
			float
				x = this.POSITION.x,
				y = this.POSITION.y,
				theta = radians(alpha),
				r = 200; //this.DEPTH;

			stroke(255,255,0,255*.5);
			line(x, y, (x + sin(theta)*r), (y + cos(theta)*r) );
		}
	}
}