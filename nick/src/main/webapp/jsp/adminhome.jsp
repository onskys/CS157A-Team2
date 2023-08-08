<!DOCTYPE html>
<html>
<head>
    <title>Admin Panel</title>
    <link rel="stylesheet" type="text/css" href="../css/adminhome.css">
</head>
<body>
    <header>
    <button type = 'button' class = "back-button" onclick ="window.location.href='index.jsp'" >Log Out</button>
      <div class = "container">
      <div class = "headers">
        <h1>Admin</h1>
        <h2> Panel </h2>
      </div>
    <div class="buttons-container">
            <button type='button' class="action-button" onclick="window.location.href='deleteuser.jsp'"> Delete User </button>
            <button type='button' class="action-button" onclick="window.location.href='securityQuestion.jsp'">Security Question</button>
            <button type='button' class="action-button" onclick="window.location.href='default_playlist.jsp'">Default Playlist</button>

    </div>
    </div>
     </header>
</body>
</html> 