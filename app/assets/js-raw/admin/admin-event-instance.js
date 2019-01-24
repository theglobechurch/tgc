import React from 'react';
import ReactDOM from 'react-dom'
import moment from 'moment';
import {DatetimePickerTrigger} from 'rc-datetime-picker';

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

export default function (el) {

  const containers = document.querySelectorAll(el);
  createDatePickers(containers);

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
    
    return e.preventDefault();
  });

  event_instance_container.addEventListener('click',function(e){
    if(e.target && e.target.classList.contains('js-remove-event-instance-btn')){
      removeEventInstance(e)
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
