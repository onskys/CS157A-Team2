<!DOCTYPE html>
<html>
<head>
  <title>Shuffle Buddy - Music Web App</title>
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
</head>
<body>
  <h1>Shuffle Buddy</h1>

  <div class="button-container">
    <a href="#" class="button" onclick="createPlaylist()">Create New Playlist</a>
    <a href="#" class="button" onclick="selectPlaylist()">Select Playlist</a>
    <a href="#" class="button" onclick="goToDefaultPlaylist()">Go to Default Playlist</a>
  </div>

  <script>
    function createPlaylist() {
      console.log("Create playlist clicked");
    }

    function selectPlaylist() {
      console.log("Select playlist clicked");
    }

    function goToDefaultPlaylist() {
      console.log("Go to default playlist clicked");
      window.location.href='default.jsp'
    }
  </script>
</body>
</html>