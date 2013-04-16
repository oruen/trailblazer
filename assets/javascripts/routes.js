//= require_tree ./routes
App.Router.reopen({
  location: 'hash'
});
App.Router.map(function() {
  this.route('object', {path: '/object/:id'});
});

