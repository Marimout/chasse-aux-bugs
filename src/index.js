// @format

import 'semantic-ui-css/semantic.min.css';
import * as alasql from 'alasql';

import {Main} from './Main.elm';
import {injectBlockly, evalBlockly, removeBlockly} from './js/blockly.js';
import {setupAlasql, getDataAndSendToElm, updateData} from './js/sql.js';
import registerServiceWorker from './registerServiceWorker';

var app = Main.embed(document.getElementById('root'));

app.ports.injectBlockly.subscribe(injectBlockly.bind(this, app));
app.ports.evalBlockly.subscribe(evalBlockly.bind(this, app));
app.ports.removeBlockly.subscribe(removeBlockly);

registerServiceWorker();

// Init data in the model
setupAlasql();
getDataAndSendToElm(app);

app.ports.executeQuery.subscribe(function(query) {
  console.log('query', query);

  alasql
    .promise(query)
    .then(function(result) {
      console.log('result', result);
      app.ports.updateQueryExecutionResult.send(result.toString());
      getDataAndSendToElm(app);
    })
    .catch(function(err) {
      console.error('[ERROR]', err);
    });
});

app.ports.updateTableFromData.subscribe(function(data) {
  console.log('data', data);
  updateData(data);
  getDataAndSendToElm(app);
});
