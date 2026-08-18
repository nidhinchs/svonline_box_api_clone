// generate_node_project_doc.js
const fs = require("fs");
const path = require("path");

// --- CONFIG ---
const includeDirs = ["config", "controllers", "routes"];
const includeFiles = ["index.js", "server.js", "package.json"];
const sqlFileExt = ".sql";
const outputMd = path.join(__dirname, "node_project_clean.md");

// 🧭 Recursively get all JS files in allowed folders
function getAllJsFiles(dir) {
  let results = [];
  const list = fs.readdirSync(dir);
  list.forEach((file) => {
    const filePath = path.join(dir, file);
    const stat = fs.statSync(filePath);

    if (stat && stat.isDirectory()) {
      if (!filePath.includes(".history") && !filePath.includes("node_modules"))
        results = results.concat(getAllJsFiles(filePath));
    } else if (file.endsWith(".js")) {
      results.push(filePath);
    }
  });
  return results;
}

// 🧹 Remove single-line & block comments
function removeComments(code) {
  return code
    .replace(/\/\/.*$/gm, "") // single-line
    .replace(/\/\*[\s\S]*?\*\//gm, "") // block
    .trim();
}

// 📦 Extract info from package.json
function extractPackageInfo(filePath) {
  if (!fs.existsSync(filePath)) return null;
  const pkg = JSON.parse(fs.readFileSync(filePath, "utf8"));
  const dependencies = pkg.dependencies
    ? Object.entries(pkg.dependencies)
        .map(([k, v]) => `- ${k}: ${v}`)
        .join("\n")
    : "None";
  const devDependencies = pkg.devDependencies
    ? Object.entries(pkg.devDependencies)
        .map(([k, v]) => `- ${k}: ${v}`)
        .join("\n")
    : "None";
  return {
    name: pkg.name || "Unnamed Project",
    version: pkg.version || "1.0.0",
    description: pkg.description || "",
    main: pkg.main || "index.js",
    dependencies,
    devDependencies
  };
}

// 🧾 Create Markdown
function createMarkdown({ pkgInfo, jsFiles, sqlFile }) {
  let md = `# ${pkgInfo?.name || "Node.js Project"} - Clean Version\n\n`;
  md += `> Generated automatically. Includes only config/, controllers/, routes/, main files, and one SQL file.\n\n`;

  if (pkgInfo) {
    md += `## 🧩 Project Summary\n`;
    md += `**Description:** ${pkgInfo.description}\n\n`;
    md += `**Version:** ${pkgInfo.version}\n\n`;
    md += `**Main File:** ${pkgInfo.main}\n\n`;
    md += `### 📦 Dependencies\n${pkgInfo.dependencies}\n\n`;
    md += `### 🧰 Dev Dependencies\n${pkgInfo.devDependencies}\n`;
  }

  md += `\n---\n`;
  md += `## 📁 Included Files\n`;
  jsFiles.forEach((f) => {
    md += `- ${path.relative(__dirname, f)}\n`;
  });
  if (sqlFile) md += `- ${path.relative(__dirname, sqlFile)} (Database File)\n`;
  md += `\n---\n`;

  // Package.json content
  if (pkgInfo) {
    md += `\n## File: package.json\n\n`;
    const pkgContent = fs.readFileSync("package.json", "utf8");
    md += "```json\n" + pkgContent + "\n```\n";
  }

  // Add each JS file
  jsFiles.forEach((f) => {
    const code = fs.readFileSync(f, "utf8");
    const cleaned = removeComments(code);
    md += `\n## File: ${path.relative(__dirname, f)}\n\n`;
    md += "```javascript\n" + cleaned + "\n```\n";
  });

  // SQL file content
  if (sqlFile) {
    const sqlContent = fs.readFileSync(sqlFile, "utf8");
    md += `\n## File: ${path.relative(__dirname, sqlFile)}\n\n`;
    md += "```sql\n" + sqlContent + "\n```\n";
  }

  return md;
}

// 🚀 MAIN EXECUTION
console.log("🔍 Scanning project...");

// Collect JS files from allowed folders
let jsFiles = [];
includeDirs.forEach((folder) => {
  const folderPath = path.join(__dirname, folder);
  if (fs.existsSync(folderPath)) {
    jsFiles = jsFiles.concat(getAllJsFiles(folderPath));
  }
});

// Add main index.js or server.js if present
includeFiles.forEach((file) => {
  const filePath = path.join(__dirname, file);
  if (fs.existsSync(filePath) && !file.endsWith(".json")) {
    jsFiles.push(filePath);
  }
});

// Find one SQL file in root directory
const sqlFile = fs.readdirSync(__dirname).find((f) => f.endsWith(sqlFileExt))
  ? path.join(
      __dirname,
      fs.readdirSync(__dirname).find((f) => f.endsWith(sqlFileExt))
    )
  : null;

if (jsFiles.length === 0 && !sqlFile) {
  console.log("⚠️ No eligible files found.");
  process.exit(0);
}

const pkgInfo = extractPackageInfo(path.join(__dirname, "package.json"));

console.log(
  `📂 Found ${jsFiles.length} JS files${sqlFile ? " and 1 SQL file" : ""}.`
);
console.log("🧹 Cleaning & merging...");

const markdown = createMarkdown({ pkgInfo, jsFiles, sqlFile });
fs.writeFileSync(outputMd, markdown, "utf8");

console.log(`✅ Done! Markdown file created:\n${outputMd}`);
