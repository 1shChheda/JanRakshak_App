exports.User_Routes = (app) => {
    app.use(
        '/user',
        require('../Users/Routes/profile'),
        require('../Users/Routes/emergency')
    );
};