import 'semantic-ui-css/semantic.min.css';
// import Blockly from 'blockly/blockly_compressed.js';
import 'script-loader!blockly/blockly_compressed.js';
import 'script-loader!blockly/blocks_compressed.js'
import 'script-loader!blockly/msg/js/fr.js'
import { Main } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';

Main.embed(document.getElementById('root'));

registerServiceWorker();

console.log(Blockly)
