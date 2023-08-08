package userlogin;

import java.io.*;
// import javax.servlet.*;
// import javax.servlet.http.*;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import userlogin.databaseconnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/populate_session_server")
// Extend HttpServlet class
public class populate_session_server extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		String selectedPlaylistID = (String) session.getAttribute("selectedPlaylistID");
		Integer sessionID = (Integer) session.getAttribute("sessionID");

		try {
			System.out.print("\n\nin populate session server try catch block");
			Connection con = databaseconnection.getConnection();
			System.out.println(" database connection successfully opened.<br/><br/>");

			// make a list of all the songs in the playlist that have already been played
			PreparedStatement findPlayedSongs = con.prepareStatement(
					"SELECT * FROM play JOIN song ON play.spotify_uri = song.spotify_uri WHERE session_id = ?");
			findPlayedSongs.setInt(1, sessionID.intValue()); //(1, sessionID);
			System.out.println("about to execute: \n" + findPlayedSongs.toString());
			ResultSet rs = findPlayedSongs.executeQuery();

			List<Song> played_songs = new ArrayList<Song>();

			while (rs.next()) {
				String temp_spotify_uri = rs.getString("spotify_uri");
				String temp_name = rs.getString("name");
				String temp_artist = rs.getString("artist");
				String temp_src = rs.getString("src");
				float temp_a = rs.getFloat("acousticness");
				float temp_d = rs.getFloat("danceability");
				float temp_e = rs.getFloat("energy");
				float temp_i = rs.getFloat("instrumentalness");
				float temp_v = rs.getFloat("valence");

				int temp_durration = rs.getInt("duration");
				Song tempSong = new Song(temp_spotify_uri, temp_name, temp_artist, temp_src, temp_a, temp_d, temp_e,
						temp_i, temp_v);
				tempSong.setDurration(temp_durration);
				played_songs.add(tempSong);
			}

//			System.out.println("these are all the songs that have already been played this session: ");
//			for (Song song : played_songs) {
//				song.print();
//			}

			// make a list of all the songs in the playlist that have not been played
			// already

			PreparedStatement findUnplayedSongs = con.prepareStatement("SELECT * FROM song "
					+ "WHERE spotify_uri IN (SELECT pcs.spotify_uri FROM playlist_contains_songs pcs "
					+ "WHERE playlist_id=?) "
					+ "AND spotify_uri NOT IN (SELECT p.spotify_uri FROM play p WHERE session_id = ?);");
			findUnplayedSongs.setString(1, selectedPlaylistID);
			findUnplayedSongs.setInt(2, sessionID.intValue());
			System.out.println("about to execute: \n" + findUnplayedSongs.toString());
			rs = findUnplayedSongs.executeQuery();

			List<Song> unplayed_songs = new ArrayList<Song>();

			while (rs.next()) {
				String temp_spotify_uri = rs.getString("spotify_uri");
				String temp_name = rs.getString("name");
				String temp_artist = rs.getString("artist");
				String temp_src = rs.getString("src");
				float temp_a = rs.getFloat("acousticness");
				float temp_d = rs.getFloat("danceability");
				float temp_e = rs.getFloat("energy");
				float temp_i = rs.getFloat("instrumentalness");
				float temp_v = rs.getFloat("valence");

				Song tempSong = new Song(temp_spotify_uri, temp_name, temp_artist, temp_src, temp_a, temp_d, temp_e,
						temp_i, temp_v);
				unplayed_songs.add(tempSong);
			}

//			System.out.println("These are all the songs that have not been played this session");
//			for (Song song : unplayed_songs) {
//				song.print();
//			}

			System.out.println("size of played songs: " + played_songs.size());
			System.out.println("size of unplayed songs: " + unplayed_songs.size());
			
			// add logic here to check if the playlist has been played completely
			if (unplayed_songs.size() == 0) {
				System.out.println("about to dispatch to delete session server");
				RequestDispatcher dispatcher = request.getRequestDispatcher("/delete_session_server");
				dispatcher.forward(request, response);
			}
			
			// find the next song that should be played
			// if this is the first song played in the session choose the first song
			if (played_songs.size() == 0) {
				session.setAttribute("suggested_song", unplayed_songs.get(0));
				//request.setAttribute("suggested_song", unplayed_songs.get(0));
			} else {
				// find the average song characteristics vector adjusted for which songs the
				// user has skipped or listened to in their entirety
				int num_characteristics = 5;
				float[] average_song_characteristics = new float[num_characteristics];
				for (int i = 0; i < num_characteristics; i++) {
					average_song_characteristics[i] = 0.0f;
				}

				for (Song song : played_songs) {
					if (song.getDurration() > 15) {
						average_song_characteristics[0] += song.getAcousticness();
						average_song_characteristics[1] += song.getDanceability();
						average_song_characteristics[2] += song.getEnergy();
						average_song_characteristics[3] += song.getInstrumentalness();
						average_song_characteristics[4] += song.getValence();
					} else {
						average_song_characteristics[0] += 1 - song.getAcousticness();
						average_song_characteristics[1] += 1 - song.getDanceability();
						average_song_characteristics[2] += 1 - song.getEnergy();
						average_song_characteristics[3] += 1 - song.getInstrumentalness();
						average_song_characteristics[4] += 1 - song.getValence();
					}
				}

				for (int i = 0; i < num_characteristics; i++) {
					average_song_characteristics[i] = average_song_characteristics[i] / played_songs.size();
				}
				
				System.out.print("average song characteristics: ");
				for(int i = 0; i < 5; i++) {
					System.out.print(Float.toString(average_song_characteristics[i]) + ", ");
				} System.out.println();
				
				// iterate through the array of songs that have not been played yet and save the song with the lowest euclidian distance from the the
				// average song characteristics vector
				float best_distance = Float.MAX_VALUE;
				Song best_suggestion = null;
				
//				System.out.println("====================\nThese are the scores of the unplayed songs: ");
				
				for(Song song : unplayed_songs) {
					float[] temp_song_vector = {song.getAcousticness(), song.getDanceability(), song.getEnergy(), song.getInstrumentalness(), song.getValence()};
					float temp_distance = Song.euclidian_distance(average_song_characteristics, temp_song_vector);
//					System.out.println(song.getName() + ": " + Float.toString(temp_distance));
					if (temp_distance < best_distance) {
//						System.out.println("updating best song, original best_distace: " + Float.toString(best_distance) + " new best distance: " + Float.toString(temp_distance));
						best_suggestion = song;
						best_distance = temp_distance;
					}
				}
				System.out.println("This will be the new suggested song: " + best_suggestion.getName());
				System.out.println("with score: " + Float.toString(best_distance));
				session.setAttribute("suggested_song", best_suggestion);
				//request.setAttribute("suggested_song", best_suggestion);
				
			}
			
			System.out.println("\n===== this is the suggested song =====");
			
			if (session.getAttribute("suggested_song") == null) {
				System.out.println("End of playlist");
			}
			else {
				((Song)session.getAttribute("suggested_song")).print();
				
				System.out.println("about to dispatch to session page jsp");
				response.sendRedirect("jsp/session_page.jsp");
				// RequestDispatcher dispatcher =
				// request.getRequestDispatcher("/populate_session_server");
				// dispatcher.forward(request, response);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}