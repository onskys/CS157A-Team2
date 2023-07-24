<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>Music Player</title>
    <style>
        /* Add your styles here */
        body {
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
        }

        header {
            background-color: #333;
            color: #fff;
            text-align: center;
            padding: 10px 0;
        }

        section {
            text-align: center;
            padding: 20px;
        }

        .button-container {
            text-align: center;
            margin-top: 20px;
        }

        .nav-arrow {
            /* Add styles for the navigation buttons here */
        }
    </style>
    <script src="script.js" defer></script>
</head>
<body>
    <header>Music Player</header>
    <section>
        
        <h1 class="text" value="4">
            <span class="album-num">Album Number</span>
            <span class="album-title">Album Title</span>
            <span>( PlaYlist Name )</span>
        </h1>
    </section>
    <div class="spotify-widget">
        <iframe src="https://open.spotify.com/embed/track/5HCyWlXZPP0y6Gqq8TgA20?utm_source=generator" width="100%" height="80" frameborder="0" allowfullscreen="" allow="autoplay; clipboard-write; encrypted-media; fullscreen; picture-in-picture" loading="lazy"></iframe>
    </div>
    <div class="button-container">
        <button class="scroll-left nav-arrow"><span></span>Prev</button>
        <button class="scroll-right nav-arrow">Next<span></span></button>
    </div>
</body>
</html>
