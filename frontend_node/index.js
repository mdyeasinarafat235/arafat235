const express = require("express");
const fetch = require("node-fetch"); // Node.js 18+ fetch builtin

const app = express();
const port = 8080;

app.get("/", async (req, res) => {
    try {
        const response = await fetch("http://127.0.0.1:5000/api");
        const data = await response.json();
        res.send(`<h1>Node Frontend</h1><p>Backend says: ${data.message}</p>`);
    } catch (err) {
        res.send(`<h1>Node Frontend</h1><p>Backend error!</p>`);
    }
});

app.listen(port, () => console.log(`Node server running on port ${port}`));
