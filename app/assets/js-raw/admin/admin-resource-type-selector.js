export default function () {
  
  const resourceTypeSelectorBtns = document.querySelectorAll('.js-resource-type-button');
  if (!resourceTypeSelectorBtns.length) { return; }

  const resourceTypeField = document.querySelector('.js-resource-type-field');

  // Set default state
  resourceTypeSelectorBtns.forEach(btn => {
    if (btn.dataset.value == resourceTypeField.value) {
      btn.classList.add('is-selected');
    }
  });
  
  pageChanges(resourceTypeField.value);

  resourceTypeSelectorBtns.forEach(el => {
    el.addEventListener('click', (e) => {
      e.preventDefault();

      if (!el.classList.contains('is-selected')) {
        pageChanges(el.dataset.value);
        resourceTypeField.value = el.dataset.value;

        resourceTypeSelectorBtns.forEach(btn => {
          btn.classList.remove('is-selected');
        });

        el.classList.add('is-selected')
      }

    });
  });
}

function pageChanges(resourceType = null) {

  // Different resource types need to have different fields displayed
  const displayedFields = {
    "recording":  ['title', 'upload', 'introduction'],
    "blog":       ['title', 'body', 'introduction'],
    "download":   ['title', 'upload', 'introduction'],
    "link":       ['title', 'external_reference', 'introduction']
  }
  const allResourceFields = document.querySelectorAll('.js-resource-field');

  if (displayedFields[resourceType]) {
    allResourceFields.forEach(el => {
      if (displayedFields[resourceType].includes(el.dataset.name)) {
        el.classList.remove('is-hidden');
      } else {
        el.classList.add('is-hidden');
      }
    });
  } else {
    allResourceFields.forEach(el => {
      el.classList.add('is-hidden');
    });
  }

}
