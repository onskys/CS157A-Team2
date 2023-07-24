<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Play Song from Spotify API</title>
    <script src="https://sdk.scdn.co/spotify-player.js"></script>
</head>
<body>
    <h2>Play Song from Spotify API</h2>

    <script>
        // Initialize the Spotify Web Playback SDK
        window.onSpotifyWebPlaybackSDKReady = () => {
            const token = 'BQD86C8QWLCW3lh6KUHlUFFXrdMAEHJuY-km24F7eptzYqqkBg0oATeb4Q0Qn1EWep764iGirCSKgVB_Lxj3i3BzT9REibhfQOmdrVd6J_PMRCO7CW8'; // Replace with your actual access token
            const player = new Spotify.Player({
                name: 'Web Playback SDK Player',
                getOAuthToken: cb => { cb(token); }
            });

           //Check listener evets

            

                // Play a song by track number
                const trackNumber = '11dFghVXANMlKmJXsNCbNl'; // Replace with the actual track number
                const trackUri = `spotify:track:${trackNumber}`;
                player.queue({ uri: trackUri });
                player.pause();
                player.seek(0);
                player.resume();
            });

            // Connect to the player
            player.connect();
        };
    </script>
</body>
</html>
