import React, { Component } from 'react';
import PropTypes from 'prop-types'

export default class ButtonBlockContents extends Component {
  // static propTypes = {
  //   text: PropTypes.string,
  //   file: PropTypes.object,
  //   blockid: PropTypes.string,
  //   updateData: PropTypes.func.isRequired
  // };

  constructor () {
    super();
  }

  saveTitle (event) {
    const text = event.target.value;
    this.props.updateData({ text });
  }

  saveHref (event) {
    const href = event.target.value;
    this.props.updateData({ href });
  }

  render () {

    return (
      <section className="button-block st-globe-block">
        <header>
          Button
        </header>

        <div
          className="button-block__body st-globe-block__body"
        >

          <label className="st-input-label">Button text</label>
          <input
            type="text"
            defaultValue={this.props.text}
            onChange={this.saveTitle.bind(this)}
          />

          <label className="st-input-label">Button URL</label>
          <input
            type="text"
            defaultValue={this.props.href}
            placeholder="URL"
            onChange={this.saveHref.bind(this)}
          />          

        </div>

      </section>
    );
  }

}
