import SirTrevor from 'sir-trevor';
import React from 'react'
import ReactDOM from 'react-dom';
import PropTypes from 'prop-types'

const cssClassParent = "m-121-questions";

class One21Question extends React.Component {

  coreQuestionChange (ev) {
    console.log(ev.target);
  }

  render() {
    return (
      <div className={cssClassParent}>
        <div
          contentEditable="true"
          onKeyUp={this.coreQuestionChange.bind(this)}
        >
        </div>
        <a>Add subquestion</a>
      </div>
    );
  }
}

export default SirTrevor.Block.extend({
  type: 'question',
  icon_name: 'question',
  title: () => 'Question',
  data: {},

  loadData(data) {
    this.data = data;
  },

  onBlockRender() {
    this.renderUi(this.data);
  },

  renderUi(props) {
    const setAndLoadData = this.setAndLoadData.bind(this);
    ReactDOM.render(
      <One21Question {...props}
        blockid={this.blockID}
        updateData={setAndLoadData}
      />,
      this.editor
    );
  }

});
