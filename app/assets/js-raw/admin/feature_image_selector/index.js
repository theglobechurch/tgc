import React from 'react'
import ReactDOM from 'react-dom';
import PropTypes from 'prop-types'
import DnDUploader from '../dnd-uploader'

const cssClassParent = "m-featureImageSelector";

class FeatureImageSelector extends React.Component {

  constructor(props) {
    super(props);
    this.state = {
      popupOpen: false,
      imageSrc: props.imagesrc,
      imageId: props.imageid
    }
  }

  onTogglePopup (event) {
    event.preventDefault();
    this.setState({popupOpen: !this.state.popupOpen})
  }

  onSetImage (imageId, imageSrc, event) {
    document.getElementById(this.props.inputid).value = imageId;

    this.setState({
      imageSrc,
      imageId,
      popupOpen: false
    })
  }

  render() {
    
    let btnText = "Set image"
    if (this.props.imageId) {
      btnText = "Change image";
    }
    
    return (
      <div className={cssClassParent}>

        { this.state.popupOpen && 
          <Popup
            callback={this.props.onPickImage}
            onSetImage={this.onSetImage.bind(this)}
          />
        }

        <h2 className="form__label">Lead image</h2>
        { this.state.imageSrc && 
          <img src={this.state.imageSrc} className={`${cssClassParent}__preview`} />
        }
        <button className="u-btn u-btn--100"
                onClick={this.onTogglePopup.bind(this)}>
          {btnText}
        </button>
      </div>
    )
  }
}

// Make something better for this please:
FeatureImageSelector.defaultProps = {
  imageSrc: 'http://eadb.org/wp-content/uploads/2013/09/placeholder.jpg'
}

FeatureImageSelector.propTypes = {
  imageSrc: PropTypes.string,
  imageId: PropTypes.number
}


class Popup extends React.Component {

  constructor() {
    super();
    this.state = {
      selectedImageData: undefined,
      selectedImageId: undefined
    }
  }

  setSelectedImage (id, json, event) {
    if (event) { event.preventDefault(); }
    this.setState({
      selectedImageData: json.images,
      selectedImageId: id,
    });
  }

  onCancelSelection (event) {
    if (event){
      event.preventDefault();
    }
    this.setState({
      selectedImageData: undefined,
      selectedImageId: undefined
    });
  }

  onConfirmSelection(id, imageSrc, event) {
    if (event){
      event.preventDefault();
    }
    this.props.onSetImage(id, imageSrc)
  }

  render () {
    return (
      <div className={`${cssClassParent}__popup`}>

        { this.state.selectedImageId && this.state.selectedImageData && (
          <ConfirmPreview
            previewImage={this.state.selectedImageData['960']}
            cancelSelection={this.onCancelSelection.bind(this)}
            confirmSelection={this.onConfirmSelection.bind(this,
                                                           this.state.selectedImageId,
                                                           this.state.selectedImageData['960'])}
          />
        )}

        { !this.state.selectedImageId && (
          <DnDUploader
            validTypes='image.jpg|image.jpeg|image.png'
            uploadPath='/admin/graphics'
            onComplete={this.setSelectedImage.bind(this)}
          />
        )}
      </div>
    )
  }
}

class ConfirmPreview extends React.Component {
  render () {
    return (
      <div className={`${cssClassParent}__popup__preview`}>
        <img src={this.props.previewImage} alt="" />
        <button onClick={this.props.confirmSelection}>Confirm selection</button>
        <button onClick={this.props.cancelSelection}>Cancel selection</button>
      </div>
    )
  }
}

ConfirmPreview.propTypes = {
  previewImage: PropTypes.string.isRequired,
  confirmSelection: PropTypes.func.isRequired,
  cancelSelection: PropTypes.func.isRequired
}

export default function (selector) {
  const container = document.querySelector(selector);

  if (!container) { return; }

  function callback (image_id) {
    document.getElementById(container.dataset.inputId).value = image_id;
  }
  
  ReactDOM.render(
    <FeatureImageSelector
      {...container.dataset}
      onPickImage={callback}
    />
  , container);
}
