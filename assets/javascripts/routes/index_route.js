App.IndexRoute = Ember.Route.extend({
  events: {
    search: function(phrase){
      var self = this;
      T = this;
      $.getJSON("/search", {q: phrase}).done(function(resp) {
        self.controller.set("content", resp.map(function(i) {return App.Result.create(i);}));
      });
    }
  }
});
