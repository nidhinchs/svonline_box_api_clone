var express = require('express');
var router = express.Router();

const item = require('../controllers/item');
const db = require('../controllers/DbController');

/* GET home page. */
router.get('/', function (req, res, next) {
    res.render('index', {title: 'Express'});
});
router.get('/_health', (req, res) => {
    res.status(200).send('ok')
});
//admin data
router.get('/api/update_database', db.updateDatabase);
router.get('/api/update_admin_data', item.update_admin_data);




module.exports = router;
