const { execSync } = require("child_process");
const fs = require("fs");
const path = require("path");

const config = require("./config").config();
const DB_USER = config.export_db.username;
const DB_PASS = config.export_db.password;
const DB_HOST = config.db.host;
const DB_PORT = config.db.port;
const SOURCE_DB = config.db.database;
const NEW_DB_NAME = "svonline_admin_test";

const TABLES_SQL = path.join(__dirname, "temp_tables.sql");
const ROUTINES_SQL = path.join(__dirname, "temp_routines.sql");
const FINAL_SQL = path.join(__dirname, "final_cleaned.sql");

function cleanSQL(content) {
  content = content.replace(/DEFINER=`[^`]+`@`[^`]+`/g, "");
  content = content.replace(
    /\s*SET\s+@@SESSION\.SQL_LOG_BIN\s*=\s*(0|@MYSQLDUMP_TEMP_LOG_BIN)\s*;/gim,
    ""
  );
  content = content.replace(
    /\s*SET\s+@@GLOBAL\.GTID_PURGED\s*=\s*'[^']*'\s*;/gim,
    ""
  );

  content = content.replace(/\/\*!\d{5}.*?\*\//gs, "");
  content = content.replace(/^\*\/;/gm, "");

  content = content.replace(
    /CREATE TABLE `([^`]+)`/g,
    (match, tableName) =>
      `DROP TABLE IF EXISTS \`${tableName}\`;\nCREATE TABLE \`${tableName}\``
  );

  content = content.replace(
    /CREATE PROCEDURE `([^`]+)`/g,
    (match, procName) =>
      `DROP PROCEDURE IF EXISTS \`${procName}\`;\nCREATE PROCEDURE \`${procName}\``
  );

  content = content.replace(
    /CREATE FUNCTION `([^`]+)`/g,
    (match, funcName) =>
      `DROP FUNCTION IF EXISTS \`${funcName}\`;\nCREATE FUNCTION \`${funcName}\``
  );

  // Fix for improperly quoted function/procedure names
  content = content.replace(
    /CREATE\s+(?:DEFINER=["'`][^"'`]+["'`]@[^\s]+\s+)?(FUNCTION|PROCEDURE)\s+"([^"]+)"/gi,
    (match, type, name) =>
      `DROP ${type.toUpperCase()} IF EXISTS \`${name}\`;\nCREATE ${type.toUpperCase()} \`${name}\``
  );

  return content;
}

try {
  console.log("\ud83d\udce6 Dumping tables...");
  execSync(
    `mysqldump -u${DB_USER} -p\"${DB_PASS}\" -h${DB_HOST} -P${DB_PORT} ${SOURCE_DB} --no-data --skip-add-drop-table --skip-comments --set-gtid-purged=OFF --no-tablespaces > \"${TABLES_SQL}\"`,
    { stdio: "inherit", shell: true }
  );

  console.log("\ud83d\udce6 Dumping procedures/functions...");
  execSync(
    `mysqldump -u${DB_USER} -p\"${DB_PASS}\" -h${DB_HOST} -P${DB_PORT} ${SOURCE_DB} --no-create-info --no-data --skip-comments --routines --no-tablespaces > \"${ROUTINES_SQL}\"`,
    { stdio: "inherit", shell: true }
  );

  console.log("\ud83e\uddf9 Cleaning SQL files...");
  const cleanedTables = cleanSQL(fs.readFileSync(TABLES_SQL, "utf8"));
  const cleanedRoutines = cleanSQL(fs.readFileSync(ROUTINES_SQL, "utf8"));

  fs.writeFileSync(FINAL_SQL, `${cleanedTables}\n\n${cleanedRoutines}`);

  console.log("\ud83d\udcc5 Importing into new database...");
  execSync(
    `mysql -u${DB_USER} -p\"${DB_PASS}\" -h${DB_HOST} -P${DB_PORT} ${NEW_DB_NAME} --ssl-mode=DISABLED < \"${FINAL_SQL}\"`,
    { stdio: "inherit", shell: true }
  );

  fs.unlinkSync(TABLES_SQL);
  fs.unlinkSync(ROUTINES_SQL);
  fs.unlinkSync(FINAL_SQL);

  console.log("\u2705 Database clone complete. All objects recreated cleanly.");
} catch (err) {
  console.error("\u274c Error during cloning:", err.message);
  process.exit(1);
}
