var fs = require("fs");
var path = require("path");
const exec = require("child_process").execSync;

let files = [
    "3DS",
    "ANSYS",
    "AVL",
    "Algoryx",
    "Altair",
    "CarSim",
    "Claytex",
    "Controllab",
    "Cosimate",
    "Cybernetica",
    "Dofware",
    "Dynardo",
    "EDF",
    "ESi",
    "ETAS",
    "EcosimPro",
    "Exothermia",
    "FEV",
    "FMI",
    "FunctionBay",
    "GammaTechnologies",
    "IBM",
    "IFP",
    "IPG",
    "IntoCPS",
    "LBL",
    "LIU",
    "MSC",
    "Maplesoft",
    "Mentor",
    "MoBA",
    "Modelon",
    "MpCCI",
    "NI",
    "NoMagic",
    "OM",
    "PMSF",
    "PodiumTechnology",
    "QTronic",
    "Ricardo",
    "SIANI",
    "SINTEF",
    "SKF",
    "Scilab",
    "Siemens",
    "SimWB",
    "TLK",
    "TNO",
    "TWT",
    "Tesis-Dynaware",
    "UCB",
    "Vector",
    "VirtualMotion",
    "Wolfram",
    "assystem",
    "br-automation",
    "dSpace",
    "daetools",
    "fluidon",
    "froglogic",
    "overture",
    "powersys",
    "tonqyuan",
    "tugraz",
    "widle",
];

let modules = "";
files.forEach(file => {
    let config = `[submodule "vendors/${file}"]
    path = vendors/${file}
    url = https://github.com/fmi-crosscheck/${file}
`;
    modules += config;
});

console.log(modules);
