import mysql.connector
import spotipy
from spotipy.oauth2 import SpotifyClientCredentials


config = {
  'user': 'root',
  'password': 'LTAndr3w',
  'host': '127.0.0.1',
  'database': 'cs157a_team2',
  'raise_on_warnings': True
}

def get_track_uri(sp, artist_name, track_name):
    results = sp.search(q=f"track:{track_name} artist:{artist_name}", type='track', limit=1)
    # Extract the track URI from the search results
    if results['tracks']['items']:
        track_uri = results['tracks']['items'][0]['uri']
        return track_uri
    else:
        print("Track not found: " + track_name)
        return None

def get_track_audio_features(sp, track_uri):
    # Get audio features of the track using the track URI
    audio_features = sp.audio_features(track_uri)

    if audio_features:
        return audio_features[0]
    else:
        print("Audio features not available for the track.")
        return None

cnx = mysql.connector.connect(**config)

cid = '41c5db8628874b92a935c2014b623dec'
secret = '3ad26e9508b84bf5800477191e8ef432'

client_credentials_manager = SpotifyClientCredentials(client_id=cid, client_secret=secret)
sp = spotipy.Spotify(client_credentials_manager = client_credentials_manager)

mycursor = cnx.cursor()

with open("songs_input.txt", 'r') as file1:
  for line in file1:
    line = line.strip()
    temp_input = line.split(',')
    temp_artist = temp_input[0]
    temp_song_name = temp_input[1][3:-4].replace("_","/")
    temp_uri = get_track_uri(sp, temp_artist, temp_song_name)
    # print(type(temp_uri), temp_uri, len(temp_uri))
    # print(temp_uri.split(":")[-1], len(temp_uri.split(":")[-1]))
    temp_src = "../music/" + temp_artist + "/" + temp_input[1]
    if temp_uri == None:
      continue
    audio_features = get_track_audio_features(sp, temp_uri)
    print(temp_input[0], temp_input[1], audio_features["acousticness"])

    sql = "INSERT INTO song (spotify_uri,name,artist,src,acousticness,danceability,energy,instrumentalness,valence) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)"
    val = (temp_uri.split(":")[-1], temp_song_name, temp_artist, temp_src, audio_features["acousticness"], audio_features["danceability"], audio_features["energy"], audio_features["instrumentalness"], audio_features["valence"])
    mycursor.execute(sql, val)
    cnx.commit()



cnx.close()