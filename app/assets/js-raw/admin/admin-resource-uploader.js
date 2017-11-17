import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import DnDUploader from './dnd-uploader'

const cssClassParent = 'm-resource-uploader'

class ResourceUploader extends React.Component {

  constructor(props) {
    super(props);
    this.state = {
      currentFilePath: this.props.fileSrc,
      currentFileType: this.props.fileType,
    }
  }

  setSelectedResource (id, json, ev) {
    if (ev) { ev.preventDefault(); }
    this.setState({
      currentFilePath: json.url,
      currentFileType: json.meta.type
    });
    this.props.onComplete(id);
  }

  onChangeUpload (ev) {
    if (ev) { ev.preventDefault(); }
    this.setState({
      currentFilePath: null,
      currentFileType: null
    });
  }

  render() {
    return (
      <div>
        { this.state.currentFilePath && (
          <div className="m-resource-preview">
            { this.state.currentFileType == 'audio' && (
              <div>
                <audio
                  src={this.state.currentFilePath}
                  preload='metadata'
                  controls
                  className="m-resource-preview__audio"
                />
                <button
                  onClick={this.onChangeUpload.bind(this)}
                  className="u-btn">
                  Change
                </button>
              </div>
            )}
          </div>
        )}

        { !this.state.currentFilePath && (
          <DnDUploader
              validTypes={this.props.validTypes}
              uploadPath='/admin/resources/upload'
              uploadType='audio_file'
              onComplete={this.setSelectedResource.bind(this)}
            />
        )}
      </div>
    )
  }

}

ResourceUploader.defaultProps = {
  validTypes: 'image.jpg|image.jpeg|image.png'
}

ResourceUploader.propTypes = {
  validTypes: PropTypes.string,
  currentFilePath: PropTypes.string
}

export default function (el) {
  const container = document.querySelector(el);

  if (!container) { return; }

  function callback (upload_id) {
    document.getElementById(container.dataset.inputId).value = upload_id;
  }

  ReactDOM.render(
    <ResourceUploader
      {...container.dataset}
      onComplete={callback}
    />
  , container)
}
