import React, { Component } from 'react';
import PropTypes from 'prop-types';

export default class Preview extends Component {
  updateType (event) {
    this.props.updateData({ type: event.target.value });
  };

  updateCaption (event) {
    this.props.updateData({ caption: event.target.value });
  };

  render () {
    return (
      <div>
        <img src={this.props.file.url} className="image-block__preview" />
        
        <div className="image-popup__info">
        <label className="st-input-label">Image caption</label>
          <textarea
            className="st-block-textarea"
            value={this.props.caption}
            onChange={this.updateCaption.bind(this)}
          />
        </div>

        <label className="st-input-label">Image Alignment</label>
        <select 
          className="form__input form__input--select"
          value={this.props.type}
          onChange={this.updateType.bind(this)}>
          <option value="inline">Inline (default)</option>
          <option value="full-width">Full width</option>
          <option value="float-left">Floating left</option>
          <option value="float-right">Floating right</option>
        </select>
      </div>
    );
  }
}

Preview.propTypes = {
  caption: PropTypes.string.isRequired,
  file: PropTypes.object.isRequired,
  type: PropTypes.string.isRequired,
  updateData: PropTypes.func.isRequired
};
