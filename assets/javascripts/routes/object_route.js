App.ObjectRoute = Em.Route.extend({
  model: function(params) {
    return $.getJSON("/object", {q: params.id });
  },
  serialize: function(model) {
    return {id: model.id};
  },
  renderTemplate: function() {
    this._super();
    this.render('related', {
      into: 'object',
      outlet: 'related',
      controller: this.controllerFor('related')
    });
  },
  setupController: function(controller, model) {
    this._super();
    var self = this;
    $.getJSON("/related", {q: model.id}).then(function(related) {
      self.controllerFor('related').set('content', related);
    });
  }
});
