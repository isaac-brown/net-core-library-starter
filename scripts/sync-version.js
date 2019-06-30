/**
 * Utility script to sync version changes from package.json --> csharp project.
 */

const replace = require("replace-in-file");
const npm = require("../package.json");

// Configure replace-in-file options.
const options = {
  files: "src/**/*.csproj",
  from: /<Version>(.+)<\/Version>/g,
  to: `<Version>${npm.version}</Version>`
};

// Perform the replacement.
replace(options).catch(error => {
  console.error("Failed to synchronize npm version:", error);
});

console.log("[INFO] finished synchronizing version");
