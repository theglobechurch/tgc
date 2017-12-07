import SirTrevor from 'sir-trevor';
import React from 'react'
import ReactDOM from 'react-dom';
import PropTypes from 'prop-types';

const cssClassParent = "stb-questions";

class One21Question extends React.Component {

  constructor(props) {
    super(props);
    const subQuestions = this.props.subQuestions || [];
    this.state = { subQuestions: subQuestions };
  }

  preventNewLine (ev) {
    if (ev.which === 13) { ev.preventDefault(); }
  }

  subQuestionReturn (ev) {
    if (ev.which === 13 && this.state.subQuestions.length <= 3) {
      this.addNewSubQuestion(ev)
    }
  }

  saveCoreQuestion (ev) {
    const coreQuestion = ev.target.innerHTML;
    this.props.updateData({ coreQuestion });
  }

  saveSubQuestion (i, ev) {
    ev.preventDefault();
    if (ev.which === 13) { ev.preventDefault(); }
    const subQuestions = this.state.subQuestions;
    subQuestions[i] = ev.target.value;
    this.updateSubQuestions(subQuestions, true);
  }

  mainQuestionPaste (ev) {
    ev.preventDefault();
    const text = (ev.originalEvent || ev).clipboardData.getData("text/plain");
    const temp = document.createElement("div");
    temp.innerHTML = text;
    document.execCommand("insertHTML", false, temp.textContent);
  }

  removeSubQuestion(i, ev) {
    // BUG: defaultValue doesn't rerender on state change
    ev.preventDefault();
    const subQuestions = this.state.subQuestions;
    subQuestions.splice(i, 1);
    this.updateSubQuestions(subQuestions, true);
  }

  addNewSubQuestion (ev) {
    ev.preventDefault();
    const subQuestions = this.state.subQuestions;
    subQuestions.push("")
    this.updateSubQuestions(subQuestions, false);
  }

  updateSubQuestions(subQuestions, updateData = false) {
    this.setState({ subQuestions });

    if (updateData) {
      this.props.updateData({ subQuestions });
    }
  }

  render() {
    return (
      <div className={cssClassParent}>
        <label className="form__label">
          Main question
        </label>

        <div
          className={`${cssClassParent}__mainQuestion`}
          contentEditable="true"
          onPaste={this.mainQuestionPaste.bind(this)}
          onKeyPress={this.preventNewLine.bind(this)}
          onKeyUp={this.saveCoreQuestion.bind(this)}
        >
          {this.props.coreQuestion}
        </div>
        
        {this.state.subQuestions.length !== 0 && (
          <div>
            <label className="form__label">
              Subquestions
            </label>

            <ol className={`${cssClassParent}__subQuestions`}>
              {this.state.subQuestions.map((q, i) => (
                <li key={i} className={`${cssClassParent}__subQuestion`}>
                  <input
                    type="text"
                    defaultValue={this.state.subQuestions[i]}
                    onKeyPress={this.subQuestionReturn.bind(this)}
                    onKeyUp={this.saveSubQuestion.bind(this, i)}
                    className={`${cssClassParent}__subQuestion__field`}
                  />
                  <button
                    className={`${cssClassParent}__subQuestion__remove`}
                    onClick={this.removeSubQuestion.bind(this, i)}
                  >
                    x
                  </button>
                </li>
              ))}
            </ol>
            
          </div>
        )}

        {this.state.subQuestions.length <= 3 && (
          <a
            className="u-btn u-btn--mini"
            onClick={this.addNewSubQuestion.bind(this)}
          >
            Add subquestion
          </a>
        )}
      </div>
    )
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
