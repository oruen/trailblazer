Em.Handlebars.registerBoundHelper("summary", function(obj) {
  var res = [];
  for (i in obj) {
    if (obj.hasOwnProperty(i)) {
      var str = JSON.stringify(obj[i]);
      str = str.replace(/(\d+){4,}/g, function(m) {return "<a href=\"#/object/" + m + "\">" + m + "</a>"})
      res.push("<strong>" + i + "</strong>: " + str);
    }
  }
  return new Handlebars.SafeString(res.join("<br>"));
});
