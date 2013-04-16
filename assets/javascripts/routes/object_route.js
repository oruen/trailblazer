App.ObjectRoute = Em.Route.extend({
  model: function(params) {
    return $.getJSON("/object", {q: params.id });
  },
  serialize: function(model) {
    return {id: model.id};
  }
  //deserialize: function(params) {
    //var proxy = Em.ObjectProxy.create({content: {id: params}});
    //this.model(params).then(function(d) { proxy.set("content", d); });
    //return proxy;
  //}
});
