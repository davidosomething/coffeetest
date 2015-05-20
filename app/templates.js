var Hogan = require('hogan.js');

var t = {
  /* jshint ignore:start */
  'article' : new Hogan.Template({code: function (c,p,i) { var t=this;t.b(i=i||"");t.b("<article>");t.b("\n" + i);t.b("  <h1>Test article</h1>");t.b("\n" + i);t.b("</article>");t.b("\n");return t.fl(); },partials: {}, subs: {  }}),
  'hr' : new Hogan.Template({code: function (c,p,i) { var t=this;t.b(i=i||"");t.b("<hr>");t.b("\n");return t.fl(); },partials: {}, subs: {  }})
  /* jshint ignore:end */
},
r = function(n) {
  var tn = t[n];
  return function(c, p, i) {
    return tn.render(c, p || t, i);
  };
};
module.exports = {
  'article' : r('article'),
  'hr' : r('hr')
};