const express = require('express');
const app = express();
const bodyParser = require('body-parser');

const db = require('./Utils/dbConnect');

require('dotenv').config();
const PORT = process.env.PORT || 8000;

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

// app.use('/', (req, res, next) => {
//     console.log("SUCCESS!");
//     return res.status(200).json({user: "Vansh Chheda"})
// });

const userRoutes = require('./Utils/allUserRoutes');
userRoutes.User_Routes(app);

db.mongoConnect(() => {

    app.listen(PORT, () => {
        console.log(`Server UP at port ${PORT}`);
    });

});