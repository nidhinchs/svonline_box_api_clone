var express = require('express');

var router = express.Router();

const item = require('../controllers/item');
const quiz = require('../controllers/quiz');
const student = require('../controllers/student');
const copyFile = require('../controllers/copyFile');
const video = require('../controllers/video');
const db = require('../controllers/DbController');
const temp = require('../controllers/temperature');

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
router.get('/api/get_temperature',temp.get_temperature);
// router.post('/upload',video.upload_file);

//student data

router.get('/api/get_quiz',quiz.get_quiz);
router.get('/api/get_course',quiz.get_course);
router.get('/api/get_subject',quiz.get_subject);
router.get('/api/get_video',quiz.get_video);
router.get('/api/get_note',quiz.get_note);
router.post('/api/add_result',quiz.add_result);
router.post('/api/add_progress',quiz.add_progress);
router.get('/api/get_result',quiz.get_result);
router.get('/api/get_result_detail',quiz.get_result_detail);

router.get('/api/login',student.login);
router.get('/api/get_profile',student.get_profile);

module.exports = router;
