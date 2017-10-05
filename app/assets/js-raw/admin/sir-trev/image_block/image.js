import React, { Component } from 'react';
import PropTypes from 'prop-types';
import Preview from './preview';

export default class Image extends Component {
  updateType (type) {
    this.props.updateData({ type });
  };

  render () {
    console.log(this.props);
    return (
      <div className="image-block">
        <Preview
          caption={this.props.caption}
          file={this.props.file}
          type={this.props.type}
          updateData={this.props.updateData}
        />
      </div>
    );
  }
}

Image.propTypes = {
  type: PropTypes.string.isRequired,
  file: PropTypes.object.isRequired,
  updateData: PropTypes.func.isRequired
};
