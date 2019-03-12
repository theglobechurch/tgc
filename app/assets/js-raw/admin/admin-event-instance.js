import React from 'react';
import ReactDOM from 'react-dom'
import moment from 'moment';
import {DatetimePickerTrigger} from 'rc-datetime-picker';
import {LocationField} from './location_field';

class Picker extends React.Component {
  constructor(props) {
    super(props);
    let mo = '';

    if (this.props.initVal !== undefined && this.props.initVal != "") {
      mo = moment(this.props.initVal, 'YYYY-MM-DD HH:mm:ss');
    }
    
    this.state = {
      moment: mo
    };
  }

  handleChange(moment){
    this.setState({
      moment
    });
    this.props.onComplete(moment.format('YYYY-MM-DD HH:mm'));
  }

  render() {
    const mo = this.state.moment;
    const display = mo ? mo.format('DD MMM YYYY HH:mm') : "";

    return (
      <DatetimePickerTrigger
        moment={mo ? mo : moment()}
        onChange={this.handleChange.bind(this)}>
        <input type="text" value={display} readOnly className="form__input" />
      </DatetimePickerTrigger>
    );
  }
}

export default function () {
  const dtPicker = document.querySelectorAll('.r-datetimePicker');
  createDatePickers(dtPicker);

  const locationPickers = document.querySelectorAll('.r-ei-locationPicker');
  createLocationPickers(locationPickers)


  const addBtn = document.querySelector('.js-add-event-instance-btn');
  if (addBtn === null) { return false; }

  const event_instance_container = document.querySelector('.js-event_instances');

  addBtn.addEventListener('click', function(e){
    const time = new Date().getTime();
    const re = new RegExp(e.target.dataset.id, 'g');
    let fields = e.target.dataset.fields.replace(re, time);

    // convert string into DOM nodes
    fields = new DOMParser().parseFromString(fields, 'text/html');
    fields = fields.body.firstChild
    event_instance_container.appendChild(fields);
    const els = fields.querySelectorAll('.r-datetimePicker');
    createDatePickers(els);
    const locationPickers = document.querySelectorAll('.r-ei-locationPicker');
    createLocationPickers(locationPickers)
    
    return e.preventDefault();
  });

  event_instance_container.addEventListener('click',function(e){
    if(e.target && e.target.classList.contains('js-remove-event-instance-btn')){
      removeEventInstance(e);
    }

    if(e.target && e.target.classList.contains('js-toggle-event-details')){
      toggleEventInstanceDetails(e.target);
      return e.preventDefault();
    }
  });

}

function removeEventInstance(e) {
  const ei = e.target.dataset.ei;
  document.querySelector(`.js-delete-${ei}`).value = true;
  document.querySelector(`.js-ei-${ei}`).classList.add('ani-slide--closed');
  return e.preventDefault();
};  


function createDatePickers(els) {
  if (!els) { return; }

  els.forEach((el) => {
    const targetInput = document.querySelector('.' + el.dataset.inputid);

    function callback(dt) {
      targetInput.value = dt;
    }

    ReactDOM.render(
      <Picker
        initVal={targetInput.value}
        onComplete={callback}
      />,
      el
    );
  });
}

function createLocationPickers(els) {
  if (!els) { return; }

  els.forEach((el) => {
    function callback(location_id) {
      document.getElementById(el.dataset.inputid).value = location_id;
    }

    ReactDOM.render(
      <LocationField
        {...el.dataset}
        locations={(JSON.parse(el.dataset.locations) || [])}
        locationId={(parseInt(el.dataset.currentlocationid) || 0)}
        confirmLocation={callback}
      />
    , el)
  });
}

function toggleEventInstanceDetails(el) {
  const ei = el.dataset.ei;
  const lbl = el.innerHTML === 'Hide event details' ? 'Show event details' : 'Hide event details';
  document.querySelector(`.js-event-overrides-${ei}`).classList.toggle('ani-slide--closed');
  el.innerHTML = lbl;
}
