const express = require("express");
const path = require("path");

const app = express();

// Serve static files from the "public" directory
app.use(express.static(path.join(__dirname, "public")));

// Define a route to render your HTML file
app.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "views", "bloodshare.html"));
});
app.get("/camp.html", (req, res) => {
  res.sendFile(path.join(__dirname, "views", "camp.html"));
});
app.get("/signup.html", (req, res) => {
  res.sendFile(path.join(__dirname, "views", "signup.html"));
});
app.get("/login.html", (req, res) => {
  res.sendFile(path.join(__dirname, "views", "login.html"));
});
app.get("/newregistration.html", (req, res) => {
  res.sendFile(path.join(__dirname, "views", "newregistration.html"));
});
app.get("/recentchages.html", (req, res) => {
  res.sendFile(path.join(__dirname, "views", "recentchages.html"));
});
app.get("/reports.html", (req, res) => {
  res.sendFile(path.join(__dirname, "views", "reports.html"));
});
app.get("/inventory.html", (req, res) => {
  res.sendFile(path.join(__dirname, "views", "inventory.html"));
});
app.get("/co-adminmanage.html", (req, res) => {
  res.sendFile(path.join(__dirname, "views", "co-adminmanage.html"));
});
app.get("/inventoryform.html", (req, res) => {
  res.sendFile(path.join(__dirname, "views", "inventoryform.html"));
});
app.get("/index.html", (req, res) => {
  res.sendFile(path.join(__dirname, "views", "inventoryform.html"));
});

app.listen(3000, () => {
  console.log("Server is running on port 3000");
});
