import SirTrevor from 'sir-trevor';
import React from 'react';
import ReactDOM from 'react-dom';
import Button from './button';

export default SirTrevor.Block.extend({
  type: 'button',
  icon_name: 'button',
  title: () => 'Button',
  data: {},

  loadData (data) {
    this.data = data;
  },

  onBlockRender () {
    this.renderUi(this.data);
  },

  renderUi (props) {
    const setAndLoadData = this.setAndLoadData.bind(this);
    ReactDOM.render(
      <Button {...props}
        blockid={this.blockID}
        updateData={setAndLoadData}
      />,
      this.editor
    );
  }

});
