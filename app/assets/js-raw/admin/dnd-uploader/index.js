import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

const cssClassParent = "m-dnd-uploader"

export default class DnDUploader extends React.Component {

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
    let f = undefined;

    this.dragCounter = 0;
    target.classList.remove('is-hovering');

    if (e.dataTransfer !== undefined) {
      f = e.dataTransfer.files[0];
    }

    if (target.files !== undefined) {
      f = target.files[0];
    }

    if (f === undefined) { return; }

    function validateType(f, validTypes) {
      return new Promise((resolve, reject) => {
        if (!f.type.match(`(?:${validTypes})`)) {
          reject(`File uploaded must be one of [${validTypes.replace('|',', ')}] but was ${f.type}`)
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
              const dropArea = document.querySelector(`.${cssClassParent}`);
              dropArea.style.backgroundImage = `url(${dimension_test.src})`;
              resolve(true);
            }
          };
        }
      });
    }

    validateType(f, this.props.validTypes)
      .then(res => {
        // If we're sending up an image, make sure it is a valid size
        if (this.props.validTypes.indexOf('image') !== -1) {
          return validateImagePxSize(f);
        }
      })
      .then(res => {
        this.setState({status: "Uploading…"});

        const data = new FormData();
        const uid = ['fileupload', (new Date()).getTime(), 'raw'].join('-');

        data.append('upload_type', this.props.uploadType);
        data.append('attachment[file]', f);
        data.append('attachment[name]', f.name);
        data.append('attachment[uid]', uid);

        const graphicUpload = fetch(this.props.uploadPath, {
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
          const file_id = json['id'];

          this.setState({
            status: 'Complete',
            errors: undefined,
          });

          // set selected
          this.props.onComplete(file_id, json);
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
        className={`${cssClassParent}`}
        onDragEnter={this.handleDragEnter.bind(this)}
        onDragLeave={this.handleDragExit.bind(this)}
        onDragOver={this.handleDragOver.bind(this)}
        onDrop={this.handleDrop.bind(this)}
      >
        Drag the file you want to upload

        <input
          id='dropzone-file-field'
          className={`${cssClassParent}--uploadField`}
          onChange={this.handleDrop.bind(this)}
          type="file"
        />
        <label
          htmlFor="dropzone-file-field"
          className={`${cssClassParent}--btnUpload`}
        >
          or select
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

DnDUploader.defaultProps = {
  validTypes: 'image.jpg|image.jpeg|image.png'
}

DnDUploader.propTypes = {
  onComplete: PropTypes.func.isRequired,
  uploadPath: PropTypes.string.isRequired,
  uploadType: PropTypes.string,
  validTypes: PropTypes.string
};
