import React from 'react';
import ReactDOM from 'react-dom';
import PropTypes from 'prop-types';
import NewLocation from './new_location';

export class LocationField extends React.Component {

  constructor(props) {
    super(props);

    this.state = {
      locations: this.props.locations,
      locationId: this.props.locationId,
      newLocation: false
    }
  }

  cancelCallback() {
    this.setState(prevState => ({
      newLocation: !prevState.newLocation
    }));
  }

  addLocationCallback(location_obj) {
    // When recieving the new location…
    console.log(location_obj);
    
    // 1.  add new location to this.state.locations
    const l = this.state.locations;
    l.push(location_obj)
    
    // 2. this.saveLocation with the new id
    this.props.confirmLocation(parseInt(location_obj.id));

    // 3. Update state and close the popup
    this.setState(prevState => ({
      locations: l,
      locationId: parseInt(location_obj.id),
      newLocation: !prevState.newLocation
    }));
  }

  btnAddLocation(ev) {
    ev.preventDefault();
    this.setState(prevState => ({
      newLocation: !prevState.newLocation
    }));
  }

  saveLocation(ev) {
    const newLocationId = ev.target.value;
    this.props.confirmLocation(newLocationId);
    this.setState({locationId: newLocationId});
  }

  render() {
    return (
      <div>
        { this.state.newLocation && (
          <NewLocation
            cancelCallback={this.cancelCallback.bind(this)}
            callback={this.addLocationCallback.bind(this)}
            />
        )}

        <div className="form__field form__field--main">
          <label htmlFor="location" className="form__label">
            {this.props.name}
          </label>
          
          <select name="location" className="form__input form__input--select" onChange={this.saveLocation.bind(this)} value={this.state.locationId}>
            <option value="0" disabled>Please select location</option>
            { this.state.locations.map((l, i) => (
              <option value={l.id} key={i}>
                {l.location_str}
              </option>
            ))}
          </select>

          <button className="u-btn u-btn--mini" onClick={this.btnAddLocation.bind(this)}>Add new location</button>
        </div>

      </div>
    )
  }

}

LocationField.propTypes = {
  name: PropTypes.string.isRequired,
  locationId: PropTypes.number,
  locations: PropTypes.array.isRequired,
  confirmLocation: PropTypes.func.isRequired
}

LocationField.defaultProps = {
  locationId: 0,
  locations: []
}

export default function (selector) {
  const container = document.querySelector(selector);
  if (!container) { return; }

  function callback(location_id) {
    document.getElementById(container.dataset.inputid).value = location_id;
  }

  ReactDOM.render(
    <LocationField
      {...container.dataset}
      locations={(JSON.parse(container.dataset.locations) || [])}
      locationId={(parseInt(container.dataset.currentlocationid) || 0)}
      confirmLocation={callback}
    />
  , container);
}
