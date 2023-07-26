<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Shuffle Buddy</title>
<style>
.song_progress {
	position: absolute;
	top: 0;
	left: 0;
	width: 0;
	height: 100%;
/* 	background: linear-gradient(to right, #3baa7b, #62bc68);
	border-radius: 0.5rem; */
}

.time_display {
	width: 100%;
	display: flex;
	justify-content: space-between;
	margin-bottom: 3rem;
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
	<h2>Add Playlist Name</h2>
	<br>
	<div class="song-details">
		<span class="song-name">Add name here</span> <br> <span
			class="song-artist">Add Artist here</span>
	</div>

	<div class="song_progress">
		<audio id="audio_element">
			<source src="../music/The Piano Guys/04 Beethoven's 5 Secrets.mp3" type="audio/mp3">
		</audio>
	</div>

	<div class="controls">
		<button type="button" id="playback_button">Play</button>
		<button type="button">Next</button>
		<button type="button">Home</button>
	</div>
	<div class="time_display">
		<span>0:00</span> <span>add total duration</span>
	</div>

	<script>
		const playButton = document.getElementById("playback_button");
		const audioPlayer = document.getElementById("audio_element");
		const songProgress = document.querySelector(".song_progress");

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
