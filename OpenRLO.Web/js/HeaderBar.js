var headerbar = function () {
  var opts = {
    "symbol": "&#10026;",
    "font-size": "64px",
    "color": "#eee",
    "time": 3000
  };
  if (window.headerbar && window.headerbarOptions) {
    var d = window.headerbarOptions;
    if (d["font-size"]) opts["font-size"] = d["font-size"];
    if (d.color) opts.color = d.color;
    if (d.time) opts.time = d.time;
    if (d.symbol) opts.symbol = d.symbol;
  }
//  $.getJSON("http://api.twitter.com/1/trends/current.json?callback=?", function (data) {
//    var trending;
//    $.each(data.trends, function (key, value) {
//      trending = value;
//    });
//    var html = "<div id=\"headerbar\" style=\"position:absolute;left:0px;top:0px;width:100%;" +
//			"background-color:rgba(0,0,0,0.7);font-size:" + opts["font-size"] + ";font-family:helvetica,arial,sans-serif;color:" + opts.color + ";" +
//			"text-shadow:0 2px 1px rgba(0,0,0,0.7);\"><div id=\"headerbar-symbol\" style=\"padding:15px 0;float:left;width:80px;text-align:center;margin-right:5px;border-right:solid 1px rgba(0,0,0,0.3);\">" +
//			opts.symbol + "</div><div id=\"headerbar-trend\" style=\"margin-left:81px;border-left:solid 1px rgba(255,255,255,0.2);font-weight:bold;padding:15px 20px;\">" +
//			"<a id=\"headerbar-link\" style=\"color:" + opts.color + ";text-decoration:none;\" href=\"http://twitter.com/search/" + encodeURIComponent(trending[0].query) + "\">" + trending[0].name + "</a>" +
//			"</div><div style=\"clear:both;height:1px;font-size:1px;\">&#160;</div></div>";
//    $("body").append(html);
//    var height = $("#headerbar").height();
//    var half = height / 2;
//    $("#headerbar").append("<div style=\"position:absolute;left:0px;top:" + half + "px;width:100%;height:1px;font-size:1px;background-color:rgba(0,0,0,0.3);\">&#160;</div>");
//    $("#headerbar").append("<div style=\"position:absolute;left:0px;top:" + (half + 1) + "px;width:100%;height:1px;font-size:1px;background-color:rgba(255,255,255,0.2);\">&#160;</div>");
//    $("#headerbar").append("<div id=\"headerbar-frame\" style=\"display:none;position:absolute;left:0px;top:0px;width:100%;height:1px;font-size:1px;background-color:rgba(0,0,0,0.5);\">&#160;</div>");
//    setTimeout(function () { headerbarUpdate(trending, 1, opts.time); }, opts.time);
//  });
  //


  var html = "<div id=\"headerbar\" style=\"position:absolute;left:0px;top:0px;width:100%;" +
			"background-color:rgba(0,0,0,0.7);font-size:" + opts["font-size"] + ";font-family:helvetica,arial,sans-serif;color:" + opts.color + ";" +
			"text-shadow:0 2px 1px rgba(0,0,0,0.7);\"><div id=\"headerbar-symbol\" style=\"padding:15px 0;float:left;width:80px;text-align:center;margin-right:5px;border-right:solid 1px rgba(0,0,0,0.3);\">" +
			opts.symbol + "</div><div id=\"headerbar-trend\" style=\"margin-left:81px;border-left:solid 1px rgba(255,255,255,0.2);font-weight:bold;padding:15px 20px;\">" +
			"<a id=\"headerbar-link\" style=\"color:" + opts.color + ";text-decoration:none;\" href=\"http://twitter.com/search/\">" + trending[0].name + "</a>" +
			"</div><div style=\"clear:both;height:1px;font-size:1px;\">&#160;</div></div>";
  $("body").append(html);
  var height = $("#headerbar").height();
  var half = height / 2;
  $("#headerbar").append("<div style=\"position:absolute;left:0px;top:" + half + "px;width:100%;height:1px;font-size:1px;background-color:rgba(0,0,0,0.3);\">&#160;</div>");
  $("#headerbar").append("<div style=\"position:absolute;left:0px;top:" + (half + 1) + "px;width:100%;height:1px;font-size:1px;background-color:rgba(255,255,255,0.2);\">&#160;</div>");
  $("#headerbar").append("<div id=\"headerbar-frame\" style=\"display:none;position:absolute;left:0px;top:0px;width:100%;height:1px;font-size:1px;background-color:rgba(0,0,0,0.5);\">&#160;</div>");

  //

};

//var headerbarUpdate = function (trending, i, time) {
//  $("#headerbar-frame").show().animate({ "height": $("#headerbar").height() }, 100, function () {
//    $("#headerbar-frame").hide().css({ "height": 1 });
//    $("#headerbar-link").attr("href", "http://twitter.com/search/" + encodeURIComponent(trending[i].query)).html(trending[i].name);
//  });
//  var next = i + 1; if (next >= trending.length) next = 0;
//  setTimeout(function () { headerbarUpdate(trending, next, time); }, time);
//};


if (window.jQuery) {
  headerbar();
} else {
  var headerbar_head = document.getElementsByTagName("HEAD")[0];
  var headerbar_script = document.createElement("script");
  headerbar_script.type = "text/javascript";
  headerbar_script.src = "http://ajax.googleapis.com/ajax/libs/jquery/1.5.1/jquery.min.js";
  headerbar_script.onreadystatechange = function () {
    if (this.readyState == 'complete') headerbar();
  }
  headerbar_script.onload = headerbar;
  headerbar_head.appendChild(headerbar_script);
}