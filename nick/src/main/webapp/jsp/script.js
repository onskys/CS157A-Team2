const albums = [
  {
    album: "Stay",
    spotify: "https://embed-standalone.spotify.com/embed/track/5HCyWlXZPP0y6Gqq8TgA20?utm_source=generator",
  },
  {
    album: "where she goes",
    spotify: "https://open.spotify.com/embed/track/7ro0hRteUMfnOioTFI5TG1?utm_source=generator",
  },
  {
    album: "Calm Down",
    spotify: "https://open.spotify.com/embed/track/0WtM2NBVQNNJLh6scP13H8?utm_source=generator",
  },
  {
    album: "Last Night",
    spotify: "https://open.spotify.com/embed/track/59uQI0PADDKeE6UZDTJEe8?utm_source=generator",
  },
];

const scrollLeft = document.querySelector(".scroll-left");
const scrollRight = document.querySelector(".scroll-right");
const albumTitleSpan = document.querySelector(".album-title");
const albumNum = document.querySelector(".album-num");
const spotifyWidget = document.querySelector(".spotify-widget iframe");
console.log("------------------------------------------------------------------------------------");
let index = 0;

scrollLeft.addEventListener("click", () => handleClickScroll(-1));
scrollRight.addEventListener("click", () => handleClickScroll(1));
document.addEventListener("keydown", handleKeyScroll);

function handleClickScroll(val) {
  const newIndex = index + val;
  if (newIndex >= 0 && newIndex < albums.length) {
    index = newIndex;
    updateDisplay();
  }
}

function handleKeyScroll(e) {
  if (e.key === "ArrowLeft") {
    handleClickScroll(-1);
  } else if (e.key === "ArrowRight") {
    handleClickScroll(1);
  }
}

function updateDisplay() {
  const album = albums[index];
  albumTitleSpan.textContent = album.album;
  spotifyWidget.src = album.spotify;

  const number = index + 1;
  albumNum.innerText = number >= 10 ? number + "." : `0${number}.`;
}

updateDisplay();
