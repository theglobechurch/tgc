export default function () {

  const addBtn = document.querySelector('.js-add-event-instance-btn');
  const event_instance_container = document.querySelector('.js-event_instances');

  addBtn.addEventListener('click', function(e){
    const time = new Date().getTime();
    const re = new RegExp(e.target.dataset.id, 'g');
    let fields = e.target.dataset.fields.replace(re, time);

    // convert string into DOM nodes
    fields = document.createRange().createContextualFragment(fields);
    
    event_instance_container.appendChild(fields);

    return e.preventDefault();
  });

}
