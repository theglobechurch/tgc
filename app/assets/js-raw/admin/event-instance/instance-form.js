import React from 'react';
import PropTypes from 'prop-types';
import moment from 'moment';

export default class InstanceForm extends React.Component {

  constructor(props) {
    super(props);
    const { startDate, endDate } = this.props.eventData;
    this.state = {
      overrideEventData: false,
      startDate: startDate,
      endDate: endDate
    }
  }

  componentWillReceiveProps(nextProps) {
    const { startDate, endDate } = nextProps.eventData;
    this.setState({ startDate, endDate });
  }

  toggleDataOverride (e) {
    if (e) { e.preventDefault(); }
    this.setState({overrideEventData: !this.state.overrideEventData})
  }

  removeInstance (e) {
    if (e) { e.preventDefault(); }
    this.props.removeInstance(this.props.id);
  }

  updateInstance (changedData) {
    const instanceData = Object.assign(this.props.eventData, changedData);
    console.log(instanceData);
    this.props.updateInstance(this.props.id, instanceData);
  }

  changeStartDate (e) {
    const startDate = e.target.value;
    let endDate = this.state.endDate;
    if (!endDate || moment(startDate).isAfter(endDate)) {
      endDate = startDate
    }
    this.updateInstance({startDate, endDate});
  }

  changeEndDate (e) {
    const endDate = e.target.value;
    let startDate = this.state.startDate;
    if (!startDate || moment(endDate).isBefore(startDate)) {
      startDate = endDate
    }
    this.updateInstance({startDate, endDate});
  }

  changeStartHour (e) {
    let startHour = e.target.value;
    startHour = this.validateTime(startHour, "hour");
    this.updateInstance({startHour});
  }

  changeStartMinute (e) {
    let startMinute = e.target.value;
    startMinute = this.validateTime(startMinute, "minute");
    this.updateInstance({startMinute});
  }

  changeEndHour (e) {
    let endHour = e.target.value;
    endHour = this.validateTime(endHour, "hour");
    this.updateInstance({endHour});
  }

  changeEndMinute (e) {
    let endMinute = e.target.value;
    endMinute = this.validateTime(endMinute, "minute");
    this.updateInstance({endMinute});
  }

  validateTime(i, type="hour") {
    if (type == "hour" && i > 23) {
      i = 23;
    } else if (type == "minute" && i > 59) {
      i = 59;
    }

    if (i < 10) {
      i = `0${i}`;
    }

    return i;
  }

  render() {
    return (
      <section>
        <div className="">
          <div className="">
            <input type="date" value={this.state.startDate} onChange={this.changeStartDate.bind(this)} id={`startDate_${this.props.id}`}></input>
            <input type="number" value={this.state.startHour} onChange={this.changeStartHour.bind(this)} defaultValue="00" min={0} max={23} step={1}></input>
            <input type="number" value={this.state.startMinute} onChange={this.changeStartMinute.bind(this)} min={0} max={59} step={1}></input>
          </div>
          <div className="">
            <input type="number" value={this.state.endHouse} onChange={this.changeEndHour.bind(this)} min={0} max={23} step={1}></input>
            <input type="number" value={this.state.endMinute} onChange={this.changeEndMinute.bind(this)} min={0} max={59} step={1}></input>
            <input type="date" value={this.state.endDate} onChange={this.changeEndDate.bind(this)} id={`endDate_${this.props.id}`}></input>
          </div>
        </div>

        { this.state.overrideEventData && (
          <div>
            {/* <input type="text" placeholder="title"></input>
            <textarea placeholder="description" />
            <input type="text" placeholder="location"></input>
            <input type="text" placeholder="image"></input> */}

            <button onClick={this.removeInstance.bind(this)}>Delete instance</button>
          </div>
        )}

        <button onClick={this.toggleDataOverride.bind(this)}>Override Event Information</button>
      </section>
    );
  }

}

InstanceForm.PropTypes = {
  id: PropTypes.number.isRequired,
  eventData: PropTypes.object.isRequired,
  removeInstance: PropTypes.func.isRequired,
  updateInstance: PropTypes.func.isRequired
}
