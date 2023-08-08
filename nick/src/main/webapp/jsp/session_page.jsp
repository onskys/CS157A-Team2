<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page import="userlogin.Song"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Shuffle Buddy</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 20px;
	background-color: #f2f2f2;
	display: flex;
	align-items: center;
	justify-content: center;
	min-height: 100vh;
	flex-direction: column;
}

h1 {
	text-align: center;
}

.song_progress {
	position: absolute;
	top: 0;
	left: 0;
	width: 0;
	height: 100%;
	background: linear-gradient(to right, #3baa7b, #62bc68);
	border-radius: 0.5rem;
}

.time_display {
	width: 30%;
	display: flex;
	justify-content: space-between;
	margin-bottom: 3rem;
}

.button-container {
	text-align: center;
}

.button {
	display: inline-block;
	padding: 10px 20px;
	background-color: #4CAF50;
	color: white;
	text-decoration: none;
	border-radius: 4px;
	cursor: pointer;
	margin: 10px;
}

.button:hover {
	background-color: #45a049;
}
</style>
<!-- <link rel="stylesheet" type="text/css" href="css/session_page.css" /> -->
</head>
<body>
	<%
	session = request.getSession();
	Song suggested_song = (Song) session.getAttribute("suggested_song");
	String temp_song_name = suggested_song.getName();
	String temp_song_artist = suggested_song.getArtist();
	String temp_song_src = suggested_song.getSrc();
	%> 
	<%-- <h2>src: <%=temp_song_src %></h2> --%>
	<h1>Listening to playlist: ${sessionScope.selectedPlaylistName}</h1>
	<br>
	<div class="song-details">
		<span class="song-name">Song Name: <%=temp_song_name%></span> <br> 
		<span class="song-artist">Song Artist: <%=temp_song_artist%></span>
	</div>

	<div class="song_progress">
		<audio id="audio_element">
			<source src="<%=temp_song_src %>" type="audio/mp3">
		</audio>
	</div>
	<div class="time_display">
		<span>0:00</span> <span>0:00</span>
	</div>

	<div class="button-container">
		<button href="#" class="button" type="button" id="playback_button">Play</button>
		<form id="next_button_form" action="../next_song_server" method="get">
			<input type="hidden" id="songDurationInput" name="duration" value="">
			<button href="#" class="button" type="submit" onclick="getSongDuration();">Next</button>
		</form>
		<form id="home_button_form" action="../delete_session_server" method="get">
			<button href="#" class="button" type="submit">Home</button>
		</form>
	</div>
	

	<script>
		const playButton = document.getElementById("playback_button");
		const audioPlayer = document.getElementById("audio_element");
		const songProgress = document.querySelector(".song_progress");

		
	    function getSongDuration() {
	        var audioElement = document.getElementById("audio_element");
	        var songCurrentTime = audioElement.currentTime; // Duration in seconds
	        //console.log(typeof songDuration);
	        //console.log("song duration: ", songDuration);
	        // Set the song duration in the hidden input field
	        var songDurationInput = document.getElementById("songDurationInput");
	        songDurationInput.value = songCurrentTime;
	    }
		
		playButton.addEventListener("click", function() {
			console.log("in click listener");
			//process.stderr.write("in timeupdate event listener");
			if (audioPlayer.paused) {
				audioPlayer.play();
				playButton.textContent = "Pause";
			} else {
				audioPlayer.pause();
				playButton.textContent = "Play";
			}
		});
		
		audioPlayer.addEventListener("timeupdate", (e) => {
			console.log("in timeupdate event listener");
			//process.stderr.write("in timeupdate event listener");
			const currentTime = e.target.currentTime;
			const duration = e.target.duration;
			//let currentTimeWidth = (currentTime / duration) * 100;
			//songProgress.style.width = `${currentTimeWidth}%`;
			console.log("currentTime: " + currentTime);
			
			let songCurrentTime = document.querySelector(".time_display span:nth-child(1)");
			let songDuration = document.querySelector(".time_display span:nth-child(2)");
			
			let currentMinutes = Math.floor(currentTime / 60);
			let currentSeconds = Math.floor(currentTime % 60);
			
			console.log("currentMinutes: " + currentMinutes);
			console.log("currentSeconds: " + currentSeconds);
			
			if (currentSeconds < 10) {
				currentSeconds = "0" + currentSeconds.toString();
				console.log("in loop: " + currentSeconds);
			}

			console.log(currentMinutes.toString() + ":" + currentSeconds.toString());
			songCurrentTime.textContent = currentMinutes.toString() + ":" + currentSeconds.toString();
			
			durationMinutes = Math.floor(duration/60).toString()
			durationSeconds = ""
			if (Math.floor(duration % 60) < 10){ durationSeconds = "0" + Math.floor(duration % 60).toString(); }
			else { durationSeconds =  Math.floor(duration % 60).toString(); }
			songDuration.textContent = durationMinutes + ":" + durationSeconds;
		});
	</script>

</body>
</html>
