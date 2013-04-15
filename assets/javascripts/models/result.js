App.Result = Em.Object.extend({
  summary: function() {
    s = "";
    for(i in this) {
      if (this.hasOwnProperty(i)) {
        s += i + ": " + this[i] + "\n";
      }
    }
    return s;
  }.property()
});
