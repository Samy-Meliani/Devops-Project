const express = require('express');
const app = express();
const backendHost = 'sample-app-backend-service';

app.get('/', async (req, res) => {
    const response = await fetch(`http://${backendHost}`);
    const responseBody = await response.json();
    res.render('hello', { name: responseBody.text });
});

app.get('/name/:name', (req, res) => {
    res.send(`Hello, ${req.params.name}!`);
});

app.get('/:a/:b', (req, res) => {
    res.send(String(Number(req.params.a)+Number(req.params.b)));
});
module.exports = app;