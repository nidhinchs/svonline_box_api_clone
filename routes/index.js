var express = require('express');

var router = express.Router();

const item = require('../controllers/item');
const copyFile = require('../controllers/copyFile');
const video = require('../controllers/video');
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

router.get('/api/update_database_data', item.update_database_data);
router.get('/api/copy_file', copyFile.copy_file);
router.post('/api/upload_video',video.upload_video);
// router.post('/upload',video.upload_file);

module.exports = router;
