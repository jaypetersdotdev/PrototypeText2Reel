const express = require('express');
const app = express();
const port = 3001;

// Serve static files from the 'public' directory
app.use(express.static('public'));

// Route to serve 'twitter-example.html'
app.get('/', (req, res) => {
    res.sendFile(__dirname + '/public/twitter-example.html');
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
