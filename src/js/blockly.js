// @format
// import 'script-loader!blockly/blockly_compressed.js';
// import 'script-loader!blockly/blocks_compressed.js';
// import 'script-loader!blockly/javascript_compressed.js';
// import 'script-loader!blockly/msg/js/fr.js';

export default function injectBlockly(args) {
  var [divId, toolbox] = args;

  let initBlocklyWorkspace = () => {
    let blocklyDiv = document.getElementById(divId);

    if (!blocklyDiv) {
      console.log('ERROR: no ' + divId);
      setTimeout(initBlocklyWorkspace, 200);
      return;
    }
    //blocklyDiv.style.height = '100%';

    window.workspace = Blockly.inject(blocklyDiv, {
      toolbox: toolbox,
    });

    initReplaceBlock();
    //window.addEventListener('resize', onWorkspaceResize);
    //onWorkspaceResize();
  };

  initBlocklyWorkspace();
}

// TODO: add delete workspace function, called when page change
// TODO: add event that generate the code and interprete it

function onWorkspaceResize() {
  var blocklyDiv = document.getElementById('blocklyWorkspace');
  var rootDiv = document.getElementById('root');

  blocklyDiv.style.height =
    window.innerHeight - rootDiv.children[0].children[0].offsetHeight + 'px';

  Blockly.svgResize(window.workspace);
}

export function initReplaceBlock() {
  Blockly.Blocks['text_replace'] = {
    init: function() {
      this.appendValueInput('in')
        .setCheck('String')
        .appendField('dans le texte');
      this.appendValueInput('from')
        .setCheck('String')
        .appendField('remplacer tout');
      this.appendValueInput('to')
        .setCheck('String')
        .appendField('par');
      this.setInputsInline(true);
      this.setOutput(true, 'String');
      this.setColour(165);
      this.setTooltip('renvois un nouveau texte');
      this.setHelpUrl(
        'https://developer.mozilla.org/fr/docs/Web/JavaScript/Reference/Objets_globaux/String/replace',
      );
    },
  };
  Blockly.JavaScript['text_replace'] = function(block) {
    var value_in = Blockly.JavaScript.valueToCode(
      block,
      'in',
      Blockly.JavaScript.ORDER_ATOMIC,
    );
    var value_from = Blockly.JavaScript.valueToCode(
      block,
      'from',
      Blockly.JavaScript.ORDER_ATOMIC,
    );
    var value_to = Blockly.JavaScript.valueToCode(
      block,
      'to',
      Blockly.JavaScript.ORDER_ATOMIC,
    );
    // TODO: Assemble JavaScript into code variable.
    var code = value_in.replace(value_from, value_to);
    // TODO: Change ORDER_NONE to the correct strength.
    return [code, Blockly.JavaScript.ORDER_MEMBER];
  };
}
