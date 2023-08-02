package userlogin;

public class Song {
	private String spotify_uri;
	private String name;
	private String artist;
	private String src;
	private float acousticness, danceability, energy, instrumentalness, valence;
	private int durration;
	private float score;
	
	Song(String spotify_uri, String name, String artist, String src, float a, float d, float e, float i, float v){
		this.spotify_uri = spotify_uri;
		this.name = name;
		this.artist = artist;
		this.src = src;
		this.acousticness = a;
		this.danceability = d;
		this.energy = e;
		this.instrumentalness = i;
		this.valence = v;
	}
	
	void setDurration(int d) {
		this.durration = d;
	}
	
	int getDurration() {
		return this.durration;
	}
	
	void setScore(float s) {
		this.score = s;
	}
	
	public String getSpotifyURI() {
		return this.spotify_uri;
	}
	
	public String getName() {
		return this.name;
	}
	
	public String getArtist() {
		return this.artist;
	}
	
	public String getSrc() {
		return this.src;
	}
	
	public float getAcousticness() {
		return acousticness;
	}

	public float getDanceability() {
		return danceability;
	}

	public float getEnergy() {
		return energy;
	}

	public float getInstrumentalness() {
		return instrumentalness;
	}

	public float getValence() {
		return valence;
	}

	void print() {
		System.out.println("==========");
		System.out.println("spotify_uri: " + this.spotify_uri);
		System.out.println("name: " + this.name);
		System.out.println("artist: " + this.artist);
		System.out.println("src: " + this.src);
		System.out.println("song characteristics: " + this.acousticness + ", " + this.danceability + ", " + this.energy + ", " + this.instrumentalness + ", " + this.valence);
		System.out.println("durration: " + this.durration);
		System.out.println("score: " + this.score);
		System.out.println("==========\n");
	}
	
	public static float euclidian_distance(float[] liked_songs_vector, float[] unplayed_song_vector) {
		if (liked_songs_vector.length != unplayed_song_vector.length) {
			System.out.println("characteristic vectors do not have the same length!!");
			return Float.MAX_VALUE;
		}
		
		float temp_sum = 0.0f;
		for(int i = 0; i < liked_songs_vector.length; i++) {
			temp_sum += Math.pow((liked_songs_vector[i] - unplayed_song_vector[i]), 2);
		}
		return (float) Math.sqrt(temp_sum);
	}
	
}