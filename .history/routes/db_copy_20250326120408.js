const { exec } = require("child_process");
const fs = require("fs");
const path = require("path");
let config = require("../config/config.json").config();

const DB_USER = config.export_db.username;
const DB_PASS = config.export_db.password;
const DB_HOST = config.export_db.host;
const DB_PORT = config.export_db.port;
const DB_NAME = config.export_db.database;
const BACKUP_DIR = path.join(__dirname, "backups");

const date = new Date().toISOString().replace(/:/g, "-");
const backupFile = path.join(BACKUP_DIR, `${DB_NAME}_backup_${date}.sql`);

if (!fs.existsSync(BACKUP_DIR)) {
  fs.mkdirSync(BACKUP_DIR);
}

const cmd = `mysqldump -u${DB_USER} -p${DB_PASS} -h${DB_HOST} -P${DB_PORT} --ssl-mode=REQUIRED ${DB_NAME} > ${backupFile}`;

exec(cmd, (error, stdout, stderr) => {
  if (error) {
    console.error(`❌ Error backing up database: ${error.message}`);
    return;
  }
  console.log(`✅ Backup successful: ${backupFile}`);
});
