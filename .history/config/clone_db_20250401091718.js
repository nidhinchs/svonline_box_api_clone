const { execSync } = require("child_process");
const fs = require("fs");
const path = require("path");

const config = require("../config").config();
const DB_USER = config.export_db.username;
const DB_PASS = config.db.password;
const DB_HOST = config.db.host;
const DB_PORT = config.db.port;
const SOURCE_DB = config.db.database;
const TARGET_DB = "clinic_automation_test";

// File paths
const TABLES_SQL = path.join(__dirname, "tables_only.sql");
const VIEWS_SQL = path.join(__dirname, "views_only.sql");
const ROUTINES_SQL = path.join(__dirname, "temp_routines_only.sql");
const FINAL_ROUTINES_SQL = path.join(__dirname, "final_routines_only.sql");

// ------------------- Tables -------------------

function cleanTableSQL(content) {
  return content
    .replace(/DEFINER=`[^`]+`@`[^`]+`/g, "")
    .replace(
      /\s*SET\s+@@SESSION\.SQL_LOG_BIN\s*=\s*(0|@MYSQLDUMP_TEMP_LOG_BIN)\s*;/gim,
      ""
    )
    .replace(/\s*SET\s+@@GLOBAL\.GTID_PURGED\s*=\s*'[^']*'\s*;/gim, "")
    .replace(/\/\*!\d{5}.*?\*\//gs, "")
    .replace(/^\*\/;/gm, "")
    .replace(
      /CREATE TABLE `([^`]+)`/g,
      (match, tableName) =>
        `DROP TABLE IF EXISTS \`${tableName}\`;\nCREATE TABLE \`${tableName}\``
    );
}

function getBaseTables() {
  const query = `SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = '${SOURCE_DB}' AND TABLE_TYPE = 'BASE TABLE'`;
  const result = execSync(
    `mysql -u${DB_USER} -p"${DB_PASS}" -h${DB_HOST} -P${DB_PORT} -N -e "${query}"`,
    { encoding: "utf8", shell: true }
  );
  return result
    .trim()
    .split("\n")
    .map((t) => t.trim())
    .filter(Boolean);
}

function cloneTables() {
  console.log("🔍 Fetching base tables...");
  const tables = getBaseTables();
  if (tables.length === 0) throw new Error("No base tables found.");

  console.log("📦 Dumping tables...");
  const rawDump = execSync(
    `mysqldump -u${DB_USER} -p"${DB_PASS}" -h${DB_HOST} -P${DB_PORT} ${SOURCE_DB} ${tables.join(
      " "
    )} --no-data --skip-comments --set-gtid-purged=OFF --no-tablespaces`,
    { encoding: "utf8", shell: true }
  );

  console.log("🧼 Cleaning table SQL...");
  const cleaned = cleanTableSQL(rawDump);
  fs.writeFileSync(TABLES_SQL, cleaned);

  console.log(`📥 Importing tables into ${TARGET_DB}...`);
  execSync(
    `mysql -u${DB_USER} -p"${DB_PASS}" -h${DB_HOST} -P${DB_PORT} ${TARGET_DB} --ssl-mode=DISABLED < "${TABLES_SQL}"`,
    { stdio: "inherit", shell: true }
  );
  console.log("✅ Tables cloned.");
}

// ------------------- Views -------------------

function getViews() {
  const query = `SELECT TABLE_NAME FROM INFORMATION_SCHEMA.VIEWS WHERE TABLE_SCHEMA = '${SOURCE_DB}';`;
  const cmd = `mysql -u${DB_USER} -p"${DB_PASS}" -h${DB_HOST} -P${DB_PORT} -N -e "${query}"`;
  const result = execSync(cmd, { encoding: "utf8", shell: true });
  return result.trim().split("\n").filter(Boolean);
}

