import 'semantic-ui-css/semantic.min.css';
import * as alasql from 'alasql'
//import 'script-loader!blockly/blockly_compressed.js';
//import 'script-loader!blockly/blocks_compressed.js'
//import 'script-loader!blockly/msg/js/fr.js'

import { Main } from './Main.elm';
import injectBlockly from './js/blockly.js';
import setupAlasql from './js/sql.js';
import registerServiceWorker from './registerServiceWorker';

var app = Main.embed(document.getElementById('root'));

app.ports.injectBlockly.subscribe(injectBlockly);

registerServiceWorker();

// Init data in the model
setupAlasql();
getDataAndSendToElm();

app.ports.executeQuery.subscribe(function(query) {
    console.log(query);

    alasql
    .promise(query)
    .then(function(res) {
        console.log(res);
        app.ports.updateQueryExecutionResult.send(res.toString());
        getDataAndSendToElm();
    }).catch(function(err) {
        console.log(err);
    });

});

function getDataAndSendToElm() {
    var res = alasql('SELECT * FROM transaction');

    app.ports.loadDataFromDatabase.send(res);
}

app.ports.updateTableFromData.subscribe(function(data) {
    alasql('TRUNCATE TABLE transaction');
    alasql(`SELECT * INTO transaction FROM ?`, [data])

    getDataAndSendToElm();
})
