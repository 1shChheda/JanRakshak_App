exports.Admin_Routes = (app) => {
    app.use(
        '/admin',
        require('../Admin/Routes/hospital'),
    );
};