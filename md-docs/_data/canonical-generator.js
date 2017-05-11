var argv = require('yargs').argv,
  version = argv.version,
  inputfile = version + '.yaml',
  yaml = require('js-yaml'),
  fs = require('fs'),
  sitemap = yaml.load(fs.readFileSync(inputfile, {encoding: 'utf-8'}));

function mapPathToFile(routes) {
  routes.forEach(function(route) {
    mapRouteToFile(route);
    if (route.items) {
      mapPathToFile(route.items);
    }
  });
};
var mkdirp = require('mkdirp');
var getDirName = require('path').dirname;
function mapRouteToFile(route) {
  var text = '---\n' +
    'permalink: ' + route.path + '\n' +
    'redirect_to: ' + route.redirect_to + '\n' +
    '---';

  mkdirp(getDirName('../_' + version + '/' + route.path), function (err) {
    if (err) return cb(err);

    fs.writeFile('../_' + version + '/' + route.path.replace('.html', '.md'), text, function (err) {
      if (err) return console.log(err);
    });
  });
};

function compareStrings(string1, string2) {
  compareNum = 0; // why are you using the Number contructor? Unneeded.

  l = Math.min(string1.length, string2.length);
  for( i=0; i<l; i++) {
    if( string1.charAt(i) == string2.charAt(i)) compareNum++;
  }
  return compareNum;
};

mapPathToFile(sitemap);
