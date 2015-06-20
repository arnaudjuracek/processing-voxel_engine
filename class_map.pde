class Map{
	PImage
		DEPTHMAP,
		TEXMAP;

	int WIDTH, HEIGHT, INDEX;

	Map(int n){
		this.INDEX = n;
		println("Map #"+n+" loaded.");

		this.DEPTHMAP = loadImage(MAP_FOLDER+"/"+n+"_depth.png");
		this.TEXMAP = loadImage(MAP_FOLDER+"/"+n+"_texture.png");

		this.WIDTH = this.DEPTHMAP.width;
		this.HEIGHT = this.DEPTHMAP.height;
	}

	int getAltitude(float x, float y){
		//warp
		x = x<=0 ? this.WIDTH+x : x;
		y = y<=0 ? this.HEIGHT+y : y;

		x = x>=this.WIDTH ? x-this.WIDTH : x;
		y = y>=this.HEIGHT ? y-this.HEIGHT : y;

		float alt = map(
						brightness(
							this.DEPTHMAP.get( int(x),int(y) ) ),
						0, 255,
						0, height);
		return int(alt);
	}

	color getColor(float x, float y){
		//warp
		x = x<=0 ? this.WIDTH+x : x;
		y = y<=0 ? this.HEIGHT+y : y;

		x = x>=this.WIDTH ? x-this.WIDTH : x;
		y = y>=this.HEIGHT ? y-this.HEIGHT : y;

		return this.TEXMAP.get(int(x), int(y));
	}

	void draw(){ image(this.TEXMAP, 0, 0, width, height); }
}