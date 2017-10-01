import React from 'react';
import ReactDOM from 'react-dom';
import SirTrevor from 'sir-trevor';
import Image from './image';

const URL = window.URL || window.webkitURL;

export default SirTrevor.Blocks.Image.extend({

  loadData (data) {
    this.renderUi(data);
  },

  renderUi (props) {
    const setAndLoadData = this.setAndLoadData.bind(this);

    ReactDOM.render(
      <Image {...props} updateData={setAndLoadData} />,
      this.editor
    );
  },

  updateImage (imageUrl) {
    this.setAndLoadData({
      type: 'inline',
      file: {
        url: imageUrl
      },
      caption: ''
    });
  },

  onDrop (event) {
    const file = event.files[0];

    if (/image/.test(file.type)) {
      this.updateImage(URL.createObjectURL(file));

      this.loading();
      this.inputs.style.display = 'none';
      this.editor.style.display = 'block';

      this.uploader(file,
        data => {
          this.ready();
          this.setAndLoadData(data);
        },
        () => {
          this.ready();
          this.addMessage(window.i18n.t('blocks:image:upload_error'));
        }
      );
    }
  }

});
