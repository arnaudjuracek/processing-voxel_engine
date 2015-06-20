class World{
	Map map;
	Camera camera;
	Renderer renderer;

	World(int n){
		this.map = new Map(n);

		this.camera = new Camera(
							this,
							new PVector(
								this.map.WIDTH*.5,
								this.map.HEIGHT*.5,
								height*.5),
							0,					// ALPHA
							this.map.WIDTH*.5, 	// DISTANCE
							180, 				// FOV
							false);				// WALKING

		this.renderer = new Renderer(
							this,
							100, 		// Y SCALE
							height*.75,	// Y CENTER
							6);			// Y RESOLUTION
	}

	void render_map(boolean show_camera){
		world.map.draw();
		if(show_camera) world.camera.draw();
	}

	void render(Camera camera){
		this.renderer.Y_CENTER = camera.POSITION.z * 1.25;
		camera.warp();
		if(camera.WALKING) camera.walk();

		this.renderer.rayCast(camera);
	}
}