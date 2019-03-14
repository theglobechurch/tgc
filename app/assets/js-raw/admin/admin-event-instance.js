import React from 'react';
import ReactDOM from 'react-dom'
import moment from 'moment';
import DatePicker from 'react-datepicker';
import { LocationField } from './location_field';
import { FeatureImageSelector } from './feature_image_selector';

class Picker extends React.Component {
  constructor(props) {
    super(props);
    let dt = '';

    if (this.props.initVal !== undefined && this.props.initVal != "") {
      dt = moment(this.props.initVal, 'YYYY-MM-DD HH:mm:ss').toDate();
    }

    this.state = { dt };
    this.handleChange = this.handleChange.bind(this);
  }

  handleChange(dt) {
    this.setState({ dt });
    this.props.onComplete(moment(dt).format('YYYY-MM-DD HH:mm'));
  }

  render() {
   
    // Future: https://reactdatepicker.com/#example-22
    const inputProps = {
      // [this.props.pickerRange]: true,
    }
    
    return (
      <DatePicker
          { ...inputProps }
          className="form__input"
          selected={this.state.dt || new Date()}
          onChange={this.handleChange}
          showTimeSelect
          timeFormat= "HH:mm"
          dateFormat= "d MMM YYYY HH:mm"
          timeIntervals={15}
          timeCaption='Time'
      />
    );
  }
}

export default function () {
  const dtPicker = document.querySelectorAll('.r-datetimePicker');
  createDatePickers(dtPicker);

  const locationPickers = document.querySelectorAll('.r-ei-locationPicker');
  createLocationPickers(locationPickers);

  const imagePickers = document.querySelectorAll('.r-ei-imagePicker');
  createFeaturedImagePickers(imagePickers);

  // Hide all additional info by default
  const hideBtn = document.querySelectorAll('.js-toggle-event-details');
  hideBtn.forEach((el) => toggleEventInstanceDetails(el))

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
    createLocationPickers(locationPickers);

    const imagePickers = document.querySelectorAll('.r-ei-imagePicker');
    createFeaturedImagePickers(imagePickers);  
    
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

  console.log(els);

  els.forEach((el) => {
    const targetInput = document.querySelector('.' + el.dataset.inputid);
    const startStop = el.classList.contains('js-date-start') ? 'selectsStart' : 'selectsEnd'

    function callback(dt) {
      targetInput.value = dt;
    }

    ReactDOM.render(
      <Picker
        pickerRange={startStop}
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

function createFeaturedImagePickers(els) {
  if (!els) { return; }

  els.forEach((el) => {
    function callback(graphic_id) {
      document.getElementById(el.dataset.inputid).value = graphic_id;
    }

    ReactDOM.render(
      <FeatureImageSelector
          {...el.dataset}
          onPickImage={callback}
          imagesrc={el.dataset.selectedimagethumbnail}
        />
      , el);
  });
}

function toggleEventInstanceDetails(el) {
  const ei = el.dataset.ei;
  const lbl = el.innerHTML === 'Hide event details' ? 'Show event details' : 'Hide event details';
  document.querySelector(`.js-event-overrides-${ei}`).classList.toggle('ani-slide--closed');
  el.innerHTML = lbl;
}
