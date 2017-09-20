import adminNav from './admin/admin-nav';
import adminSlugger from './admin/admin-slugger';
import resourceTypeSelector from './admin/admin-resource-type-selector';
import renderResourceUploader from './admin/admin-resource-uploader';
import renderFeatureImageSelector from './admin/feature_image_selector';
import SirTrevor from 'sir-trevor';

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

  SirTrevor.setDefaults({
    iconUrl: window.__assets.externalSirTrevorIcons,
    uploadUrl: '/admin/attachments',
    ajaxOptions: {
      credentials: 'include'
    }
  });

  let sirTrev = new SirTrevor.Editor({
    el: editor,
    defaultType: 'Text'
  });
}
