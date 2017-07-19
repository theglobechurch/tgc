import adminNav from './admin/admin-nav';
import adminSlugger from './admin/admin-slugger';
import resourceTypeSelector from './admin/admin-resource-type-selector';
import renderResourceUploader from './admin/admin-resource-uploader';
import renderFeatureImageSelector from './admin/feature_image_selector';

adminNav();
resourceTypeSelector();

renderFeatureImageSelector('.r-featureImageSelector');
renderResourceUploader('.r-resource-upload');

const slugFields = document.querySelectorAll('.js-resource-slug-field');
if (slugFields) {
  slugFields.forEach(f => adminSlugger(f));
}
