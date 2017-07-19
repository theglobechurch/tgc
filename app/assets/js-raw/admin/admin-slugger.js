import slugger from 'slugger';

export default function (slugInput) {

  const onChangeCallback = ev => {
    slugInput.value = slugger(ev.target.value, {smartTrim: 50});
  }

  const slugSource = document.getElementById(slugInput.dataset.fromInputId);

  slugSource.addEventListener('keyup', onChangeCallback);

  // Don't change the field if the user starts to edit it
  slugInput.addEventListener(
    'keydown',
    ()=> slugSource.removeEventListener('keyup', onChangeCallback)
  );

}
