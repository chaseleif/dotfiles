require(['notebook/js/codecell'], function (codecell) {
  codecell.CodeCell.options_default.cm_config.autoCloseBrackets = false;
  codecell.CodeCell.options_default.cm_config.completeSingle = false;
})
var cell = Jupyter.notebook.get_selected_cell();
var patch = {
  CodeCell: {
    cm_config: {
      autoCloseBrackets: false,
      completeSingle: false
    }
  }
}
cell.config.update(patch);
