import React from 'react';
import ReactDOM from 'react-dom';
import PropTypes from 'prop-types';
import InstanceForm from './instance-form';

class EventInstance extends React.Component {

  constructor(props) {
    super(props)
    this.state = {
      events: [{}]
    }
  }

  newInstance(e) {
    e.preventDefault();
    const events = this.state.events;
    if (events.length > 0) {
      const eClone = JSON.parse(JSON.stringify(events[events.length - 1]));
      events.push(eClone);
    } else {
      events.push({});
    }
    this.setState({events});
  }

  updateInstance(id, instanceData) {
    const events = this.state.events;
    events[id] = instanceData;
    this.setState({events});
  }

  removeInstance(id, e) {
    if (e) {e.preventDefault()}
    const events = this.state.events;

    if (events.length > 1) {
      events.splice(id, 1);
      this.setState({events});
    }
  }

  render() {
    return (
      <div className="form__field form__field--main">

        { this.state.events.map((event, i) => (
          <InstanceForm
            key={i}
            id={i}
            eventData={event}
            removeInstance={this.removeInstance.bind(this)}
            updateInstance={this.updateInstance.bind(this)}
          />
        ))}

        <div>
          <button onClick={this.newInstance.bind(this)}>
            Add event instance
          </button>
        </div>

      </div>
    )
  }

}

EventInstance.PropTypes = {
  events: PropTypes.array,
  confirmData: PropTypes.func.isRequired
}

export default function(selector) {
  const container = document.querySelector(selector);

  if (!container) { return; }

  function callback(data) {
    console.log(data);
  }

  ReactDOM.render(
    <EventInstance
      {...container.dataset}
      confirmData={callback}
    />
  , container);

}
