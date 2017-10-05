import adminNav from './admin/admin-nav';
import adminSlugger from './admin/admin-slugger';
import resourceTypeSelector from './admin/admin-resource-type-selector';
import renderResourceUploader from './admin/admin-resource-uploader';
import renderFeatureImageSelector from './admin/feature_image_selector';
import SirTrevor from 'sir-trevor';
import ButtonBlock from './admin/sir-trev/button_block';
import ImageBlock from './admin/sir-trev/image_block';

adminNav();
resourceTypeSelector();

renderFeatureImageSelector('.r-featureImageSelector');
renderResourceUploader('.r-resource-upload');

const slugFields = document.querySelectorAll('.js-slug-field');
if (slugFields) {
  slugFields.forEach(f => adminSlugger(f));
}

const editor = document.querySelector('.js-st');
if (editor) {

  SirTrevor.Blocks.Image = ImageBlock;
  SirTrevor.Blocks.Quote.prototype.textable = false;
  SirTrevor.Blocks.Quote.prototype.toolbarEnabled = true;
  SirTrevor.Blocks.Button = ButtonBlock;
  SirTrevor.Blocks.Button = ButtonBlock;

  SirTrevor.setDefaults({
    iconUrl: window.__assets.externalSirTrevorIcons,
    uploadUrl: '/admin/resources/upload',
    ajaxOptions: {
      credentials: 'include'
    }
  });

  let blockTypes = [
    'Text',
    'List',
    'Quote',
    'Image',
    'Video',
    'Button'
  ];

  let sirTrev = new SirTrevor.Editor({
    el: editor,
    defaultType: 'Text',
    blockTypes
  });
}
