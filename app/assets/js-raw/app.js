import adminNav from './admin/admin-nav';
import adminSlugger from './admin/admin-slugger';
import adminEventInstance from './admin/admin-event-instance';
import resourceTypeSelector from './admin/admin-resource-type-selector';
import renderResourceUploader from './admin/admin-resource-uploader';
import renderFeatureImageSelector from './admin/feature_image_selector';
import renderResourceSelector from './admin/admin-resource-selector';
import sirTrevorInit from './admin/sir-trev/sirtrev_setup';

adminNav();
adminEventInstance();
resourceTypeSelector();

renderFeatureImageSelector('.r-featureImageSelector');
renderResourceUploader('.r-resource-upload');
renderResourceSelector('.r-resourceSelector');
sirTrevorInit('.js-st--standard');

const slugFields = document.querySelectorAll('.js-slug-field');
if (slugFields) {
  slugFields.forEach(f => adminSlugger(f));
}
