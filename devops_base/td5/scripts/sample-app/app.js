const express = require('express');
const app = express();
app.get('/', (req, res) => {
    res.send('Hello, World!');
});
app.get('/name/:name', (req, res) => {
    res.send(`Hello, ${req.params.name}!`);
});
app.get('/:a/:b', (req, res) => {
    res.send(String(Number(req.params.a)+Number(req.params.b)));
});
module.exports = app;