var fs = require("fs");
var path = require("path");
const exec = require("child_process").execSync;

let vendors = require("./vendors.json").vendors;

// Add all the vendor repos as submodules
vendors.forEach(file => {
    console.log(`Updating ${file}`);
    // exec(`git submodule add https://github.com/fmi-crosscheck/${file} ${file}`);
    exec(`(cd vendors/${file}; git pull)`);
});