function getCreateViewStatement(viewName) {
  const query = `SHOW CREATE VIEW \`${SOURCE_DB}\`.\`${viewName}\`;`;
  const cmd = `mysql -u${DB_USER} -p"${DB_PASS}" -h${DB_HOST} -P${DB_PORT} -N -e '${query}'`;
  const result = execSync(cmd, { encoding: "utf8", shell: true }).trim();
  const parts = result.split("\t");
  let createStmt = parts[1];

  const dbNameRegex = new RegExp(`"${SOURCE_DB}"\\.`, "g");
  createStmt = createStmt.replace(dbNameRegex, "").replace(/"/g, "`");

  return `DROP VIEW IF EXISTS \`${viewName}\`;\n${createStmt};\n`;
}

function cloneViews() {
  console.log("🔍 Fetching views...");
  const views = getViews();
  if (views.length === 0) {
    console.log("No views found.");
    return;
  }

  console.log("📤 Exporting views...");
  let fullSQL = "";
  views.forEach((view) => {
    const stmt = getCreateViewStatement(view);
    if (stmt) fullSQL += stmt + "\n\n";
  });
  fs.writeFileSync(VIEWS_SQL, fullSQL);

  console.log("📥 Importing views...");
  execSync(
    `mysql -u${DB_USER} -p"${DB_PASS}" -h${DB_HOST} -P${DB_PORT} ${TARGET_DB} < "${VIEWS_SQL}"`,
    { stdio: "inherit", shell: true }
  );
  console.log("✅ Views cloned.");
}

// ------------------- Routines -------------------

function cleanRoutineSQL(content) {
  return content
    .replace(/DEFINER=`[^`]+`@`[^`]+`/g, "")
    .replace(
      /\s*SET\s+@@SESSION\.SQL_LOG_BIN\s*=\s*(0|@MYSQLDUMP_TEMP_LOG_BIN)\s*;/gim,
      ""
    )
    .replace(/\s*SET\s+@@GLOBAL\.GTID_PURGED\s*=\s*'[^']*'\s*;/gim, "")
    .replace(/\/\*!\d{5}.*?\*\//gs, "")
    .replace(/^\*\/;/gm, "")
    .replace(
      /CREATE PROCEDURE `([^`]+)`/g,
      (match, name) =>
        `DROP PROCEDURE IF EXISTS \`${name}\`;\nCREATE PROCEDURE \`${name}\``
    )
    .replace(
      /CREATE FUNCTION `([^`]+)`/g,
      (match, name) =>
        `DROP FUNCTION IF EXISTS \`${name}\`;\nCREATE FUNCTION \`${name}\``
    )
    .replace(
      /CREATE\s+(?:DEFINER=["'`][^"'`]+["'`]@[^\s]+\s+)?(FUNCTION|PROCEDURE)\s+"([^"]+)"/gi,
      (match, type, name) =>
        `DROP ${type.toUpperCase()} IF EXISTS \`${name}\`;\nCREATE ${type.toUpperCase()} \`${name}\``
    );
}

function cloneRoutines() {
  console.log("📦 Dumping routines...");
  execSync(
    `mysqldump -u${DB_USER} -p"${DB_PASS}" -h${DB_HOST} -P${DB_PORT} ${SOURCE_DB} --no-create-info --no-data --skip-comments --routines --no-tablespaces > "${ROUTINES_SQL}"`,
    { stdio: "inherit", shell: true }
  );

  console.log("🧼 Cleaning routines SQL...");
  const cleaned = cleanRoutineSQL(fs.readFileSync(ROUTINES_SQL, "utf8"));
  fs.writeFileSync(FINAL_ROUTINES_SQL, cleaned);

  console.log("📥 Importing routines...");
  execSync(
    `mysql -u${DB_USER} -p"${DB_PASS}" -h${DB_HOST} -P${DB_PORT} ${TARGET_DB} --ssl-mode=DISABLED < "${FINAL_ROUTINES_SQL}"`,
    { stdio: "inherit", shell: true }
  );

  // fs.unlinkSync(ROUTINES_SQL);
  // fs.unlinkSync(FINAL_ROUTINES_SQL);
  console.log("✅ Routines cloned.");
}

// ------------------- Main -------------------

(async function main() {
  try {
    console.log("🚀 Starting full clone process...");
    cloneTables();
    cloneViews();
    cloneRoutines();
    console.log("🎉 All objects cloned successfully!");
  } catch (err) {
    console.error("❌ Error:", err.message);
    process.exit(1);
  }
})();
