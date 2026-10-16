// DEMO ONLY: intentionally vulnerable front-end code for SAST scanner demos.

// Hardcoded API key (FAKE)
const MAPS_API_KEY = "AIzaSyD3m0F4keKeyForScannerTest12345abc";

function renderSearchFromUrl() {
  // DOM-based XSS: untrusted URL fragment written to innerHTML
  const term = decodeURIComponent(window.location.hash.slice(1));
  document.getElementById("result").innerHTML = "Results for: " + term;
}

function runCalculator() {
  // Code injection via eval on user-controlled input
  const expr = new URLSearchParams(window.location.search).get("calc");
  return eval(expr);
}

function legacyWrite(msg) {
  // document.write with untrusted data
  document.write("<p>" + msg + "</p>");
}

function saveSession(token) {
  // Sensitive token stored in localStorage
  localStorage.setItem("auth_token", token);
}

function loadListings() {
  // Plain HTTP request carrying the API key in the URL
  return fetch("http://api.example.com/listings?key=" + MAPS_API_KEY);
}
