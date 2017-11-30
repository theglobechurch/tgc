import sirTrevorInit from './sir-trev/sirtrev_setup';
let stInstance = null;

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
    "recording":['title', 'upload', 'introduction', 'author', 'display_date', 'bible_ref', 'grouping', 'slug'],
    "blog":     ['title', 'body', 'introduction', 'author', 'display_date', 'bible_ref', 'grouping', 'slug'],
    "download": ['title', 'upload', 'introduction', 'bible_ref', 'lead_image', 'grouping'],
    "link":     ['title', 'external_reference', 'introduction', 'bible_ref', 'grouping'],
    "one21":    ['body']
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

  sirTrevSetUp(resourceType);
}

function sirTrevSetUp(resourceType = null) {
  const blocksForType = {
    "blog": ['Text', 'List', 'Quote', 'Image', 'Video', 'Button'],
    "one21":['Text', 'Question']
  };

  if (stInstance !== null) {
    stInstance.destroy();
    document.querySelector('.js-st').value = "";
    stInstance = null;
  }

  if (!(resourceType in blocksForType)) { return; }

  stInstance = sirTrevorInit('.js-st', blocksForType[resourceType]);
}
