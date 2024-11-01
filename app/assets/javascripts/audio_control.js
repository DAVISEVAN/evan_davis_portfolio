document.addEventListener("DOMContentLoaded", function() {
    const audio = document.getElementById("background-audio");
    const audioControl = document.getElementById("audio-control");
  
    // Check localStorage for playback state and time
    const isPlaying = localStorage.getItem("audioPlaying") === "true";
    const currentTime = localStorage.getItem("audioTime") || 0;
  
    // Set audio time to stored value and play if previously playing
    audio.currentTime = parseFloat(currentTime);
    if (isPlaying) {
      audio.play();
    }
  
    // Update localStorage with current time during playback
    audio.addEventListener("timeupdate", () => {
      localStorage.setItem("audioTime", audio.currentTime);
    });
  
    // Toggle play/pause state with the button
    audioControl.addEventListener("click", () => {
      if (audio.paused) {
        audio.play();
        audioControl.textContent = "Pause Music";
        localStorage.setItem("audioPlaying", "true");
      } else {
        audio.pause();
        audioControl.textContent = "Play Music";
        localStorage.setItem("audioPlaying", "false");
      }
    });
  
    // Reset play state when audio ends
    audio.addEventListener("ended", () => {
      localStorage.setItem("audioPlaying", "false");
      localStorage.removeItem("audioTime"); // Reset time at end
      audioControl.textContent = "Play Music";
    });
  });
  