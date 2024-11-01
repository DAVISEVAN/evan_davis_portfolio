document.addEventListener("DOMContentLoaded", function() {
    const audio = document.getElementById("background-audio");
    const audioControl = document.getElementById("audio-control");
  
    // Initialize with "Play Music" as the button text
    audioControl.textContent = "Play Music";
  
    // Load playback state and time from localStorage
    const isPlaying = localStorage.getItem("audioPlaying") === "true";
    const currentTime = localStorage.getItem("audioTime") || 0;
  
    // Set audio to stored time
    audio.currentTime = parseFloat(currentTime);
  
    // Start playback if previously playing
    if (isPlaying) {
      audio.play();
      audioControl.textContent = "Pause Music"; // Button should show "Pause" if audio was playing
    }
  
    // Update current time in localStorage during playback
    audio.addEventListener("timeupdate", () => {
      localStorage.setItem("audioTime", audio.currentTime);
    });
  
    // Toggle play/pause state and button text when clicked
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
      localStorage.removeItem("audioTime"); // Reset time when audio ends
      audioControl.textContent = "Play Music";
    });
  });
  