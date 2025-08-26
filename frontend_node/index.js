const express = require("express");
const fetch = require("node-fetch");
const os = require("os");

const app = express();
const port = 8080;

// Automatic local IP detection
function getLocalIP() {
    const interfaces = os.networkInterfaces();
    for (let iface of Object.values(interfaces)) {
        for (let alias of iface) {
            if (alias.family === "IPv4" && !alias.internal) {
                return alias.address;
            }
        }
    }
    return "127.0.0.1";
}

const FLASK_IP = getLocalIP();  // এখানে আর manual IP বসানোর দরকার নেই
const FLASK_PORT = 5000;

app.get("/", async (req, res) => {
    try {
        const response = await fetch(`http://${FLASK_IP}:${FLASK_PORT}/api`);
        const data = await response.json();
        res.send(`<h1>Node Frontend</h1><p>Backend says: ${data.message}</p>`);
    } catch (err) {
        res.send(`<h1>Node Frontend</h1><p>Backend error!</p>`);
    }
});

// Node server 0.0.0.0 host এ listen করবে
app.listen(port, '0.0.0.0', () => console.log(`Node server running on port ${port}`));
