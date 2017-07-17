import React from 'react'
import ReactDOM from 'react-dom';
import PropTypes from 'prop-types'

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

        <h2>Lead image</h2>
        <img src={this.state.imageSrc} className={`${cssClassParent}__preview`} />
        <button className={`${cssClassParent}__btn`}
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
          <ImageUploader
            onComplete={this.setSelectedImage.bind(this)}
          />
        )}
      </div>
    )
  }
}

class ImageUploader extends React.Component {

  constructor() {
    super();
    this.state = {
      errors: [],
      status: null
    }

    // Used to prevent child elements of the drop area stealing focus
    this.dragCounter = 0;
  }


  handleDragEnter (e) {
    if (this.dragCounter== 0){
      e.target.classList.add('is-hovering');
      e.target.style.backgroundImage = null;
      this.setState({
        errors: [],
        status: undefined
      });
    }
    this.dragCounter++;
  }

  handleDragExit (e) {
    this.dragCounter--;
    if (this.dragCounter==0) {
      e.target.classList.remove('is-hovering');
    }
  }

  handleDragOver (e) {
    e.preventDefault();
    e.stopPropagation();
  }

  handleDrop (e) {
    e.stopPropagation();
    e.preventDefault();
    
    const target = e.target;
    let image = undefined;

    this.dragCounter = 0;
    target.classList.remove('is-hovering');

    if (e.dataTransfer !== undefined) {
      image = e.dataTransfer.files[0];
    }

    if (target.files !== undefined) {
      image = target.files[0];
    }

    if (image === undefined) { return; }

    function validateType(image) {
      return new Promise((resolve, reject) => {
        if (!image.type.match('image.(?:jpg|jpeg|png)')) {
          reject(`File uploaded must be an JPG or PNG but was ${image.type}`)
        } else {
          resolve(true);
        }
      });
    }

    function validateImagePxSize(image) {
      return new Promise((resolve, reject) => {
        const preview = new FileReader();
        preview.readAsDataURL(image);

        preview.onload = function (pr) {
          const dimension_test = new Image();
          dimension_test.src = pr.target.result;

          dimension_test.onload = function() {
            if (this.width < 2560 || this.height < 1000) {
              reject(`Image must be bigger than 2560x1000px, but instead was ${this.width}x${this.height}px.`)
            } else {
              const dropArea = document.querySelector(`.${cssClassParent}__popup__upload`);
              dropArea.style.backgroundImage = `url(${dimension_test.src})`;
              resolve(true);
            }
          };
        }
      });
    }

    validateType(image)
      .then(res => {
        return validateImagePxSize(image);
      })
      .then(res => {
        this.setState({status: "Uploading…"});

        const data = new FormData();
        const uid = ['graphic', (new Date()).getTime(), 'raw'].join('-');

        data.append('attachment[file]', image);
        data.append('attachment[name]', image.name);
        data.append('attachment[uid]', uid);

        const graphicUpload = fetch('/admin/graphics', {
          credentials: 'include',
          method: 'POST',
          body: data
        });

        graphicUpload
        .then(res => {
          if (res.status > 300) {
            return res.json()
            .then(json => {
              const err = new Error(json[0]);
              err.res = res;
              throw err;
            });
          }

          return res.json();
        })
        .then(json => {
          const image_id = json['id'];

          this.setState({
            status: 'Complete',
            errors: undefined,
          });

          // set selected image
          this.props.onComplete(image_id, json);
        })
        .catch(err => {
          this.setState({
            errors: this.state.errors.concat(err.message),
            status: 'Upload failed'
          });
        });


      })
      .catch(error => {
        this.setState({
          errors: this.state.errors.concat(error)
        });
      });

  }

  render () {
    const errors = (this.state.errors || []).map(
      (err, i) => (
        <p key={i}>{err}</p>
      )
    );

    return (
      <div
        className={`${cssClassParent}__popup__upload`}
        onDragEnter={this.handleDragEnter.bind(this)}
        onDragLeave={this.handleDragExit.bind(this)}
        onDragOver={this.handleDragOver.bind(this)}
        onDrop={this.handleDrop.bind(this)}
      >
        Drag the image you want to upload

        <input
          id="dropzone-file-field"
          onChange={this.handleDrop.bind(this)}
          type="file"
        />
        <label
          htmlFor="dropzone-file-field"
          className="tour-editor__form__imageUpload__label"
        >
          Upload
        </label>

        { errors && (
          <div>
            { errors }
          </div>
        )}

        { this.state.status && (
          <div>{this.state.status}</div>
        )}
      </div>
    )
  }
}

ImageUploader.propTypes = {
  onComplete: PropTypes.func.isRequired
};

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
