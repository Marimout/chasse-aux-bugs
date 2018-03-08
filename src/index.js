import 'semantic-ui-css/semantic.min.css';
import * as alasql from 'alasql'
// import Blockly from 'blockly/blockly_compressed.js';
import 'script-loader!blockly/blockly_compressed.js';
import 'script-loader!blockly/blocks_compressed.js'
import 'script-loader!blockly/msg/js/fr.js'

import { Main } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';

var app = Main.embed(document.getElementById('root'));

registerServiceWorker();

console.log(Blockly)

// initialize database
alasql('CREATE localStorage DATABASE IF NOT EXISTS bank');
alasql('ATTACH localStorage DATABASE bank');
alasql('USE bank');

alasql('CREATE TABLE IF NOT EXISTS transaction (id number, date string, libelle string, montant string, devise string)');

// Generate data for test
alasql(`IF NOT EXISTS(SELECT * FROM transaction) 
            SELECT * INTO transaction FROM ?`,
            [
                [
                    {id:1, date: '01/02/2018', libelle: 'Amazon', montant: '65,90', devise: '€'},
                    {id:2, date: '02/02/2018', libelle: 'Darty', montant: '150,00', devise: '€'},
                    {id:3, date: '04/02/2018', libelle: 'FNAC', montant: '32,90', devise: '€'},
                    {id:4, date: '06/02/2018', libelle: 'Auchan', montant: '22,09', devise: '€'},
                    {id:5, date: '10/02/2018', libelle: 'Carrefour', montant: '54,12', devise: '€'},
                    {id:6, date: '15/02/2018', libelle: 'Gilbert Jeune', montant: '20,99', devise: '€'},
                    {id:7, date: '28/02/2018', libelle: 'Surface Pro from Microsoft store', montant: '1499,99', devise: '€'}
                ]
            ]);

// Init data in the model
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

function getDataAndSendToElm()
{
    var res = alasql('SELECT * FROM transaction');

    app.ports.loadDataFromDatabase.send(res);
}

