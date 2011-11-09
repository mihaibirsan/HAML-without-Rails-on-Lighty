if (WScript.Arguments.Length == 0) {
    WScript.Echo("Please provide the file to convert.");
    WScript.Quit(-1);
}

var fso = new ActiveXObject("Scripting.FileSystemObject");

eval(fso.OpenTextFile('system/libs/less-rhino-1.1.3.js', 1).ReadAll());

var lessFilename = WScript.Arguments.Item(0);
var minCSSFilename = lessFilename.replace(/\.less$/, '.min.css');
if (WScript.Arguments.Length >= 2) minCSSFilename = WScript.Arguments.Item(1);
var lessFile = fso.OpenTextFile(lessFilename, 1);
var minCSSFile = fso.CreateTextFile(minCSSFilename, 2);

(new less.Parser()).parse(lessFile.ReadAll(), function(e, css) {
    minCSSFile.Write(css.toCSS().replace(/\s+/g, ' ').replace(/\s+$/g, '\r\n'));
});

lessFile.Close();
minCSSFile.Close();
