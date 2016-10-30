// Generated by CoffeeScript 1.11.1
var Model;

import Field from './Field';

export default Model = function () {
  function Model(corpus, spec) {
    this.corpus = corpus;
    this.spec = spec;
    this.name = this.spec.name;
  }

  Model.prototype._forBackend = function (backend, bindingOptions) {
    return backend.bindModel(this, bindingOptions);
  };

  Model.prototype.forBackend = function (backendName, bindingOptions) {
    return this._forBackend(this.corpus.getBackend(backendName), bindingOptions);
  };

  return Model;
}();