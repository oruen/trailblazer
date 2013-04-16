Em.Handlebars.registerBoundHelper("summary", function(obj) {
  var res = [];
  for (i in obj) {
    if (obj.hasOwnProperty(i)) {
      res.push("<strong>" + i + "</strong>: " + JSON.stringify(obj[i]));
    }
  }
  return new Handlebars.SafeString(res.join("<br>"));
});
