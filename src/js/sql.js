// @format

import * as alasql from 'alasql';

export function getDataAndSendToElm(app) {
  let select = alasql('SELECT * FROM data');

  console.log('select', select);
  app.ports.loadDataFromDatabase.send(sqlRowsToCsvString(select));
}

export function updateData(data) {
  alasql('TRUNCATE TABLE data');
  alasql(`SELECT * INTO data FROM ?`, csvToSqlRows(data));
}

export function setupAlasql() {
  // initialize database
  alasql('CREATE localStorage DATABASE IF NOT EXISTS bank');
  alasql('ATTACH localStorage DATABASE bank');
  alasql('USE bank');

  // TODO: remove all that
  alasql(
    'CREATE TABLE IF NOT EXISTS data (id string, date string, libelle string, montant string, devise string)',
  );

  // Generate data for test
  alasql(
    `IF NOT EXISTS(SELECT * FROM data)
              SELECT * INTO data FROM ?`,
    [
      [
        {
          id: '1',
          date: '01/02/2018',
          libelle: 'Amazon',
          montant: '65,90',
          devise: '€',
        },
        {
          id: '2',
          date: '02/02/2018',
          libelle: 'Darty',
          montant: '150,00',
          devise: '€',
        },
        {
          id: '3',
          date: '04/02/2018',
          libelle: 'FNAC',
          montant: '32,90',
          devise: '€',
        },
        {
          id: '4',
          date: '06/02/2018',
          libelle: 'Auchan',
          montant: '22,09',
          devise: '€',
        },
        {
          id: '5',
          date: '10/02/2018',
          libelle: 'Carrefour',
          montant: '54,12',
          devise: '€',
        },
        {
          id: '6',
          date: '15/02/2018',
          libelle: 'Gilbert Jeune',
          montant: '20,99',
          devise: '€',
        },
        {
          id: '7',
          date: '28/02/2018',
          libelle: 'Surface Pro from Microsoft store',
          montant: '1499,99',
          devise: '€',
        },
      ],
    ],
  );
}

function sqlRowsToCsvString(rows) {
  if (!rows || !rows.length) return '';

  let headers = Object.keys(rows[0]);
  let records = rows.map(Object.values);
  let csv = [headers].concat(records).join('\n');

  console.log('csv', csv);
  return csv;
}

function csvToSqlRows(csv) {
  if (!csv || !csv.headers || !csv.records) return [];

  let rows = csv.records.map(record => {
    let row = {};
    record.forEach((val, i) => (row[csv.headers[i]] = val));
    return row;
  });

  console.log('rows', rows);
  return [rows];
}
