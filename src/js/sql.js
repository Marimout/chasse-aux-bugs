import * as alasql from 'alasql'

export default function setupAlasql () {
  // initialize database
  alasql('CREATE localStorage DATABASE IF NOT EXISTS bank');
  alasql('ATTACH localStorage DATABASE bank');
  alasql('USE bank');

	// TODO: no... get headers from updateDatabase if headers are differents
  alasql('CREATE TABLE IF NOT EXISTS data (id number, date string, libelle string, montant string, devise string)');

  // Generate data for test
  alasql(`IF NOT EXISTS(SELECT * FROM data)
              SELECT * INTO data FROM ?`,
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
              ]
        );
}
