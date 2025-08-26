const express = require("express");
const app = express();
const port = 8080;

app.get("/", (req, res) => res.send("Hello from Mobile Node Lab!"));
app.listen(port, () => console.log(`Server running on port ${port}`));
