import SirTrevor from 'sir-trevor';
import React from 'react';
import ReactDOM from 'react-dom';

class DividerBlock extends React.Component {
  render () {
    return (
      <div className="stb-divider">
        <hr />
      </div>
    );
  }
}

export default SirTrevor.Block.extend({
  type: 'divider',
  icon_name: 'divider',
  title: () => 'Divider',
  data: {},

  loadData(data) {
    this.data = data;
  },

  onBlockRender() {
    this.renderUi(this.data);
  },

  renderUi(props) {
    ReactDOM.render(
      <DividerBlock {...props}
        blockid={this.blockID}
      />,
      this.editor
    );
  }
});
