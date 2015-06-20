/**
 * Realtime Voxel landscape engine
 * @based on Carpet Landscapes (http://vacuumflowers.com/weblog/?p=347)
 * @see http://www.flipcode.com/archives/Realtime_Voxel_Landscape_Engines-Part_1_Introduction.shtml
 * @see http://simulationcorner.net/index.php?page=comanche
 */

World world;
PGraphics sky;
String MAP_FOLDER = "commanche_maps";

void setup(){
	size(displayWidth - 40, int(displayHeight*.75));
	world = new World(1);

	sky = createGraphics(width, height);
		sky.beginDraw();
			sky.background(228, 237, 238);
			for(int y=0; y<height; y++){
				sky.stroke(
					int( map(y, 0, height, 150, 228) ),
					int( map(y, 0, height, 150, 237) ),
					int( map(y, 0, height, 200, 238) ));
				sky.line(0, y, width, y);
			}
		sky.endDraw();
}

void draw(){
	image(sky, 0,0);

	if(toggle_map) world.render_map(true);
	else world.render(world.camera);

	infos();

	world.camera.forward(map(mouseY, 0, height, 10, -10));
	world.camera.rotate(map(mouseX, 0, width, -10, 10));
	world.camera.front_tilt(map(mouseY, 0, height, 0, 100));
	world.camera.side_tilt(map(mouseX, 0, width, -30, 30));
}

boolean
	toggle_map = false,
	toggle_infos = false;
void keyPressed(){
	if(key == 'r') world = new World( int(random(1,15)) );
	if(key == 'm') toggle_map = !toggle_map;
	if(key == 'i') toggle_infos = !toggle_infos;

	if(key == 'z') world.camera.forward(10);
	if(key == 's') world.camera.forward(-10);
	if(key == 'q') world.camera.rotate(-10);
	if(key == 'd') world.camera.rotate(10);

	if(keyCode == UP)		world.camera.up(10);
	if(keyCode == DOWN)		world.camera.up(-10);
	if(keyCode == LEFT) 	world.camera.FOV += 5;
	if(keyCode == RIGHT) 	world.camera.FOV -= 5;
	if(keyCode == 109) 		world.renderer.RESOLUTION = constrain(world.renderer.RESOLUTION+1, 1, width);
	if(keyCode == 107) 		world.renderer.RESOLUTION = constrain(world.renderer.RESOLUTION-1, 1, width);
}